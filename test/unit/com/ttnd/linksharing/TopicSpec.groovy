package com.ttnd.linksharing

import grails.test.mixin.TestFor
import spock.lang.Specification
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Topic)
class TopicSpec extends Specification {

    @Unroll
    def "test to validate topic object"() {
        setup:
        User user = new User(id: 1)
        Topic topic = new Topic(name: name, createdBy: user, visibility: visibility)

        when:
        Boolean result = topic.validate()

        then:
        result == valid

        where:
        name     | visibility | valid
        null     | "PUBLIC"   | false
        ""       | "PUBLIC"   | false
        "   "    | "PUBLIC"   | false
        "Garils" | "PUBLIC"   | true
        "Garils" | null       | false
        "Garils" | ""         | false
        "Garils" | "sdjbhsdf" | false
        "Garils" | "PUBLIC"   | true
        "Garils" | "PRIVATE"  | true
    }
}
