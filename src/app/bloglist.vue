<template>
	<div class="blog-list-container">
		<div class="show" v-if="show">
			<div class="blog-item-container" v-for="blog in blogs">
				<h2>{{blog.blogname}}</h2>
				<p>{{blog.status}}</p>
			</div>
		</div>
	</div>
</template>
<script>

	export default {
		beforeCreate() {
			let _this = this;
			_this.data = {
				show: false,
				blogs: []
			};
			let userinfo = JSON.parse(global.localStorage.getItem('userinfo'));
			global.services.getBlogList({
				userid: userinfo.id+ ''
			}, {})
			.then( (data) => {
				console.log(data);
				_this.data.blogs = data;
				_this.data.show = true;
			}, (text) => {
				Myblog.messager.alert(text);
				return {};
			});
		},
		data() {
			return this.data;
		},
		methods() {

		}
	}
</script>
<style>
	
</style>