package com.ttnd.linksharing

import com.ttnd.linksharing.dto.ResponseDTO
import grails.converters.JSON

class ReadingItemController extends BaseController {

    def readingItemService

    def index() {}

    def save() {
        renderAsJSON {
            readingItemService.save(params.long("id"), session.user)
        }
    }

    def unread() {
        renderAsJSON {
            readingItemService.unread(params.long("id"))
        }
    }

    def toggleReadUnread() {
        ResponseDTO responseDTO = new ResponseDTO()
        long id = params.long("id")
        log.info "<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>"
        log.info id
        log.info "<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>"
        ReadingItem readingItem = ReadingItem.findOrCreateByResourceAndUser(Resource.load(id), session.user)
        if (readingItem.isRead) {
            readingItem.isRead = false
            responseDTO.message = "Resource unread successfully"
        } else {
            readingItem.isRead = true
            responseDTO.message = "Resource read successfully"
        }
        if (readingItem.save(flush: true)) {
            responseDTO.status = 200
        } else {
            responseDTO.status = 201
            responseDTO.message = "Please try later"
        }
        renderAsJSON {
            responseDTO
        }
    }


}
