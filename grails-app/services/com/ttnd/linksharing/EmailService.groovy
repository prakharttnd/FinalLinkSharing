package com.ttnd.linksharing

import com.ttnd.linksharing.dto.EmailDTO
import grails.transaction.Transactional

@Transactional
class EmailService {

    def mailService

    def sendMail(EmailDTO emailDTO) {
        mailService.sendMail {
            async true
            to emailDTO.to.toArray()
            subject emailDTO.subject
            if (emailDTO.content) {
                html emailDTO.content
            } else {
                body(view: emailDTO.view, model: emailDTO.model)
            }
        }
    }
}
