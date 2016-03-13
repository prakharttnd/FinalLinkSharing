package com.ttnd.linksharing

import com.ttnd.linksharing.co.InviteCO
import com.ttnd.linksharing.co.TopicCO
import com.ttnd.linksharing.dto.ResponseDTO
import com.ttnd.linksharing.vo.TopicVO
import grails.converters.JSON

class TopicController extends BaseController {

    def topicService

    def index() {}

    def renderCreateTopicTemplate() {
        render template: 'create'
    }

    def renderSendInvitationTemplate() {
        log.info "sdjhbsjdbjsddbvjsdbvjhbsdjvbjb"
        List<TopicVO> subscribedTopics = topicService.fetchSubscribedTopic(session.user)
        render template: 'invite', model: [subscribedTopics: subscribedTopics]
    }

    def isTopicExists() {
        render topicService.isTopicExists(session.user, params.name)
    }

    def save(TopicCO topicCO) {
        topicCO.createdBy = session.user
        renderAsJSON {
            topicService.save(topicCO)
        }
    }

    def delete() {
        ResponseDTO responseDTO = new ResponseDTO()
        Topic topic = Topic.load(Long.parseLong(params.id))
        try {
            topic.delete(flush: true)
            responseDTO.status = 200
        } catch (Exception e) {
            responseDTO.status = 201
        }
        renderAsJSON {
            responseDTO
        }
    }

    def invite(InviteCO inviteCO) {
        inviteCO.senderName = session.user.username
        renderAsJSON {
            topicService.invite(inviteCO)
        }
    }

    def show() {
        String topicName = Topic.get(params.long("id"))?.name
        if (topicName) {
            render view: 'show', model: [topicName: topicName]
        } else {
            redirect(controller: 'user', action: 'index')
        }

    }

    def info() {
        String html = ls.topicInfo(topicInfoVO: topicService.fetchTopicInfo(params.long("id"), session.user))
        render([html: html] as JSON)
    }

    def users() {
        String html = ls.topicShowUsers(users: topicService.fetchTopicUsers(params.long("id")))
        render([html: html] as JSON)
    }

    def posts() {
        String html = ls.topicShowPosts(posts: topicService.fetchTopicPosts(params.long("id"), session.user))
        render([html: html] as JSON)
    }

    def update() {
        ResponseDTO responseDTO = new ResponseDTO()
        String topicName = params.name
        String visibility = params.visibility
        long id = params.long("topicId")
        if (topicName) {

        } else if (visibility) {
            Topic topic = Topic.get(id)
            topic.visibility = visibility
            if (topic.save(flush: true)) {
                responseDTO.status = 200
                responseDTO.message = "Visibility changed to " + visibility
            } else {
                responseDTO.status = 201
                responseDTO.message = "Please try later"
            }
        }
        renderAsJSON {
            responseDTO
        }
    }
}
