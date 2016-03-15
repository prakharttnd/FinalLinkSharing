package com.ttnd.linksharing

import com.ttnd.linksharing.co.ResourceSearchCO
import com.ttnd.linksharing.co.UnreadResourceSearchCO
import com.ttnd.linksharing.dto.ResponseDTO
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

    def show() {


    }

    def delete() {
        long id = params.long("id")
        ResponseDTO responseDTO = new ResponseDTO()
        Resource resource = Resource.load(id)
        try {
            resource.delete(flush: true)
            responseDTO.status = 200
            responseDTO.message = "Resource Deleted successfully"
        } catch (Exception e) {
            responseDTO.status = 201
            responseDTO.message = "Please try later"
        }
        renderAsJSON {
            responseDTO
        }
    }

    def update() {
        ResponseDTO responseDTO = new ResponseDTO()
        long id = params.long("id")
        String description = params.description
        Resource resource = Resource.get(id)
        resource.description = description
        if (resource.save(flush: true)) {
            responseDTO.status = 200
            responseDTO.message = "Description updated successfully"
        } else {
            responseDTO.status = 200
            responseDTO.message = "Please try later"
        }
        renderAsJSON {
            responseDTO
        }
    }

    def info() {
        String html = ls.resource(resourceVO: resourceService.fetchResourceInfo(params.long("id"), session.user))
        render([html: html] as JSON)
    }

    def search(ResourceSearchCO resourceSearchCO) {
        List<Resource> resources = Resource.search(resourceSearchCO).list()
        String html = ls.searchResource(resources: resources)
        render([html: html] as JSON)
    }

}
