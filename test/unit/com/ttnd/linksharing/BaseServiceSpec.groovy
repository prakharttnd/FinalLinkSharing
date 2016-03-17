package com.ttnd.linksharing

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@Mock(User)
@TestFor(BaseService)
class BaseServiceSpec extends Specification {

    @Unroll
    def "Test to validate isEmailExists method"() {
        setup:
        String email = input

        when:
        boolean result = service.isEmailExists(email)

        then:
        result == valid

        where:
        input                       | valid
        "prakhar@gmail.com"         | true
        "prakharmittal95@gmail.com" | true

    }
}
