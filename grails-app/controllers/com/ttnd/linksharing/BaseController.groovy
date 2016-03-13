package com.ttnd.linksharing

class BaseController {

    def baseService

    def isEmailExists() {
        render baseService.isEmailExists(params.emailField)
    }

    private void renderAsJSON(def c1) {
        render(contentType: "text/json", encoding: "UTF-8", c1)
    }
}
