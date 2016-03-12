package com.ttnd.linksharing

import com.ttnd.linksharing.enums.Seriousness
import com.ttnd.linksharing.vo.TopicVO

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

    public static List<TopicVO> subscribedTopicByUser(User user) {
        List<TopicVO> subscribedTopics = Subscription.createCriteria().list {
            projections {
                'topic' {
                    property('id')
                    property('name')
                    'createdBy' {
                        property('username')
                    }
                }
            }
            eq('user', user)
        }.collect {
            return new TopicVO(id: it[0], name: it[1], username: it[2])
        }
        return subscribedTopics
    }

}
