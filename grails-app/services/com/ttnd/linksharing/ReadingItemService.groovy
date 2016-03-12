package com.ttnd.linksharing

import com.ttnd.linksharing.dto.ResponseDTO
import grails.transaction.Transactional
import org.springframework.context.MessageSource

@Transactional
class ReadingItemService {

    MessageSource messageSource

    def serviceMethod() {

    }

    def save(Long id, User user) {
        ResponseDTO responseDTO = new ResponseDTO()
        ReadingItem readingItem = ReadingItem.findOrSaveByUserAndResource(user, Resource.load(id))
        readingItem.isRead = true
        if (readingItem.save(flush: true)) {
            responseDTO.status = 200
            responseDTO.message = messageSource.getMessage("resource.read.success", [].toArray(), Locale.default)
        } else {
            responseDTO.status = 201
            responseDTO.message = messageSource.getMessage("resource.read.error", [].toArray(), Locale.default)
        }
        return responseDTO
    }
}
