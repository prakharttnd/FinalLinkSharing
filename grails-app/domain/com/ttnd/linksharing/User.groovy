package com.ttnd.linksharing

import com.ttnd.linksharing.co.UnreadResourceSearchCO
import com.ttnd.linksharing.vo.UnreadResourceVO

class User {

    String username
    String email
    String password
    String firstName
    String lastName
    byte[] photo
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

    static List<UnreadResourceVO> getUnreadResources(UnreadResourceSearchCO unreadResourceSearchCO) {
        def unreadItems = ReadingItem.searchUnread(unreadResourceSearchCO).list(max: unreadResourceSearchCO.max, offset: unreadResourceSearchCO.offset)
        List<UnreadResourceVO> unreadResources = unreadItems.collect {
            new UnreadResourceVO(resourceCreatorId: it[0], resourceCreatorName: it[1] + " " + it[2], resourceCreatorUsername: it[3], photo: it[4], topicId: it[5], topicName: it[6], resourceId: it[7], description: it[8], dateCreated: it[9], resourceClass: it[10], url: it[11], filepath: it[12])
        }
        return unreadResources
    }

    String getFullName() {
        return firstName + " " + lastName
    }

    String toString() {
        return "Name: ${getFullName()}, Username: $username, Email: $email"
    }
}
