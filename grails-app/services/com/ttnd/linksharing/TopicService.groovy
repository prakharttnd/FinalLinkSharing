package com.ttnd.linksharing

import com.ttnd.linksharing.co.InviteCO
import com.ttnd.linksharing.co.TopicCO
import com.ttnd.linksharing.dto.EmailDTO
import com.ttnd.linksharing.dto.ResponseDTO
import com.ttnd.linksharing.vo.ResourceVO
import com.ttnd.linksharing.vo.TopicInfoVO
import com.ttnd.linksharing.vo.TopicVO
import com.ttnd.linksharing.vo.UserVO
import grails.transaction.Transactional
import org.springframework.context.MessageSource

@Transactional
class TopicService {

    def grailsApplication

    def emailService

    MessageSource messageSource

    def isTopicExists(User user, String name) {
        Topic topic = Topic.findByCreatedByAndNameIlike(user, name)
        String result = topic ? false : true
        return result
    }

    def save(TopicCO topicCO) {
        ResponseDTO responseDTO = new ResponseDTO()
        Topic topic = new Topic(topicCO.properties)
        if (topic.save()) {
            responseDTO.status = 200
            responseDTO.message = messageSource.getMessage("topic.created.succesfully", topic.name.tokenize("").toArray(), Locale.default)
            responseDTO.object = topic
        } else {
            responseDTO.status = 201
            responseDTO.message = topic.errors.allErrors.collect { messageSource.getMessage(it, null) }.join(",")
            responseDTO.object = topic
        }
        return responseDTO
    }

    def fetchSubscribedTopic(User user) {
        List<TopicVO> subscribedTopics = Subscription.subscribedTopicByUser(user)
        return subscribedTopics
    }

    def invite(InviteCO inviteCO) {
        ResponseDTO responseDTO = new ResponseDTO()
        Subscription subscription = Subscription.createCriteria().get {
            'topic' {
                eq('id', inviteCO.topic)
            }
            'user' {
                eq('email', inviteCO.email)
            }
        }
        if (subscription) {
            responseDTO.status = 201
            responseDTO.message = messageSource.getMessage("allready.subscribed", [].toArray(), Locale.default)
        } else {
            String topicName = Topic.get(inviteCO.topic).name
            List<String> to = [inviteCO.email]
            String subject = messageSource.getMessage("topic.invite.email.subject", topicName.tokenize("").toArray(), Locale.default)
            String view = "/email/_invite"
            String inviteLink = grailsApplication.config.applicationUrl + "topic/join/" + inviteCO.topic
            Map model = ['topicName': topicName, 'senderName': inviteCO.senderName, 'inviteLink': inviteLink]
            EmailDTO emailDTO = new EmailDTO(to: to, subject: subject, view: view, model: model)
            emailService.sendMail(emailDTO)
            responseDTO.status = 200
            responseDTO.message = messageSource.getMessage("successfully.invited", [].toArray(), Locale.default)
        }
        return responseDTO
    }

    def fetchTopicInfo(long id, User user) {
        Topic topic = Topic.get(id)
        TopicInfoVO topicInfoVO = new TopicInfoVO(topicCreatorId: topic.createdBy.id, topicCreatorUserName: topic.createdBy.username, photo: topic.createdBy.photo, topicId: topic.id, name: topic.name, visibility: topic.visibility, numberOfSubscriptions: topic.subscriptions.size(), numberOfPosts: topic.resources.size())
        Subscription subscription = Subscription.findByTopicAndUser(topic, user)
        if (subscription) {
            topicInfoVO.subscriptionId = subscription.id
            topicInfoVO.seriousness = subscription.seriousness
        } else {
            topicInfoVO.subscriptionId = 0
            topicInfoVO.seriousness = null
        }
        return topicInfoVO
    }

    def fetchTopicUsers(long id) {
        List<Subscription> subscriptions = Subscription.findAllByTopic(Topic.load(id))
        List<UserVO> users = subscriptions.collect {
            new UserVO(id: it.user.id, fullName: it.user.fullName, username: it.user.username, photo: it.user.photo, numberOfSubscriptions: it.user.subscriptions.size(), numberOfTopics: it.user.topics.size())
        }
        return users
    }

    def fetchTopicPosts(long id, User user) {
        List<Resource> resources = Resource.findAllByTopic(Topic.load(id))
        List<ResourceVO> resourceVOs = resources.collect {
            ReadingItem readingItem = ReadingItem.findByResourceAndUser(it, user)
            ResourceVO resourceVO = new ResourceVO(resourceCreatorId: it.createdBy.id, resourceCreatorName: it.createdBy.fullName, resourceCreatorUsername: it.createdBy.username, photo: it.createdBy.photo, topicId: it.topic.id, topicName: it.topic.name, resourceId: it.id, description: it.description, dateCreated: it.dateCreated, resourceClass: it.class)
            if (resourceVO.resourceClass == LinkResource) {
                resourceVO.url = it.url
            } else {
                resourceVO.filepath = it.filepath
            }
            if (readingItem) {
                resourceVO.isRead = readingItem.isRead
                resourceVO.readingItemId = readingItem.id
            } else {
                resourceVO.readingItemId = 0
                resourceVO.isRead = false
            }
            return resourceVO
        }
        return resourceVOs
    }
}
