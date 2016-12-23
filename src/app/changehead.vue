<template>
	<div class="change-head-container">
		<div class="head-image-container">
			<img v-bind:src="imageSrc"  alt="" class="user-header-image">
		</div>
		<div class="upload-image-container">
			<button class="upload" @click="showUploadWindow()">{{i18uploadimage}}</button>
			<input type="file"  ref="uploadimagefile" class="upload-head-image" multiple accept="image/*" @change="uploadImage()" >
		</div>
	</div>
</template>
<script>
	import Vue from 'vue'
	import locales from '../locales'
	export default {
		beforeCreate() {
			let userinfo = JSON.parse(global.localStorage.getItem('userinfo'));
			this.data = {
				userinfo: userinfo,
				imageSrc: global.domain + userinfo.headimage
			};
			this.locales = locales[Vue.config.locale]['changehead'];
		},
		data() {
			return _.extend(this.data, this.locales);
		},
		methods: {
			showUploadWindow() {
				this.$refs.uploadimagefile.click();
			},
			uploadImage() {
				debugger;
				let _this = this;
				let files = this.$refs.uploadimagefile.files;
			    let file = files[0];
			    let imageType = /^image\//;
			    if (!imageType.test(file.type)) {
			      return;
			    }
			    let data = null;
			    let reader = new FileReader();
			    reader.onload = function(e) { 
		    		data = [{
		    			name: file.name,
		    			type: file.type,
		    			base64Str: e.target.result
		    		}];
		    		_this.doUploadAndSet(data);
		    	}; 
			    reader.readAsDataURL(file);
			},
			doUploadAndSet(postArray) {
				let _this = this;
				global.services.uploadImage({
					images: JSON.stringify(postArray),
					dir: 'headeimages'
				}, {

				})
				.then((data) => {
					_this.updateUserImage(data);
				}, (text) => {
					Myblog.messager.alert(text);
				})
			},
			updateUserImage(image) {
				let _this = this;
				
				global.services.updateheadimage({
					userId: _this.userinfo.id,
					imageUrl: image[0].address
				}, {
					emulateJSON: true
				})
				.then((data) => {
					_this.data.imageSrc = global.domain + data.headimage;
				}, (text) => {
					Myblog.messager.alert(text);
				});
			}
		}
	}
</script>
<style scoped>
	.upload-head-image {
		display: none;
	}
	.user-header-image {
		width: 100px;
		height: 100px;
	}
	.head-image-container {
		width: 100px;
	    height: 100px;
	    border-radius: 50%;
	    overflow: hidden;
	}
</style>