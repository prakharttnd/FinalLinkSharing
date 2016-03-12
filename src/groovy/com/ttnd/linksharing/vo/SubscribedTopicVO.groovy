package com.ttnd.linksharing.vo

import com.ttnd.linksharing.enums.Seriousness
import com.ttnd.linksharing.enums.Visibility

class SubscribedTopicVO {
    Integer topicCreatorId
    Integer subscriptionId
    Integer topicId
    byte[] photo
    String topicCreatorUsername
    Integer numberOfSubscriptions
    Integer numberOfResources
    Visibility visibility
    Seriousness seriousness
    String topicName

}
