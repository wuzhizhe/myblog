<template>
	<div class="show-blog-container">
		<div class="show" v-if="show">
			<h2 class="blog-title">{{blog.blogname}}</h2>
			<div class="blog-content" v-html="blog.blogText"></div>
		</div>
	</div>
</template>
<script>
	export default {
		beforeCreate() {
			let _this = this;
			_this.data = {
				show: false,
				blog: {}
			};
			let userinfo = JSON.parse(global.localStorage.getItem('userinfo'));
			global.services.getBlog({
				blogid: this.$route.params.id
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
		}
	}
</script>
<style></style>