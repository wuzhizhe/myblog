import login from './app/login.vue'
import home from './app/home.vue'
import signup from './app/signup.vue'

export default [
    { path: '/login', component: login },
    { path: '/home', component: home },
    { path: '/signup', component: signup },
    { path: '*', redirect: '/login' }
]

export const routesUrl = {
	'login': '#/login',
	'signup': '#/signup',
	'home': '#/home'
}