package com.ttnd.linksharing

class ReadingItemController extends BaseController {

    def readingItemService

    def index() {}

    def save() {
        long id = Long.parseLong(params.id)
        renderAsJSON {
            readingItemService.save(id, session.user)
        }
    }
}
