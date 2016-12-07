import Router from 'vue-router'
import login from './app/login.vue'
import home from './app/home.vue'
import signup from './app/signup.vue'
import write from './app/write.vue'
import bloglist from './app/bloglist.vue'

let routes = [
    { path: '/login', component: login },
    { path: '/home', component: home },
    { path: '/signup', component: signup },
    { path: '/bloglist', component: bloglist },
    { path: '/write', component: write },
    { path: '*', redirect: '/login' }
]

const config = {
    linkActiveClass: 'active',
    scrollBehavior: () => ({ x: 0, y: 0 }),
    routes
}

let router = new Router(config)

// router.beforeEach((to, from, next) => {
//     if (global.localStorage.userinfo && to.path === '/login') {
//         next('/home')
//     } else if (!global.localStorage.userinfo && to.path === '/login') {
//         next()
//     } else if (!global.localStorage.userinfo && to.path !== '/login') {
//         next('/login')
//     } else {
//         next()
//     }
// })

export default router

export const routesUrl = {
	'login': '#/login',
	'signup': '#/signup',
	'home': '#/home'
}