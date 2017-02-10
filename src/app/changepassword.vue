<template>
	<div class="change-password-container">
		<input type="password" required v-model="password" class="form-control" v-bind:placeholder="i18password">
		<input type="password" required v-model="newpassword" class="form-control" v-bind:placeholder="i18newpassword">
		<input type="password" required v-model="newpasswordagain" class="form-control" v-bind:placeholder="i18newpasswordagain">
		<div class="password-not-equal-tip" v-show="showtip">{{i18passwordequal}}</div>
		<button class="btn btn-lg btn-primary btn-block btn-changepwd" @click="beforeSubmit()">{{i18commit}}</button>
	</div>
</template>
<script>
	import Vue from 'vue'
	import md5 from 'crypto-js/md5'
	import locales from '../locales'
	export default {
		beforeCreate() {
			this.data = {
				password: '',
				newpassword: '',
				showtip: false,
				newpasswordagain: ''
			};
			this.locales = locales[Vue.config.locale]['changepassword'];
		},
		watch: {
			newpassword(newValue) {
				if (newValue !== this.newpasswordagain) {
					this.showtip = true;
				} else {
					this.showtip = false;
				}
			},
			newpasswordagain(newValue) {
				if (newValue !== this.newpassword) {
					this.showtip = true;
				} else {
					this.showtip = false;
				}
			}
		},
		data() {
			return _.extend(this.data, this.locales);
		},
		methods: {
			changepassword() {
				let userinfo = JSON.parse(global.localStorage.getItem('userinfo'));
				global.services.changepassword({
					oldpassword: md5(this.data.password).toString().toUpperCase(),
					newpassword: md5(this.data.newpassword).toString().toUpperCase(),
					username: userinfo.username
				}, {
					emulateJSON: true
				}).then((data) => {
					Myblog.messager.alert(this.data.i18changesuc);
					// global.localStorage.setItem('userinfo', null);
					location.href = routesUrl.login;
				}, (text) => {
					Myblog.messager.alert(text);
				});
			},
			beforeSubmit() {
				if (!this.newpassword || !this.newpasswordagain || !this.password) {
					Myblog.messager.alert(this.locales.i18allrequired);
					return false;
				}
				if (this.newpassword != this.newpasswordagain) {
					Myblog.messager.alert(this.locales.i18passwordequal);
					return false;
				}
				this.changepassword();
			}
		}
	}
</script>
<style scoped>
	.change-password-container {
	    display: flex;
	    flex-flow: column;
	    justify-content: center;
	    align-items: center;
	}
	.change-password-container input {
		margin: 10px 0 10px 0;
		max-width: 300px;
	}
	.password-not-equal-tip {
	    color: red;
	    font-size: 12px;
	    margin-bottom: 10px;
	}
	.btn-changepwd {
		margin: 0 auto;
		width: 300px;
	}
</style>