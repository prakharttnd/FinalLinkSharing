package com.ttnd.linksharing

import com.ttnd.linksharing.co.LinkResourceCO
import com.ttnd.linksharing.dto.ResponseDTO
import com.ttnd.linksharing.vo.TopicVO

class LinkResourceController extends ResourceController {

    def topicService
    def linkResourceService

    def renderCreateLinkResourceTemplate() {
        List<TopicVO> subscribedTopics = topicService.fetchSubscribedTopic(session.user)
        render template: 'create', model: [subscribedTopics: subscribedTopics]
    }

    def save(LinkResourceCO linkResourceCO) {
        linkResourceCO.createdBy = session.user
        ResponseDTO responseDTO = linkResourceService.save(linkResourceCO)
        if (responseDTO.status == 200) {
            addToReadingItems(responseDTO.object)
        }
        renderAsJSON {
            responseDTO
        }
    }
}
