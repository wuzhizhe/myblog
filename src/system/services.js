import Vue from 'vue'

const serviceUrl = {
	'login': 'login'
};

const services = {
	vueResource (url, body, options, callback) {
		const defaultOptions = {
			headers: null,
			params: null,
			timeout: 60000,
			emulateJSON: true
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
	}
}

export default services;