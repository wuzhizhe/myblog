<template>
	<div class="show-blog-container">
		<div class="show" v-if="show">
			<h2 class="blog-title">{{blog.blogname}}</h2>
			<div class="blog-content" v-html="blog.blogText"></div>
		</div>
		<div class="edit-icon" @click="gotoWrite()"></div>
		<div class="comments-container">
			<div class="comments-head">
				<span class="comments-nums">共{{comments.length}}条评论</span>
				<div class="do-comment" @click="showComment()">评论</div>
			</div>
			<div class="" v-for="item in comments">
				<div v-html="item.content"></div>
				<!-- {{item.content | html}} -->
			<!-- 
				<span class="comments-username">{{item.username}}: </span>
				<span class="reply-comment" @click="replyCm(item.cmid)">回复</span>
				<div class="comments-content">{{item.content}}</div> -->
			</div>
		</div>
		<div class="comment-container">
			<textarea name="" @keyup.enter="onEnter" v-show="showCT" v-model="textareadata" rows="10" class="comment-area"></textarea>
			<button class="btn btn-lg btn-block comment-btn" v-show="showCT" @click="comment()">回复</button>
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
			global.services.getComments({
				blogId: this.blogId
			}, {})
			.then( (data) => {
				this.data.comments = data;
				setTimeout( () => {
					_this.replyEvent();
				}, 200)
			}, (text) => {
				Myblog.messager.alert(text);
				return {};
			});
		},
		data() {
			return this.data;
		},
		mounted() {
		},
		methods: {
			gotoWrite() {
				location.href = routesUrl.write + '/' + this.blogId
			},
			comment() {
				if (!this.textareadata.trim()) return;
				if (this.replyCmid) {
					this.commentTocm();
					return;
				}
				let cmid = new Date().getTime();
				let params = {
					blogId: this.blogId,
					content: '<div><div class="comment-item top-comment-item" data-topcm="'+ cmid +'" data-cmid="'+cmid+'">'+
							 '<span class="comments-username">'+ userinfo.username +'</span>'+
							 '<span class="reply-comment" data-cmid='+cmid+' ">回复</span>'+
							 '<div class="comments-content">'+ this.textareadata +'</div>'+
							 '</div></div>',
					userId: userinfo.id,
					cmid: cmid
				};
				global.services.saveComment(params, {})
				.then((data) => {
					console.log(data);
					this.comments.push({
						username: userinfo.username,
						content: this.textareadata,
						cmid: new Date().getTime()
					})
					this.showCT = false;
				}, (text) => {
					Myblog.messager.alert(text);
					return {};
				});

			},
			commentTocm() {
				let cmid = new Date().getTime();
				let wrapper = document.createElement('div');
				let content = '<div class="comment-item-recm" data-cmid="'+cmid+'">'+
							 '<span class="comments-username">回复: '+ userinfo.username +'</span>'+
							 '<span class="reply-comment" data-cmid='+cmid+' ">回复</span>'+
							 '<div class="comments-content">'+ this.textareadata +'</div>'+
							 '</div>';
				wrapper.innerHTML = content;
				let element = wrapper.firstChild;
				debugger;
				let insertEl = document.querySelector('div[data-cmid="'+ this.crtReplyTarget.closest('.comment-item').dataset.cmid +'"]');
				insertEl.parentNode.insertBefore(element, insertEl.nextSibling);
				let replyCM = insertEl.closest('.top-comment-item');

				let params = {
					blogId: this.blogId,
					content: replyCM.parentNode.outerHTML,
					userId: userinfo.id,
					cmid: replyCM.dataset.topcm
				};

				global.services.updateComment(params, {})
				.then((data) => {
					console.log(data);
					this.showCT = false;
				}, (text) => {
					Myblog.messager.alert(text);
					return {};
				});
			},
			onEnter(e) {
				if (e.ctrlKey && e.keyCode == 13) {
					this.comment();
				}
			},
			replyCm(id, e) {
				this.showCT = true;
				this.replyCmid = id;
				this.crtReplyTarget = e.target.closest('.comment-item');
			},
			showComment() {
				this.replyCmid = '';
				this.showCT = true;
			},
			replyEvent() {
				let self = this;
				let cms = document.querySelectorAll('.reply-comment');
				for (let i = 0; i < cms.length; i++) {
					cms[i].addEventListener('click', (e) => {
						self.replyCm(e.target.dataset.cmid, e);
					})
				}
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
	
	.comments-head {
		font-size: 16px;
		height: 40px;
	}
	.do-comment {
	    float: right;
	    color: blue;
	    cursor: pointer;
	}
	
</style>
<style>
	.blog-content img {
		max-width: 100%;
	}
	.comments-container {
	    border-top: 1px solid #ddd;
    	padding-top: 20px;
	}
	.comments-username {
		color: rgb(93, 130, 216);
	}
	.comment-item {
		margin-bottom: 10px;
	}
	.reply-comment {
		float: right;
	    cursor: pointer;
	    color: blue;
	}
</style>