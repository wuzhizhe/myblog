<template>
	<div class="write-blog-container">
		<div class="text-editor" ></div>
		<button @click="getContent()">获取数据</button>
		<button @click="saveContent()">保存数据</button>
		<div class="content-show" v-html="content"></div>
		<input type="file" style="display:none;" ref="uploadimagefile" multiple accept="image/*" @change="uploadImage()">
		<div class="upload">上传？？？</div>
	</div>
</template>
<script>
	import blogheader from './common/header.vue'
	import Quill from 'quill'
	import '../../node_modules/quill/dist/quill.core.css'
	import '../../node_modules/quill/dist/quill.bubble.css'
	import '../../node_modules/quill/dist/quill.snow.css'
	export default {
		components: {
			
		},
		mounted() {
			let toolbarOptions = [
			  ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
			  ['blockquote', 'code-block'],

			  [{ 'header': 1 }, { 'header': 2 }],               // custom button values
			  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
			  [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
			  [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
			  [{ 'direction': 'rtl' }],                         // text direction

			  [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
			  [{ 'header': [1, 2, 3, 4, 5, 6, false] }],

			  [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
			  [{ 'font': [] }],
			  [{ 'align': [] }],

			  ['clean']                                         // remove formatting button
			];
			this.quill = new Quill('.text-editor', {
				modules: {
					toolbar: {
						container: [ ['bold', 'italic', 'underline', 'strike'], ['image']],
						handlers: {
							image: this.imageHandler
						}
					}
				},
				theme: 'snow'
			});
		},
		data() {
			return {
				text: '',
				content: ''
			}
		},
		methods: {
			getContent() {
				this.content = this.quill.container.firstChild.innerHTML;
			},
			imageHandler(image, callback) {
				this.$refs.uploadimagefile.click();
			},
			uploadImage() {
				let _this = this;
				let postArray = [];
				let files = this.$refs.uploadimagefile.files;
				for (let i = 0; i < files.length; i++) {
				    let file = files[i];
				    let imageType = /^image\//;
				    
				    if (!imageType.test(file.type)) {
				      continue;
				    }
				    
				    let reader = new FileReader();
				    reader.onload = function(e) { 
			    		postArray.push({
			    			name: file.name,
			    			type: file.type,
			    			base64Str: e.target.result
			    		});
			    		if (i == files.length - 1) {
							_this.doUploadAndSet(postArray);
			    		}
			    	}; 
				    reader.readAsDataURL(file);
				}
			},
			doUploadAndSet(postArray) {
				let _this = this;
				global.services.uploadImage(JSON.stringify(postArray), {emulateJSON: true})
				.then((data) => {
					for (let j = 0; j < data.length; j++) {
						_this.quill.insertEmbed(j, 'image', global.domain + data[j].address, Quill.sources.USER);
					}
				}, (text) => {
					Myblog.messager.alert(text);
				})
			},
			saveContent() {
				let userinfo = JSON.parse(global.localStorage.getItem('userinfo'));
				let params = {
					blogname: '测试博客',
					userid: userinfo.id,
					tags: '',
					content: this.quill.container.firstChild.innerHTML
				}
			}
		}
	}
</script>
<style></style>