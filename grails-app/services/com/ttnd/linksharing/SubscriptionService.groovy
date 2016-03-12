package com.ttnd.linksharing

import com.ttnd.linksharing.co.SubscriptionCO
import com.ttnd.linksharing.dto.ResponseDTO
import com.ttnd.linksharing.vo.SubscribedTopicVO
import grails.transaction.Transactional
import org.springframework.context.MessageSource

@Transactional
class SubscriptionService {

    MessageSource messageSource

    List<SubscribedTopicVO> subscribedTopics(User currentUser) {
        List<SubscribedTopicVO> subscribedTopics = Subscription.createCriteria().list(max: 5) {
            projections {
                'user' {
                    property('id')
                    property('photo')
                    property('username')
                }
                property('topic')
                property('id')
                property('seriousness')
            }
            eq('user', currentUser)
        }.collect {
            new SubscribedTopicVO(topicCreatorId: it[3].createdBy.id, photo: it[3].createdBy.photo, topicCreatorUsername: it[3].createdBy.username, topicId: it[3].id, topicName: it[3].name, visibility: it[3].visibility, numberOfSubscriptions: it[3].subscriptions.size(), numberOfResources: it[3].resources.size(), subscriptionId: it[4], seriousness: it[5])
        }
        return subscribedTopics
    }

//    def subscribedTopics(User currentUser) {
//        def topics = Resource.createCriteria().list {
//            projections {
//                'topic' {
//                    property('id')
//                }
//            }
//            order('dateCreated', 'desc')
//        }
//        def abc = Subscription.createCriteria().list {
//            projections {
//                'topic' {
//                    property('id')
//                }
//            }
//            'in'('topic', topics)
//            eq('user', currentUser.id)
//        }
//        return abc
//    }

    def save(SubscriptionCO subscriptionCO) {
        ResponseDTO responseDTO = new ResponseDTO()
        Subscription subscription = new Subscription(subscriptionCO.properties)
        if (subscription.save()) {
            responseDTO.status = 200
            responseDTO.message = messageSource.getMessage("subscription.successfull", [].toArray(), Locale.default)
            responseDTO.object = subscription
        } else {
            responseDTO.status = 201
            responseDTO.message = subscription.errors.allErrors.collect {
                messageSource.getMessage(it, null)
            }.join(",")
            responseDTO.object = subscription
        }
        return responseDTO
    }
}
