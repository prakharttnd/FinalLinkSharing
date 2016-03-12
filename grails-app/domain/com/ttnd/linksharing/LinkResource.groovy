package com.ttnd.linksharing

class LinkResource extends Resource {

    String url

    static hasMany = [resourceRatings: ResourceRating, readingItem: ReadingItem]

    static belongsTo = [createdBy: User, topic: Topic]

    static constraints = {
        url url: true, nullable: false, blank: false
    }

    String toString() {
        return "Id: $id"
       // return "User: $createdBy, Topic: $topic, Url: $url, Description: $description"
    }
}
