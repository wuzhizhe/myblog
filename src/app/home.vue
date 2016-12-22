<template>
	<div class="home-container">
		<blogheader></blogheader>
		<div class="user-image-log-info"></div>
		<div class="user-info-list">
			<div class="user-info go-to-another-page"></div>
			<div class="change-password go-to-another-page"></div>
			<div class="login-history go-to-another-page"></div>
			<div class="my-bloglist go-to-another-page"></div>
			<div class="logout"></div>
		</div>
	</div>
</template>
<script>
	import blogheader from './common/header.vue'
	export default {
		components: {
			blogheader
		},
		data() {
			return {
			}
		}
	}
</script>
<style scoped>
	.user-info-list div {
		height: 40px;
		width: 100%;
	}
	.user-info-list div.go-to-another-page:after {
		content: '>';
		float: right;
		font-size: 2.5em;
		line-height: 40px;
	}
</style>