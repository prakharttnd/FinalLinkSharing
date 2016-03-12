package com.ttnd.linksharing.vo

import com.ttnd.linksharing.enums.Seriousness
import com.ttnd.linksharing.enums.Visibility

class TrendingTopicVO {
    Integer topicCreatorId
    byte[] photo
    String topicCreatorUsername
    String topicName
    Integer topicId
    Visibility visibility
    Integer subscriptionId
    Seriousness seriousness
    Integer numberOfSubscriptions
    Integer numberOfPosts

}

