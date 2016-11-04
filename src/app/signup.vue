<template>
	<div class="container">
      <form class="form-signup">
        <h2 class="form-signup-heading"></h2>
        <input type="text" v-model="username" id="username" class="form-control" v-bind:placeholder="i18username" required autofocus>
        <input type="password" v-model="password" id="inputPassword" class="form-control" v-bind:placeholder="i18password" required>
        <input type="password" v-model="repassword" id="inputRePassword" class="form-control" v-bind:placeholder="i18repassword" required>
        <div class="password-not-equal-tip" v-show="showtip">{{i18passwordequal}}</div>
        <input type="email" v-model="email" id="email" class="form-control" v-bind:placeholder="i18email" required>
        <input type="text" v-model="telphone" id="telphone" class="form-control" v-bind:placeholder="i18telphone" required>
        <input type="text" v-model="nickname" id="nickname" class="form-control" v-bind:placeholder="i18nickname" required>
        <button type="submit" style="display: none;"></button>
      </form>
      <button class="btn btn-lg btn-primary btn-block btn-signup" @click="beforeSubmit()">{{i18signup}}</button>
      <div class="has-account"><a href="#/login">{{i18hasaccount}}</a></div>
    </div> 
</template>
<script>
	import Vue from 'vue'
	import md5 from 'crypto-js/md5'
	import locales from '../locales'
	export default {
		beforeCreate() {
			this.showtip = false;
			this.data = {
				username: '',
				password: '',
				repassword: '',
				email: '',
				telphone: '',
				nickname: '',
				remember: ''
			};
			this.locales = locales[Vue.config.locale]['signup'];
		},
		data() {
			return _.extend(this.data, this.locales)
		},		
		watch: {
			repassword(newValue) {
				if (newValue !== this.password) {
					this.showtip = true;
				} else {
					this.showtip = false;
				}
			},
			password(newValue) {
				if (newValue !== this.repassword) {
					this.showtip = true;
				} else {
					this.showtip = false;
				}
			}
		},
		props: [],
		methods: {
			regist() {
				global.services.regist({
					username: this.username,
					password: md5(this.password).toString().toUpperCase(),
					email: this.email,
					telphone: this.telphone,
					nickname: this.nickname
				}, (isok, data) => {
					debugger;
					if (isok) {
						Myblog.messager.alert(this.locales.i18signupsuccess);
					} else {
						Myblog.messager.alert(this.locales.i18signupfailed);
					}
				})
			},
			beforeSubmit() {
				if (!this.username || !this.password
					|| !this.repassword || !this.email
					|| !this.telphone || !this.nickname ) {
					Myblog.messager.alert(this.locales.i18allrequired);
					return false;
				}
				if (this.password !== this.repassword) {
					Myblog.messager.alert(this.locales.i18passwordequal);
					return false;
				}
				this.regist();
			}
		}
	}
</script>
<style scoped>
	.form-signup,
	.has-account {
	  max-width: 330px;
	  padding: 15px;
	  margin: 0 auto;
	}
	.form-signup .form-signup-heading, .form-signup .checkbox {
	  margin-bottom: 10px;
	}
	.form-signup .checkbox {
	  font-weight: normal;
	}
	.form-signup .form-control {
	  position: relative;
	  height: auto;
	  -webkit-box-sizing: border-box;
	     -moz-box-sizing: border-box;
	          box-sizing: border-box;
	  padding: 10px;
	  font-size: 16px;
	}
	.form-signup .form-control:focus {
	  z-index: 2;
	}
	.form-signup input[type="text"],
	.form-signup input[type="email"] {
	  margin-bottom: 10px;
	  border-bottom-right-radius: 0;
	  border-bottom-left-radius: 0;
	}
	.form-signup input[type="password"] {
	  margin-bottom: 10px;
	  border-top-left-radius: 0;
	  border-top-right-radius: 0;
	}

	.btn-signup {
		margin: 0 auto;
		width: 300px;
	}
	.password-not-equal-tip {
	    color: red;
	    font-size: 12px;
	    margin-bottom: 10px;
	}
	
</style>