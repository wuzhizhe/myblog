import Vue from 'vue'

const serviceUrl = {
	'login': 'login.do',
	'regist': 'regist.do',
	'uploadImage': 'image/upload.do',
	'saveBlog': 'saveBlog.do',
	'getBlog': 'getBlog.do',
	'getBlogList': 'getBlogList.do',
	'updateheadimage': 'updateheadimage.do',
	'updateBlog': 'updateBlog.do',
	'changepassword': 'changepassword.do',
	'loginhis': 'loginhis.do',
	'saveComment': 'saveComment.do',
	'getComments': 'getComments.do',
	'updateComment': 'updateComment.do'
};

const services = {
	vueResource (url, body, options, callback) {
		const defaultOptions = {
			headers: null,
			params: null,
			timeout: 60000
		};
		const _options = _.extend(defaultOptions, options);

		return new Promise((resolve, reject) => {
		Vue.http
			.post(url, body, _options)
			.then( (response) => {
				const result = response.body;
				if (result.success) {
					if(callback) {
						callback(true, result.data);
					}
					resolve(result.data);
				} else {
					if (callback) {
						callback(false, result.error);
					}
					resolve(result.error);
				}
			}, (response) => {
				if (callback) {
					callback(new Error(response.text()))
				}
				reject(response.text());
			})
		});
	},

	login(params, callback) {
		const url = global.domain + serviceUrl.login;
		const data = {
			username: params.username,
			password: params.password
		};
		this.vueResource(url, data, {}, (isok, data) => {
			if (callback) {
				callback(isok, data);
			}
		});
	},
	regist(params, callback) {
		const url = global.domain + serviceUrl.regist;
		this.vueResource(url, params, {}, (isok, data) => {
			if (callback) {
				callback(isok, data);
			}
		});
	},
	uploadImage(params, options, callback) {
		const url = global.domain + serviceUrl.uploadImage;
		const paras = {
			dir: params.dir,
			images: params.images
		}
		return this.vueResource(url, paras, options || {}, (isok, data) => {
		});
	},
	saveBlog(params, options) {
		const url = global.domain + serviceUrl.saveBlog;
		return this.vueResource(url, params, options || {})
	},
	getBlogList(params, options) {
		const url = global.domain + serviceUrl.getBlogList;
		return this.vueResource(url, params, options || {})
	},
	getBlog(params, options) {
		const url = global.domain + serviceUrl.getBlog;
		return this.vueResource(url, params, options || {})
	},
	updateheadimage(params, options) {
		const url = global.domain + serviceUrl.updateheadimage;
		return this.vueResource(url, params, options || {})
	},
	updateBlog (params, options) {
		const url = global.domain + serviceUrl.updateBlog;
		return this.vueResource(url, params, options || {})
	},
	changepassword (params, options) {
		const url = global.domain + serviceUrl.changepassword;
		return this.vueResource(url, params, options || {})
	},
	loginhis (params, options) {
		const url = global.domain + serviceUrl.loginhis;
		return this.vueResource(url, params, options || {})
	},
	saveComment (params, options) {
		const url = global.domain + serviceUrl.saveComment;
		return this.vueResource(url, params, options || {})
	},
	getComments (params, options) {
		const url = global.domain + serviceUrl.getComments;
		return this.vueResource(url, params, options || {})
	},
	updateComment (params, options) {
		const url = global.domain + serviceUrl.updateComment;
		return this.vueResource(url, params, options || {})
	}
}

export default services;