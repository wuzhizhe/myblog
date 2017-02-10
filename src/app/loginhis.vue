<template>
	<div class="login-his-container">
		<div class="login-his-title">{{i18loginhistitle}}</div>
		<ul class="loginhis-item-container" v-if="show">
			<li class="loginhis-item">
				<!-- <div class="loginhis-item-username">{{i18nickname}}</div> -->
				<div class="loginhis-item-ip">{{i18loginip}}</div>
				<div class="loginhis-item-time">{{i18logintime}}</div>
			</li>
			<li v-for="loginhis in loginhiss" class="loginhis-item">
				<!-- <div class="loginhis-item-username">{{userinfo.nickname}}</div> -->
				<div class="loginhis-item-ip">{{loginhis.loginip}}</div>
				<div class="loginhis-item-time">{{loginhis.logintimestr}}</div>
			</li>
		</ul>
	</div>
</template>
<script>
	import Vue from 'vue'
	import locales from '../locales'
	export default {
		beforeCreate() {
			this.data = {
				show: false,
				loginhiss: []
			};
			this.locales = locales[Vue.config.locale]['loginhis'];
			let userinfo = JSON.parse(global.localStorage.getItem('userinfo'));
			this.data.userinfo = userinfo;
			global.services.loginhis({
				username: userinfo.username
			}, {
				emulateJSON: true
			})
			.then( (data) => {
				this.data.loginhiss = data;
				this.data.show = true;
			}, (text) => {
				Myblog.messager.alert(text);
				return {};
			});
		},
		data() {
			return _.extend(this.data, this.locales);
		},
		methods: {

		}
	}
</script>
<style>
    .loginhis-item-container {
    	padding: 0;
    }
	.loginhis-item {
		display: flex;
		flex-direction: row;
		justify-content: space-around;
		height: 40px;
    	align-items: center;
	}
	.loginhis-item div {
        max-height: 40px;
		display: -webkit-box;
		-webkit-line-clamp: 2;
		-webkit-box-orient: vertical;
		overflow: hidden;
		text-align: center;
	}
	.loginhis-item-ip {
		width: 110px;
	}
	.loginhis-item-username,
	.loginhis-item-time {
		width: 150px;
		overflow: hidden;
	}
	.login-his-title {
	    height: 40px;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    background: rgba(114, 151, 234, 0.58);
	    color: #fff;
	    font-size: 20px;
	    font-weight: bold;
	}
</style>