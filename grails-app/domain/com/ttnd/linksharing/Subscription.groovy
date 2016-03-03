package com.ttnd.linksharing

import com.ttnd.linksharing.enums.Seriousness

class Subscription {

    Topic topic
    User user
    Seriousness seriousness
    Date dateCreated
    Date lastUpdated

    static belongsTo = [topic: Topic, user: User]

    static constraints = {
        topic nullable: false, unique: 'user'
        user nullable: false
        seriousness nullable: false
    }

    String toString() {
        return "{User: $user, Topic: $topic, Seriousness: $seriousness}"
    }
}
