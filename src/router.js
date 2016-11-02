import login from './app/login.vue'
import home from './app/home.vue'
import signup from './app/signup.vue'
import Router from 'vue-router'

let routes = [
    { path: '/login', component: login },
    { path: '/home', component: home },
    { path: '/signup', component: signup },
    { path: '*', redirect: '/login' }
]

const config = {
    linkActiveClass: 'active',
    scrollBehavior: () => ({ x: 0, y: 0 }),
    routes
}

let router = new Router(config)

router.beforeEach((to, from, next) => {
    next();
})

export default router

export const routesUrl = {
	'login': '#/login',
	'signup': '#/signup',
	'home': '#/home'
}