package com.ttnd.linksharing

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(BaseController)
class BaseControllerSpec extends Specification {

    def "Test to validate isEmailExists action"() {
        setup:
        BaseService baseService = Mock(BaseService)
        baseService.isEmailExists("*") >> true

        when:
        controller.isEmailExists()

        then:
        response.text == true


    }

}
