package com.ttnd.linksharing

class LinkResource extends Resource {

    String url

    static constraints = {
        url url: true, nullable: false, blank: false
    }

    String toString() {
        return "Id: $id"
        // return "User: $createdBy, Topic: $topic, Url: $url, Description: $description"
    }
}
