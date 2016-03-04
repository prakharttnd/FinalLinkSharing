package com.ttnd.linksharing

class UserController {

    def index() {
        User user = new User(username: "Prakhar", admin: true)
        session.user = user
    }
}
