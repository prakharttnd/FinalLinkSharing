package com.ttnd.linksharing

import com.ttnd.linksharing.co.UserCO
import com.ttnd.linksharing.dto.ResponseDTO

class UserController {

    def index() {
        User user = new User(username: "Prakhar", admin: true)
        session.user = user
    }

    def register(UserCO userCO) {
        User user = new User(userCO.properties)
        renderAsJSON {
            user.save(flush: true)
        }
    }

    def renderForgetPasswordTemplate() {
        render template: 'forgetPassword'
    }

    def forgetPassword() {
        //Email service code goes here
        Thread.sleep(3000)
        ResponseDTO responseDTO = new ResponseDTO(status: 200, message: "Email sent successfully")
        renderAsJSON {
            responseDTO
        }
    }

    private void renderAsJSON(def c1) {
        render(contentType: "text/json", encoding: "UTF-8", c1)
    }
}
