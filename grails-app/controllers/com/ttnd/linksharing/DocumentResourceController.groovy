package com.ttnd.linksharing

import com.ttnd.linksharing.co.DocumentResourceCO
import com.ttnd.linksharing.dto.ResponseDTO
import com.ttnd.linksharing.vo.TopicVO

class DocumentResourceController extends ResourceController {

    def topicService
    def documentResourceService

    def renderCreateDocumentResourceTemplate() {
        List<TopicVO> subscribedTopics = topicService.fetchSubscribedTopic(session.user)
        render template: 'create', model: [subscribedTopics: subscribedTopics]
    }

    def save(DocumentResourceCO documentResourceCO) {
        documentResourceCO.createdBy = session.user
        ResponseDTO responseDTO = documentResourceService.save(documentResourceCO)
        if (responseDTO.status == 200) {
            addToReadingItems(responseDTO.object)
        }
        renderAsJSON {
            responseDTO
        }
    }
}
