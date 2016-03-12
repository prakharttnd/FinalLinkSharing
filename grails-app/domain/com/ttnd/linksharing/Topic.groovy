package com.ttnd.linksharing

import com.ttnd.linksharing.co.SubscriptionCO
import com.ttnd.linksharing.dto.ResponseDTO
import com.ttnd.linksharing.enums.Seriousness
import com.ttnd.linksharing.enums.Visibility

class Topic {

    def subscriptionService

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
            SubscriptionCO subscriptionCO = new SubscriptionCO(user: this.createdBy, topic: this, seriousness: Seriousness.VERY_SERIOUS)
            ResponseDTO responseDTO = subscriptionService.save(subscriptionCO)
            if (responseDTO.status == 200) {
                log.info "User subscribed successfully with parameters $subscriptionCO.properties"
            } else {
                log.info "Error saving subscription for user with " +
                        "parameters $subscriptionCO.properties and error $responseDTO.message"
            }
        }
    }
}
