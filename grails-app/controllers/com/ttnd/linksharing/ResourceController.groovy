package com.ttnd.linksharing

import com.ttnd.linksharing.co.UnreadResourceSearchCO
import grails.converters.JSON

class ResourceController extends BaseController {

    def resourceService

    def unreadResources(UnreadResourceSearchCO unreadResourceSearchCO) {
        unreadResourceSearchCO.user = session.user
        String html = ls.inboxResources(unreadResources: User.getUnreadResources(unreadResourceSearchCO))
        render([html: html] as JSON)
    }

    def fetchTrendingTopics() {
//        render resourceService.fetchTrendingTopics(session.user)
        String html = ls.trendingTopics(trendingTopics: resourceService.fetchTrendingTopics(session.user))
        render([html: html] as JSON)
    }

    private def addToReadingItems(Resource resource) {
        List<User> subscribedUser = resource.topic.subscriptions.user
        def ctx = startAsync()
        ctx.start {
            subscribedUser.each {
                ReadingItem readingItem
                if (it.id == session.user.id) {
                    readingItem = new ReadingItem(user: it, resource: resource, isRead: true)
                } else {
                    readingItem = new ReadingItem(user: it, resource: resource, isRead: false)
                }
                if (readingItem.save()) {
                    log.info "Reading Item saved"
                } else {
                    log.info "Error saving reading Item $readingItem.errors.allErrors"
                }
            }
            ctx.complete()
        }
    }

    def download() {
        byte[] bytes = new File(params.filepath).bytes
        response.setHeader("Content-disposition", "attachment;")
        response.contentLength = bytes.length
        response.outputStream << bytes
    }

}
