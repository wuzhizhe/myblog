<template>
	<div class="home-container">
		<div class="user-center">{{i18usercenter}}</div>
		<div class="user-image-log-info">
			<div class="user-name-image"><img v-bind:src="imageSrc" alt=""></div>
			<div class="fisrt-day"></div>
			<div class="all-day-sum"></div>
		</div>
		<div class="user-info-list">
			<div class="user-info go-to-another-page" @click="goTo('#/changehead')">{{i18userinfo}}</div>
			<div class="change-password go-to-another-page" @click="goTo('#/changepassword')">{{i18changepwd}}</div>
			<div class="login-history go-to-another-page" @click="goTo('#/loginhis')">{{i18logininfo}}</div>
			<div class="my-bloglist go-to-another-page" @click="goTo('#/bloglist')">{{i18bloglist}}</div>
			<div class="logout" @click="logout()">{{i18logout}}</div>
		</div>
	</div>
</template>
<script>
	import Vue from 'vue'
	import blogheader from './common/header.vue'
	import locales from '../locales'
	export default {
		beforeCreate() {
			let userinfo = JSON.parse(global.localStorage.getItem('userinfo'));
			this.data = {
				imageSrc: global.domain + userinfo.headimage
			};
			this.locales = locales[Vue.config.locale]['home'];
		},
		components: {
			blogheader
		},
		data() {
			return _.extend(this.data, this.locales);
		},
		methods: {
			goTo(url) {
				location.href = url;
			},
			logout() {
				global.localStorage.removeItem('userinfo');
				location.href = routesUrl.login;
			}
		}
	}
</script>
<style scoped>
	.user-image-log-info {
		display: flex;
	    flex-direction: row;
	    justify-content: center;
	}
	.user-name-image:hover {
		border: 1px solid #ddd;
	}
	.user-name-image {
	    width: 100px;
	    height: 100px;
	    border-radius: 50%;
	    overflow: hidden;
	}
	.user-name-image img {
		width: 100px;
   		height: 100px;
	}
	.user-center {
	    height: 2.25em;
	    display: flex;
	    justify-content: center;
	    align-items: center;
        font-size: 2em;
    	font-weight: bold;
	}
	.user-info-list div {
		height: 50px;
		width: 100%;
		line-height: 50px;
	    font-weight: bold;
	    padding-left: 10px;
	    border-bottom: 1px solid #ddd;
	    cursor: pointer;
	}
	.user-info-list div.go-to-another-page:after {
		content: '>';
		float: right;
		font-size: 1.5em;
		line-height: 50px;
		padding-right: 10px;
	}
	.logout {
		text-align: center;
		color: red;
	}
</style>