package com.ttnd.linksharing

import grails.test.mixin.TestFor
import spock.lang.IgnoreRest
import spock.lang.Specification
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(User)
class UserSpec extends Specification {

    @Unroll
    def "Test for getFullName method"() {
        setup:
        User user = new User(firstName: firstName, lastName: lastName)

        expect:
        user.getFullName() == result

        where:
        firstName | lastName  | result
        "Prakhar" | "Agrawal" | "Prakhar Agrawal"
        "Prakhar" | ""        | "Prakhar null"
    }

    @Unroll
    def "Test to validate given user is valid or not"() {
        setup:
        User user = new User(username: username, password: password, email: email, firstName: fname, lastName: lname, confirmPassword: confirmPassword)

        when:
        Boolean result = user.validate()

        then:
        result == valid

        where:
        username  | password  | email               | fname     | lname     | valid | admin | active | confirmPassword
        null      | "Prakhar" | "prakhar@gmail.com" | "Prakhar" | "Agrawal" | false | null  | true   | "abcdef"
        ""        | "Prakhar" | "prakhar@gmail.com" | "Prakhar" | "Agrawal" | false | true  | null   | "abcdef"
        "  "      | "Prakhar" | "prakhar@gmail.com" | "Prakhar" | "Agrawal" | false | true  | true   | "abcdef"
        "prakhar" | null      | "prakhar@gmail.com" | "Prakhar" | "Agrawal" | false | true  | true   | "abcdef"
        "prakhar" | ""        | "prakhar@gmail.com" | "Prakhar" | "Agrawal" | false | true  | true   | "abcdef"
        "prakhar" | "  "      | "prakhar@gmail.com" | "Prakhar" | "Agrawal" | false | true  | true   | "abcdef"
        "prakhar" | "abc"     | "prakhar@gmail.com" | "Prakhar" | "Agrawal" | false | true  | true   | "abcdef"
        "prakhar" | "abcdef"  | null                | "Prakhar" | "Agrawal" | false | true  | true   | "abcdef"
        "prakhar" | "abcdef"  | ""                  | "Prakhar" | "Agrawal" | false | true  | true   | "abcdef"
        "prakhar" | "abcdef"  | "  "                | "Prakhar" | "Agrawal" | false | true  | true   | "abcdef"
        "prakhar" | "abcdef"  | "prakhar"           | "Prakhar" | "Agrawal" | false | true  | true   | "abcdef"
        "prakhar" | "abcdef"  | "prakhar@email.com" | null      | "Agrawal" | false | true  | true   | "abcdef"
        "prakhar" | "abcdef"  | "prakhar@email.com" | ""        | "Agrawal" | false | true  | true   | "abcdef"
        "prakhar" | "abcdef"  | "prakhar@email.com" | "   "     | "Agrawal" | false | true  | true   | "abcdef"
        "prakhar" | "abcdef"  | "prakhar@email.com" | "Prakhar" | null      | false | true  | true   | "abcdef"
        "prakhar" | "abcdef"  | "prakhar@email.com" | "Prakar"  | ""        | false | true  | true   | "abcdef"
        "prakhar" | "abcdef"  | "prakhar@email.com" | "Prakhar" | "  "      | false | true  | true   | "abcdef"
        "prakhar" | "abcdef"  | "prakhar@email.com" | "Prakhar" | "Agrawal" | false | null  | null   | null
        "prakhar" | "abcdef"  | "prakhar@gmail.com" | "Prakhar" | "Agrawal" | true  | null  | null   | "abcdef"
    }

    @Unroll
    def "test to validate when user is registering then null confirmpassword is valid"() {
        setup:
        User user = new User(id: null, username: "prakhar", firstName: "Prakhar", lastName: "Agrawal", password: "abcdef", email: "prakhar@gmail.com", confirmPassword: null)

        expect:
        user.validate() == false
    }

    @Unroll
    def "Test for toString method"() {
        setup:
        User user = new User(username: username, firstName: firstname, lastName: lastname, email: email)

        expect:
        user.toString() == result

        where:
        username  | firstname | lastname  | email               | result
        "prakhar" | "Prakhar" | "Agrawal" | "prakhar@gmail.com" | "Name: Prakhar Agrawal, Username: prakhar, Email: prakhar@gmail.com"
        "admin"   | "Admin"   | "TTND"    | "admin@gmail.com"   | "Name: Admin TTND, Username: admin, Email: admin@gmail.com"
        "try"     | "Demo"    | "User"    | "demo@gmail.com"    | "Name: Demo User, Username: try, Email: demo@gmail.com"
    }
}
