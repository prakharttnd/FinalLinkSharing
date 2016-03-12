package com.ttnd.linksharing

import com.ttnd.linksharing.dto.ResponseDTO
import com.ttnd.linksharing.enums.Seriousness
import grails.converters.JSON

class SubscriptionController extends BaseController {

    def subscriptionService

    def index() {}

    def subscribedTopics() {
        String html = ls.subscribedTopics(subscribedTopics: subscriptionService.subscribedTopics(session.user))
        render([html: html] as JSON)
//        render subscriptionService.subscribedTopics(session.user)
    }

    def update() {
        ResponseDTO responseDTO = new ResponseDTO()
        Subscription subscription = Subscription.get(params.long("subscriptionId"))
        subscription.seriousness = params.seriousness
        if (subscription.save(flush: true)) {
            responseDTO.status = 200
            responseDTO.message = "Subscription seriousness changes to " + params.seriousness
        } else {
            responseDTO.status = 201
            responseDTO.message = "Please try later"
        }
        renderAsJSON {
            responseDTO
        }
    }

    def save() {
        Long topicId = params.long("id")
        ResponseDTO responseDTO = new ResponseDTO()
        Subscription subscription = new Subscription(topic: topicId, user: session.user, seriousness: Seriousness.SERIOUS)
        if (subscription.save(flush: true)) {
            responseDTO.status = 200
            responseDTO.message = "Subscribed Successfully"
            addReadingItem(topicId)
        } else {
            responseDTO.status = 201
            responseDTO.message = "Please Try later"
        }
        renderAsJSON {
            responseDTO
        }
    }

    def delete() {
        Long creatorId = params.long("creatorId")
        Long id = params.long("id")
        ResponseDTO responseDTO = new ResponseDTO()
        if (creatorId == session.user.id) {
            responseDTO.status = 202
            responseDTO.message = "You cant unsubscribe your own topic."
        } else {
            Subscription subscription = Subscription.load(id)
            Topic topic = subscription.topic
            try {
                subscription.delete(flush: true)
                responseDTO.status = 200
                responseDTO.message = "Unsubscribed Successfully"
                deleteReadingItems(topic)
            } catch (Exception e) {
                responseDTO.status = 201
                responseDTO.message = "Please Try Later"
            }
        }
        renderAsJSON {
            responseDTO
        }
    }

    private def addReadingItem(long topicId) {
        Topic topic = Topic.load(topicId)
        List<Resource> resources = Resource.findAllByTopic(topic)
        def ctx = startAsync()
        ctx.start {
            resources.each { Resource resource ->
                ReadingItem readingItem = new ReadingItem(resource: resource, user: session.user, isRead: false)
                if (readingItem.save(flush: true)) {
                    log.info "Reading Item saved succesfully"
                } else {
                    log.info "Error saving reading item " + readingItem.errors.allErrors
                }
            }
            ctx.complete()
        }
    }

    private def deleteReadingItems(Topic topic) {
        List<Resource> resources = Resource.findAllByTopic(topic)
        log.info resources
        List<ReadingItem> readingItems = ReadingItem.findAllByUserAndResourceInList(session.user, resources)
        readingItems.each { ReadingItem readingItem ->
            if (readingItem.delete(flush: true)) {
                log.info "Reading Item delete successfully"
            } else {
                log.info "Error delete reading item " + readingItem.errors.allErrors
            }
        }
    }
}
