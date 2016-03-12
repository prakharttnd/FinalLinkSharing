package com.ttnd.linksharing

import com.ttnd.linksharing.co.DocumentResourceCO
import com.ttnd.linksharing.dto.ResponseDTO
import grails.transaction.Transactional
import org.springframework.context.MessageSource

@Transactional
class DocumentResourceService {

    MessageSource messageSource
    def grailsApplication

    def save(DocumentResourceCO documentResourceCO) {
        ResponseDTO responseDTO = new ResponseDTO()
        String fileExtension = "." + documentResourceCO.document.getContentType().split("/")[1]
        String filename = new Date().getTime().toString()
        String filepath = grailsApplication.config.serverURL + filename + fileExtension
        try {
            documentResourceCO.document.transferTo(new File(filepath))
            documentResourceCO.filepath = filepath
//            documentResourceCO.filepath = "/home/prakhar/"
            DocumentResource documentResource = new DocumentResource(documentResourceCO.properties)
            if (documentResource.save()) {
                responseDTO.status = 200
                responseDTO.message = messageSource.getMessage("documentresource.saved.successfull", [].toArray(), Locale.default)
                responseDTO.object = documentResource
            } else {
                responseDTO.status = 201
                responseDTO.message = documentResource.errors.allErrors.collect {
                    messageSource.getMessage(it, null)
                }.join(",")
                responseDTO.object = documentResource
            }
        } catch (Exception e) {
            log.info e.getMessage()
            responseDTO.status = 201
            responseDTO.message = messageSource.getMessage("error.fileuplaoding", [].toArray(), Locale.default)
        }
        return responseDTO
    }
}
