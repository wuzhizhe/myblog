<template>
<div>
  <router-view></router-view>
</div>
</template>
<script>
import login from './login.vue'
import '../../node_modules/bootstrap/dist/css/bootstrap.min.css'
export default {
  data() {
    return {}
  },
  components: {
    login
  }
}
</script>
<style>

</style>