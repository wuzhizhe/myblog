<template>
	<div class="show-blog-container">
		<div class="show" v-if="show">
			<h2 class="blog-title">{{blog.blogname}}</h2>
			<div class="blog-content" v-html="blog.blogText"></div>
		</div>
		<div class="edit-icon" @click="gotoWrite()"></div>
		<div class="comments-container">
			<div class="comments-head">
				<span class="comments-nums">共2条评论</span>
				<div class="do-comment" @click="comment()">回复</div>
			</div>
			<div class="comment-item" v-for="item in comments">
				<span class="comments-username">{{item.username}}: </span>
				<span class="reply-comment" @click="replyCm(item.cmid)">回复</span>
				<div class="comments-content">{{item.content}}</div>
			</div>
		</div>
		<div class="comment-container">
			<textarea name="" @keyup.enter="onEnter" v-show="showCT" v-model="textareadata" rows="10" class="comment-area"></textarea>
			<!-- <button class="btn btn-lg btn-block comment-btn" @click="comment()">回复</button> -->
		</div>
	</div>
</template>
<script>
	let userinfo = JSON.parse(global.localStorage.getItem('userinfo'));
	import blogheader from './common/header.vue'
	export default {
		beforeCreate() {
			let _this = this;
			this.blogId = this.$route.params.id;
			_this.data = {
				show: false,
				textareadata: '',
				showCT: false,
				comments: [],
				blog: {}
			};
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
			},
			comment() {
				if (!this.textareadata.trim()) return;
				this.comments.push({
					username: userinfo.username,
					content: this.textareadata,
					cmid: new Date().getTime()
				})
				this.showCT = false;
			},
			onEnter(e) {
				if (e.ctrlKey && e.keyCode == 13) {
					this.comment();
				}
			},
			replyCm(id) {
				this.showCT =false;
				console.log(id);
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
	.comment-area {
		width: 100%;
	}
	.comment-btn {
		width: 100px;
	}
	.comment-container {
		margin-top: 20px;
	}
	.comments-content {
	    margin-top: 5px;
	}
	.reply-comment {
		float: right;
	    cursor: pointer;
	    color: blue;
	}
	.comments-head {
		font-size: 16px;
		height: 40px;
	}
	.do-comment {
	    float: right;
	    color: blue;
	    cursor: pointer;
	}
	.comments-container {
	    border-top: 1px solid #ddd;
    	padding-top: 20px;
	}
</style>
<style>
	.blog-content img {
		max-width: 100%;
	}

</style>