package com.ttnd.linksharing

class ResourceRating {

    User createdBy
    Resource resource
    Integer score
    Date dateCreated
    Date lastUpdated

    static constraints = {
        createdBy nullable: false
        resource nullable: false, unique: 'createdBy'
        score nullable: false, min: 1, max: 5
    }

    String toString() {
        return "{User: $createdBy, Resource: $resource, Score: $score}"
    }
}
