<template>
	<div>
      <div class="form-signin" >
        <h2 class="form-signin-heading"></h2>
        <input type="text" v-model="username" id="username" class="form-control" v-bind:placeholder="i18username" required autofocus @keyup.enter="onNameEnter" ref="usernameinput">
        <input type="password" v-model="password" id="inputPassword" class="form-control" v-bind:placeholder="i18password" required @keyup.enter="onPwdEnter" ref="passwordinput">
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me" v-model="remember">{{i18remember}}
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit" @click="beforeSubmit()">{{i18login}}</button>
      </div>
      <div class="no-count"><a href="#/signup">{{i18noaccount}}</a></div>
    </div> 
</template>
<script>
	import Vue from 'vue'
	import md5 from 'crypto-js/md5'
	import locales from '../locales'
	export default {
		beforeCreate() {
			this.data = {
				username: '',
				password: '',
				remember: ''
			};
			this.locales = locales[Vue.config.locale]['login'];
		},
		data() {
			//alert(window.devicePixelRatio)
			return _.extend(this.data, this.locales);
		},
		computed: {
		},
		props: [
			
		],
		methods: {
			onNameEnter() {
				if (!this.username) return;
				this.$refs.passwordinput.focus()
			},
			onPwdEnter() {
				this.beforeSubmit();
			},
			// 登录操作
			login() {
				let formData = new FormData();
				formData.append('username', this.username);
				formData.append('password', md5(this.password).toString().toUpperCase());
				global.services.login({
					username: this.username,
					password: md5(this.password).toString().toUpperCase()
				}, (isok, data) => {
					if (isok === true) {
						Myblog.messager.alert(this.locales.i18loginsucess)
						let userinfo = JSON.stringify(data);
						global.localStorage.setItem('userinfo', userinfo);
						//登录后信息返回
						setTimeout(function() {
							location.href = routesUrl.home
						}, 200)
					} else {
						Myblog.messager.alert(this.locales.i18loginfailed)
					}
				})
			},
			//登录前校验
			beforeSubmit() {
				if (!this.username || !this.password) {
					Myblog.messager.alert(this.locales.i18namepwdrequired);
					return false;
				}
				this.login();
			}
		}
	}
</script>
<style scoped>
	
	.form-signin,
	.no-count {
	  max-width: 90%;
	  padding: 1em;
	  margin: 0 auto;
	}
	.form-signin .form-signin-heading, .form-signin .checkbox {
	  margin-bottom: 1em;
	}
	.form-signin .checkbox {
	  font-weight: normal;
	}
	.form-signin .form-control {
	  position: relative;
	  height: auto;
	  -webkit-box-sizing: border-box;
	     -moz-box-sizing: border-box;
	          box-sizing: border-box;
	  padding: 1em;
	  font-size: 1.2em;
	}
	.form-signin .form-control:focus {
	  z-index: 2;
	}
	.form-signin input[type="text"] {
	  margin-bottom: 1em;
	  border-bottom-right-radius: 0;
	  border-bottom-left-radius: 0;
	}
	.form-signin input[type="password"] {
	  margin-bottom: 1em;
	  border-top-left-radius: 0;
	  border-top-right-radius: 0;
	}

</style>