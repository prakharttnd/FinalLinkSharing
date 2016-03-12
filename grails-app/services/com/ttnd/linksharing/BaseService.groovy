package com.ttnd.linksharing

import grails.transaction.Transactional

@Transactional
class BaseService {

    def isEmailExists(String email) {
        User user = User.findByEmail(email)
        String result = user ? true : false
        return result
    }


}
