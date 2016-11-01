<template>
	<div class="container">
      <form class="form-signup" v-on:submit="beforeSubmit()">
        <h2 class="form-signup-heading"></h2>
        <input type="text" v-model="username" id="username" class="form-control" v-bind:placeholder="i18username" required autofocus>
        <!-- <label for="inputPassword" class="sr-only">i18password</label> -->
        <input type="password" v-model="password" id="inputPassword" class="form-control" v-bind:placeholder="i18password" required>
        <!-- <label for="inputRePassword" class="sr-only">{{i18password}}</label> -->
        <input type="password" v-model="repassword" id="inputRePassword" class="form-control" v-bind:placeholder="i18repassword" required>
        <!-- <label for="email" class="sr-only">{{i18email}}</label> -->
        <input type="email" v-model="email" id="email" class="form-control" v-bind:placeholder="i18email" required>
        <!-- <label for="telphone" class="sr-only">i18telphone</label> -->
        <input type="text" v-model="telphone" id="telphone" class="form-control" v-bind:placeholder="i18telphone" required>
        <!-- <label for="nickname" class="sr-only">{{i18nickname}}</label> -->
        <input type="text" v-model="nickname" id="nickname" class="form-control" v-bind:placeholder="i18nickname" required>
        <button class="btn btn-lg btn-primary btn-block" type="submit">{{i18signup}}</button>
      </form>
      <div class="has-account"><a href="#/login">{{i18hasaccount}}</a></div>
    </div> 
</template>
<script>
	import Vue from 'vue'
	import locales from '../locales'
	export default {
		beforeCreate() {
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
		props: [],
		methods: {
			login() {
				let formData = new FormData();
				global.services.login({
					username: this.username,
					password: this.password
				}, (isok, data) => {
					if (isok) {
						alert("登陆成功！")
						location.href = routesUrl.home
					} else {
						alert("用户名或者密码错误，登陆失败！")
					}
				})
			},
			beforeSubmit() {
				if (!this.username || !this.password) return false;
				this.login();
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

</style>