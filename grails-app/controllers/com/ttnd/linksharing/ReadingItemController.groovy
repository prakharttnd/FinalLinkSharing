package com.ttnd.linksharing

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
}
