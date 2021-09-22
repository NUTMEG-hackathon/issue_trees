import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Information from '../views/Information.vue'
import Tree from '../views/Tree'
import Welcome from '../views/Welcome.vue'
import MyPage from '../views/MyPage.vue'
import ProjectRegist from '../views/ProjectRegist.vue'
import AllUser from '../views/AllUser.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/home',
    name: 'Home',
    component: Home
  },
  {
    path: '/information',
    name: 'Information',
    component: Information
  },
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  },
  {
    path: '/tree',
    name: 'Tree',
    component: Tree
  },
  {
    path: '/',
    name: 'Welcome',
    component: Welcome
  },
  {
    path: '/mypage',
    name: 'MyPage',
    component: MyPage
  },
  {
    path: '/projectregist',
    name: 'ProjectRegist',
    component: ProjectRegist
  },
  {
    path: '/alluser',
    name: 'AllUser',
    component: AllUser
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
