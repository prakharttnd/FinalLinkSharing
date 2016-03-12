package com.ttnd.linksharing.vo

import com.ttnd.linksharing.User

class TopicVO {
    String name
    String id
    String username
    User createdBy
    String displayName

    String getDisplayName() {
        return "$name , $username"
    }

    String toString() {
        return "{Name: $name Id: $id Username: $username}"
    }

}
