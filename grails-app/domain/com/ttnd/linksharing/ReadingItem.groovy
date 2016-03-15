package com.ttnd.linksharing

import com.ttnd.linksharing.co.UnreadResourceSearchCO

class ReadingItem {

    User user
    Resource resource
    Boolean isRead
    Date dateCreated
    Date lastUpdated

    static belongsTo = [linkResource: LinkResource, documentResource: DocumentResource, user: User]

    static constraints = {
        user nullable: false
        resource nullable: false, unique: 'user'
        isRead nullable: false
    }

    static namedQueries = {
        searchUnread { UnreadResourceSearchCO co ->
            projections {
                'resource' {
                    'createdBy' {
                        property('id')
                        property('firstName')
                        property('lastName')
                        property('username')
                        property('photo')
                    }
                    'topic' {
                        property('id')
                        property('name')
                    }
                    property('id')
                    property('description')
                    property('dateCreated')
                    property('class')
                    property('url')
                    property('filepath')
                }
            }
            if (co.q) {
                'resource' {
                    ilike('description', "%${co.q}%")
                }
            }
            'resource' {
                order('dateCreated', 'desc')
            }
            eq('isRead', co.isRead)
            eq('user', co.user)
        }
    }

    String toString() {
        return "{User: $user, Resource: $resource, IsRead: $isRead}"
    }
}
