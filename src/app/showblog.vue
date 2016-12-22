<template>
	<div class="show-blog-container">
		<div class="show" v-if="show">
			<h2 class="blog-title">{{blog.blogname}}</h2>
			<div class="blog-content" v-html="blog.blogText"></div>
		</div>
		<div class="edit-icon" @click="gotoWrite()"></div>
	</div>
</template>
<script>
	import blogheader from './common/header.vue'
	export default {
		beforeCreate() {
			let _this = this;
			this.blogId = this.$route.params.id;
			_this.data = {
				show: false,
				blog: {}
			};
			let userinfo = JSON.parse(global.localStorage.getItem('userinfo'));
			global.services.getBlog({
				blogid: this.blogId
			}, {})
			.then( (data) => {
				console.log(data);
				var blog = _.extend(data.blog, data.blogDetail);
				_this.data.blog = blog;
				_this.data.show = true;
			}, (text) => {
				Myblog.messager.alert(text);
				return {};
			});
		},
		data() {
			return this.data;
		},
		methods: {
			gotoWrite() {
				location.href = routesUrl.write + '/' + this.blogId
			}
		},
		components: {
			
		}
	}
</script>
<style scoped>
	.show-blog-container {
		margin: 10px;
	}
	.edit-icon {
		display: block;
		height: 40px;
		width: 40px;
		background: url('../images/icons/edit--100.png');
	    background-position: center;
	    background-repeat: no-repeat;
	    background-size: cover;
	    position: fixed;
	    top: 20px;
	    right: 20px;
	}
</style>
<style>
	.blog-content img {
		max-width: 100%;
	}
</style>