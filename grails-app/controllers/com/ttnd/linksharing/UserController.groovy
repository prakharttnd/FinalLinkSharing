package com.ttnd.linksharing

import com.ttnd.linksharing.co.LoginCO
import com.ttnd.linksharing.co.UserCO
import com.ttnd.linksharing.dto.ResponseDTO
import com.ttnd.linksharing.vo.RecentShareVO
import com.ttnd.linksharing.vo.UserVO
import grails.converters.JSON

class UserController extends BaseController {

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

    def list() {
        if (session.user.admin) {
            render view: 'list'
        } else {
            redirect(uri: "/")
        }
    }
}
