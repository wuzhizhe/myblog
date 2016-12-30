import Router from 'vue-router'
import login from './app/login.vue'
import home from './app/home.vue'
import signup from './app/signup.vue'
import write from './app/write.vue'
import showblog from './app/showblog.vue'
import bloglist from './app/bloglist.vue'
import changehead from './app/changehead.vue'
import changepassword from './app/changepassword.vue'
import loginhis from './app/loginhis.vue'

let routes = [
    { path: '/login', component: login },
    { path: '/home', component: home },
    { path: '/signup', component: signup },
    { path: '/bloglist', component: bloglist },
    { path: '/write/:blogid', component: write },
    { path: '/showblog/:id', component: showblog },
    { path: '/changehead', component: changehead },
    { path: '/changepassword', component: changepassword },
    { path: '/loginhis', component: loginhis },
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
    'write': '#/write',
    'showblog': '#/showblog',
    'bloglist': '#/bloglist',
    'changehead': '#/changehead',
    'changepassword': '#/changepassword',
	'loginhis': '#/loginhis',
	'home': '#/home'
}