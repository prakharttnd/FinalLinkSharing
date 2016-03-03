package com.ttnd.linksharing

import com.ttnd.linksharing.enums.Visibility

class Topic {

    String name
    Visibility visibility
    User createdBy
    Date dateCreated
    Date lastUpdated

    static hasMany = [subscriptions: Subscription, resourcces: Resource]

    static belongsTo = [createdBy: User]

    static constraints = {
        name nullable: false, blank: false, unique: 'createdBy'
        createdBy nullable: false
        visibility nullable: false
    }

    String toString() {
        return "{Name: $name, CreatedBy: $createdBy, Visibility: $visibility}"
    }
}
