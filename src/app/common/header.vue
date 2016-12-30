<template>
	<div class="header-container">
		<div class="blog-icon-show" @click="goHome()"></div>
		<div class="blog-user-name">{{nickname}}</div>
		<div class="user-icon" @click="goUserInfo()"></div>
	</div>
</template>
<script>
	let userinfo = JSON.parse(global.localStorage.getItem('userinfo'));
	export default {
		data() {
			return {
				nickname: userinfo.nickname
			}
		},
		methods: {
			goHome() {
				
			},
			goUserInfo() {
				location.href = routesUrl.home;
			}
		}
	}
</script>
<style scoped>
	.header-container {
		display: flex;
		padding: 0;
	    height: 3em;
	    align-items: center;
	}
	.blog-icon-show {
		width: 20%;
    	height: 100%;
    	background: url('../../images/icons/home-96.png');
    	background-repeat: no-repeat;
	    background-size: contain;
	    background-position: left;
	}
	.blog-user-name {
	    width: 60%;
	    text-align: center;
	    height: 100%;
	    display: flex;
	    flex-direction: row;
	    justify-content: center;
	    align-items: center;
		font-size: 2em;
	    font-weight: bold;
	    font-family: 'micorsoft yahei';
	}
	.user-icon {
		width: 20%;
    	height: 100%;
    	background: url('../../images/icons/user-96.png');
    	background-repeat: no-repeat;
	    background-size: contain;
	    background-position: right;
	}
</style>