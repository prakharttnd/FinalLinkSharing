package com.ttnd.linksharing

import com.ttnd.linksharing.co.LinkResourceCO
import com.ttnd.linksharing.dto.ResponseDTO
import grails.transaction.Transactional
import org.springframework.context.MessageSource

@Transactional
class LinkResourceService {

    MessageSource messageSource

    def save(LinkResourceCO linkResourceCO) {
        ResponseDTO responseDTO = new ResponseDTO()
        LinkResource linkResource = new LinkResource(linkResourceCO.properties)
        if (linkResource.save()) {
            responseDTO.status = 200
            responseDTO.message = messageSource.getMessage("linkresource.saved.successfull", [].toArray(), Locale.default)
            responseDTO.object = linkResource
        } else {
            responseDTO.status = 201
            responseDTO.message = linkResource.errors.allErrors.collect {
                messageSource.getMessage(it, null)
            }.join(",")
            responseDTO.object = linkResource
        }
        return responseDTO
    }
}
