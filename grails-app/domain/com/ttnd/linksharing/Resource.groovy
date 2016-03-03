package com.ttnd.linksharing

abstract class Resource {

    User createdBy
    Topic topic
    String description
    Date dateCreated
    Date lastUpdated

    static mapping = {
        description type: 'text'
    }

    static constraints = {
        createdBy nullable: false
        topic nullable: false
        description nullable: false, blank: false
    }
}
