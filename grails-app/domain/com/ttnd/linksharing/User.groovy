package com.ttnd.linksharing

class User {

    String username
    String email
    String password
    String firstName
    String lastName
    Byte photo
    Boolean admin
    Boolean active
    Date dateCreated
    Date lastUpdated
    String fullName
    String confirmPassword

    static transients = ['fullName', 'confirmPassword']

    static hasMany = [topics         : Topic, subscriptions: Subscription, resources: Resource,
                      resourceRatings: ResourceRating, readingItems: ReadingItem]

    static mapping = {
        photo sqlType: 'longblob'
    }

    static constraints = {
        username nullable: false, blank: false, unique: true
        email email: true, nullable: false, blank: false, unique: true
        firstName nullable: false, blank: false
        lastName nullable: false, blank: false
        photo nullable: true
        admin nullable: true
        active nullable: true
        password nullable: false, blank: false, minSize: 5
        confirmPassword bindable: true, nullable: true, blank: true, validator: { val, obj ->
            if (!obj.id) {
                if (val) {
                    if (val != obj.password) {
                        return 'password.do.not.match.confirmpassword'
                    }
                } else {
                    return 'confirmpassword.should.not.be.null'
                }
            }
            return true
        }
    }

    String getFullName() {
        return "$firstName $lastName"
    }

    String toString() {
        return "Name: $fullName, Username: $username, Email: $email"
    }
}
