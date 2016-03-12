package com.ttnd.linksharing.vo

import com.ttnd.linksharing.enums.Seriousness
import com.ttnd.linksharing.enums.Visibility

class TopicInfoVO {
    Integer topicCreatorId
    String topicCreatorUserName
    byte[] photo
    Integer topicId
    String name
    Visibility visibility
    Integer numberOfSubscriptions
    Integer numberOfPosts
    Integer subscriptionId
    Seriousness seriousness
}
