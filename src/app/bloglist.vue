<template>
	<div class="blog-list-container">
		<blog-header></blog-header>
		<div class="show" v-if="show">
			<ul class="blog-item-container" >
				<li v-for="blog in blogs"><a class="blog-item" v-bind:blogid="blog.id" @click="showBlog(blog.id)" >{{blog.blogname}}</a></li>
			</ul>
		</div>
	</div>
</template>
<script>
	import blogHeader from './common/header.vue'
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
				_this.data.blogs = data;
				_this.data.show = true;
			}, (text) => {
				Myblog.messager.alert(text);
				return {};
			});
		},
		components: {
			blogHeader
		},
		data() {
			return this.data;
		},
		methods: {
			showBlog(id) {
				location.href = routesUrl.showblog + '/' + id
			}
		}
	}
</script>
<style scoped>
	.blog-item {
		cursor: pointer;
	}
	.blog-list-container {
		padding: 0.7em;
	}
	.blog-item-container {
		padding-left: 5px;
	}
	.blog-item-container li {
		list-style: none;
		height: 2.25em;
		padding: 0.25em;
	}
</style>