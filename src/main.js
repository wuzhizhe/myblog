import Vue from 'vue'
import Router from 'vue-router'
import VueResource from 'vue-resource'
import VueAsyncData from 'vue-async-data'
import Vuex from 'vuex'
// import VueValidator from 'vue-validator'
// validator2.0 not support vue2.0 now Date:2016-10-17

import app from './app/App.vue'


// new Vue({
//   el: '#app',
//   render: h => h(app)
// })

import router from './router'
import { routesUrl } from './router'
import util from './util/util'
import sysconfig from './config/config'
import services from './system/services'
import locales from './locales'

// Vue.use(VueValidator)
Vue.use(Router)
Vue.use(VueResource)
Vue.use(VueAsyncData)
Vue.use(Vuex)

Vue.config.devtools = true;
Vue.config.locale = 'zh-CN'; //en-US zh-TW


global.routesUrl = routesUrl
global.services = services

app.router = router
new Vue(app).$mount('#app')

//title 多语言
document.title = locales[Vue.config.locale]['project-title']