package com.ttnd.linksharing

import com.ttnd.linksharing.co.LoginCO
import com.ttnd.linksharing.co.UserCO
import com.ttnd.linksharing.co.UserSearchCO
import com.ttnd.linksharing.dto.ResponseDTO
import com.ttnd.linksharing.vo.RecentShareVO
import com.ttnd.linksharing.vo.UserVO
import grails.converters.JSON

class UserController extends BaseController {

//    static allowedMethods = [search: ['POST']]

    def userService
    def resourceService

    def index() {
        List<RecentShareVO> recentShares = resourceService.fetchRecentShares()
        resourceService.fetchTopPosts(1)
        render view: 'index', model: [recentShares: recentShares]
//        render view: 'index'
    }

    def dashboard() {

    }

    def profile() {
        User user = session.user
        render view: 'profile', model: [user: user]
    }

    def update(UserCO userCO) {
        bindData(userCO, params, exclude: ['photo'])
        def photo = request.getFile('photo')
        User user = User.get(session.user.id)
        user.firstName = userCO.firstName
        user.lastName = userCO.lastName
        user.username = userCO.username
        if (!photo && !photo.empty) {
            user.photo = file.getBytes()
        }
        if (user.save(flush: true)) {
            flash.message = "Profile Updated Successfully"
            session.user = user
        } else {
            flash.error = user.errors.allErrors.collect { message(error: it) }.join(",")
        }
        redirect controller: 'user', action: 'profile'
    }

    def updatePassword() {
        User user = User.get(session.user.id)
        user.password = params.passwordField
        if (user.save(flush: true)) {
            flash.message = "Password Updated Successfully"
        } else {
            flash.error = "Please try later"
        }
        log.info user.errors.allErrors
        redirect controller: 'user', action: 'profile'
    }

    def logout() {
        session.invalidate()
        redirect(controller: 'user', action: 'index')
    }

    def isEmailExists() {
        render userService.isEmailExists(params.email)
    }

    def isUsernameExists() {
        render userService.isUsernameExists(params.username)
    }

    def register(UserCO userCO) {
        def file = request.getFile('photo')
        if (!file && !file.empty) {
            userCO.photo = file.getBytes()
        }
        ResponseDTO responseDTO = userService.register(userCO)
        if (responseDTO.status == 200) {
            session.user = responseDTO.object as User
            flash.message = responseDTO.message
            redirect controller: 'user', action: 'dashboard'
        } else {
            flash.error = responseDTO.message
            redirect controller: 'user', action: 'index'
        }
    }

    def loginHandler(LoginCO loginCO) {
        ResponseDTO responseDTO = userService.loginHandler(loginCO)
        if (responseDTO.object) {
            session.user = responseDTO.object as User
        }
        renderAsJSON {
            responseDTO
        }
    }

    def renderForgetPasswordTemplate() {
        render template: 'forgetPassword'
    }

    def forgetPassword(String email) {
        renderAsJSON {
            userService.forgetPassword(email)
        }
    }

    def fetchUserInfo() {
        UserVO userVO = userService.fetchUserInfo(session.user)
        String html = ls.userInfo(userVO: userVO)
        render([html: html] as JSON)
    }

    def recentShares() {
        String html = ls.recentShares(recent: resourceService.fetchRecentShares())
        render([html: html] as JSON)
    }

    def list(UserSearchCO userSearchCO) {
        log.info "<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>"
        log.info userSearchCO.properties
        log.info "<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>"
        if (session.user?.admin) {
            List<User> users = User.search(userSearchCO).list(max: userSearchCO.max, offset: userSearchCO.offset, order: userSearchCO.order, sort: userSearchCO.sort)
            render view: '/user/list', model: [users: users, userCount: User.count()]
        } else {
            redirect(uri: "/")
        }
    }

    def toogleActive() {
        long id = params.long("id")
        User user = User.get(id)
        if (user.active) {
            user.active = false
        } else {
            user.active = true
        }
        user.save(flush: true)
        redirect(controller: 'user', action: 'list')
    }

    def topics() {
//        render userService.fetchUserTopics(session.user)
        String html = ls.subscribedTopics(subscribedTopics: userService.fetchUserTopics(session.user))
        render([html: html] as JSON)
    }

    def search() {
        if (request.getMethod() == 'POST') {
            String search = params.search
            render(view: 'search', model: [search: search])
        } else {
            redirect(uri: "/")
        }
    }
}
