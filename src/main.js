import Vue from 'vue'
import Router from 'vue-router'
import VueResource from 'vue-resource'
import VueAsyncData from 'vue-async-data'
import Vuex from 'vuex'
// validator2.0 not support vue2.0 now Date:2016-10-17

import app from './app/App.vue'
import routes from './routes'
import { routesUrl } from './routes'
import util from './util/util'
import sysconfig from './config/config'
import services from './system/services'
import locales from './locales'

Vue.use(Router)
Vue.use(VueResource)
Vue.use(VueAsyncData)
Vue.use(Vuex)

Vue.config.devtools = true;
Vue.config.locale = 'zh-CN'; //en-US zh-TW

const config = {
    linkActiveClass: 'active',
    scrollBehavior: () => ({ x: 0, y: 0 }),
    routes
}
global.routesUrl = routesUrl
global.services = services

app.router = new Router(config)
new Vue(app).$mount('#app')

//title 多语言
document.title = locales[Vue.config.locale]['project-title']