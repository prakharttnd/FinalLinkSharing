package com.ttnd.linksharing

class ReadingItem {

    User user
    Resource resource
    Boolean isRead
    Date dateCreated
    Date lastUpdated

    static constraints = {
        user nullable: false
        resource nullable: false, unique: 'user'
        isRead nullable: false
    }

    String toString() {
        return "{User: $user, Resource: $resource, IsRead: $isRead}"
    }
}
