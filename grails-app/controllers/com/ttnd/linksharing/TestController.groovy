package com.ttnd.linksharing

import grails.converters.JSON

class TestController {

    def index() {}

    def fetchData() {
        log.info "<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
        render([data: "data"] as JSON)
    }
}
