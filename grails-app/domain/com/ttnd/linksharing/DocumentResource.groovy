package com.ttnd.linksharing

class DocumentResource extends Resource {

    String filepath

    static hasMany = [resourceRatings: ResourceRating, readingItem: ReadingItem]

    static belongsTo = [createdBy: User, topic: Topic]

    static constraints = {
        filepath nullable: false, blank: false
    }

    String toString() {
        return "Id: $id"
        //   return "User: $createdBy, Topic: $topic, Filepath: $filepath"
    }
}
