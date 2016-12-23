<template>
	<div class="write-blog-container" v-if="show">
		<blogheader></blogheader>
		<div class="blog-blogname form-group">
			<label for="blog-name">{{i18blogname}}</label>
			<input id="blog-name" class="form-control" type="text" v-model="blogname" >
		</div>
		<div class="text-editor" ></div>
		<button @click="saveContent()" class="btn btn-lg btn-primary btn-block btn-save">{{i18savecontent}}</button>
		<div class="content-show" v-html="content"></div>
		<input type="file" style="display:none;" ref="uploadimagefile" multiple accept="image/*" @change="uploadImage()">
	</div>
</template>
<script>
	import Vue from 'vue'
	import blogheader from './common/header.vue'
	import Quill from 'quill'
	import locales from '../locales'
	import '../../node_modules/quill/dist/quill.core.css'
	import '../../node_modules/quill/dist/quill.bubble.css'
	import '../../node_modules/quill/dist/quill.snow.css'
	export default {
		beforeCreate() {
			this.locales = locales[Vue.config.locale]['write'];
			this.blogid = this.$route.params.blogid;
			this.data = {
				show: true,
				update: false,
				text: '',
				content: '',
				blogname: ''
			}
			
		},
		components: {
			blogheader
		},
		created() {
			
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
						container: [ 
							[{ 'size': ['small', false, 'large', 'huge'] }],
							['bold', 'italic', 'underline', 'strike', 'link'], 
							[{ 'color': [] }, { 'background': [] }],
							[{ 'header': 1 }, { 'header': 2 }],
							['code-block'],
							['image']	
						],
						handlers: {
							image: this.imageHandler
						}
					}
				},
				theme: 'snow'
			});
			if (this.blogid !== 'start') {
				this.data.update = true;
				global.services.getBlog({
					blogid: this.blogid
				}, {})
				.then( (data) => {
					var blog = _.extend(data.blog, data.blogDetail);
					this.data.blog = blog;
					this.quill.clipboard.dangerouslyPasteHTML(blog.blogText, 'api');
					this.data.blogname = blog.blogname;
				}, (text) => {
					Myblog.messager.alert(text);
					return {};
				});
			}
			
		},
		data() {
			return _.extend(this.data, this.locales)
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
				global.services.uploadImage({
					images: JSON.stringify(postArray),
					dir: 'images'
				}, {})
				.then((data) => {
					for (let j = 0; j < data.length; j++) {
						_this.quill.insertEmbed(j, 'image', global.domain + data[j].address, Quill.sources.USER);
					}
				}, (text) => {
					Myblog.messager.alert(text);
				})
			},
			saveContent() {
				if (this.data.update) {
					let params1 = {
						blogid: this.blogid,
						blogname: this.blogname,
						tags: '',
						content: this.quill.container.firstChild.innerHTML
					};
					global.services.updateBlog(params1, {})
					.then( (data) => {
						location.href = routesUrl.showblog + '/' + data
					}, (text) => {
						Myblog.messager.alert(text);
					});
				} else {
					let userinfo = JSON.parse(global.localStorage.getItem('userinfo'));
					let params = {
						blogname: this.blogname,
						userid: userinfo.id,
						tags: '',
						content: this.quill.container.firstChild.innerHTML
					};
					global.services.saveBlog(params, {})
					.then( (data) => {
						location.href = routesUrl.showblog + '/' + data.blog.id
					}, (text) => {
						Myblog.messager.alert(text);
					});
				}
			},
			getBlogData(blogid) {
				
			}
		}
	}
</script>
<style scoped>
	.write-blog-container {
		margin: 0.625em;
	}
	.text-editor {
		min-height: 25em;
	}
	.btn-save {
		margin: 1.25em auto;
	}
</style>