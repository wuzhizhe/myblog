<template>
	<div class="blog-list-container">
		<div class="blog-item-container" v-for="blog in blogs">
			<div><img v-bind:src="blog.imgSrc" alt=""></div>
			<h2>{{blog.title}}</h2>
			<p>{{blog.desc}}</p>
		</div>
	</div>
</template>
<script>
	
</script>
<style>
	
</style>