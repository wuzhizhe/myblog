import Vue from 'vue'

const serviceUrl = {
	'login': 'login',
	'regist': 'regist',
	'uploadImage': 'uploadImage'
};

const services = {
	vueResource (url, body, options, callback) {
		const defaultOptions = {
			headers: null,
			params: null,
			timeout: 60000
		};
		const _options = _.extend(defaultOptions, options);
		Vue.http
		.post(url, body, _options)
		.then( (response) => {
			const result = response.body;
			if (result.success) {
				if(callback) {
					callback(true, result.data);
				}
			} else {
				if (callback) {
					callback(false, result.error);
				}
			}
		}, (response) => {
			if (callback) {
				callback(new Error(response.text()))
			}
		})
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
	uploadImage(params, callback) {
		const url = global.domain + serviceUrl.uploadImage;
		const paras = {
			images: params
		}
		this.vueResource(url, paras, {}, (isok, data) => {
			if (callback) {
				callback(isok, data);
			}
		});
	}
}

export default services;