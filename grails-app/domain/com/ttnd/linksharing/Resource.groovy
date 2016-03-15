package com.ttnd.linksharing

import com.ttnd.linksharing.co.ResourceSearchCO
import com.ttnd.linksharing.co.SearchCO
import com.ttnd.linksharing.enums.Visibility

abstract class Resource {

    User createdBy
    Topic topic
    String description
    Date dateCreated
    Date lastUpdated

    static belongsTo = [topic: Topic, createdBy: User]

    static mapping = {
        description type: 'text'
    }

    static constraints = {
        createdBy nullable: false
        topic nullable: false
        description nullable: false, blank: false
    }

    static namedQueries = {
//        search { SearchCO co ->
//            if (co.q) {
//                ilike('description', "%${co.q}%")
//            }
//            eq('isRead', false)
//        }

        search { ResourceSearchCO resourceSearchCO ->
            if (resourceSearchCO.q) {
                or{
                    ilike("description", "%${resourceSearchCO.q}%")
                    'topic'{
                        ilike('name',"%%${resourceSearchCO.q}")
                    }
                }
            }
            'topic' {
                eq('visibility', Visibility.PUBLIC)
            }
        }
    }
}
