package com.ttnd.linksharing

import com.ttnd.linksharing.enums.Seriousness
import com.ttnd.linksharing.enums.Visibility

class Topic {

    String name
    Visibility visibility
    User createdBy
    Date dateCreated
    Date lastUpdated

    static hasMany = [subscriptions: Subscription, resources: Resource]

    static belongsTo = [createdBy: User]

    static constraints = {
        name nullable: false, blank: false, unique: 'createdBy'
        createdBy nullable: false
        visibility nullable: false
    }

    String toString() {
        return "{Name: $name, CreatedBy: $createdBy, Visibility: $visibility}"
    }

    def afterInsert() {
        Topic.withNewSession {
            Subscription subscription = new Subscription(user: this.createdBy, topic: this, seriousness: Seriousness.VERY_SERIOUS)
            if (subscription.save(flush: true)) {
                log.info "User subscribed successfully"
            } else {
                log.info "Error saving subscription"
            }
        }
    }
}
