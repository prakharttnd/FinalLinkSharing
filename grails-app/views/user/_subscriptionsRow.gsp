<div class="row">
    <ls:renderSmallImage photo="${subscribedTopicVO.photo}"/>
    <div style="margin-left: 90px;">
        <div class="col-sm-12">
            <strong><g:link controller="topic" action="show"
                            id="${subscribedTopicVO.topicId}">${subscribedTopicVO.topicName}</g:link></strong>
            <br><br>
        </div>

        <div class="col-xs-4">
            <span class="text-muted">@${subscribedTopicVO.topicCreatorUsername}</span>
            <br>
            <g:link uri="/subscription/delete?id=${subscribedTopicVO.subscriptionId}&creatorId=${subscribedTopicVO.topicCreatorId}"
                    class="unsubscribeTopic">Unsubscribe</g:link>
        </div>

        <div class="col-xs-4">
            <span class="text-muted">Subscriptions</span>
            <br>
            <span style="color: blue;">${subscribedTopicVO.numberOfSubscriptions}</span>
        </div>

        <div class="col-xs-4">
            <span class="text-muted">Post</span>
            <br>
            <span style="color: blue;">${subscribedTopicVO.numberOfResources}</span>
        </div>
    </div>
    <ls:subscribedTopicsControl creator="${subscribedTopicVO.topicCreatorId}"
                                visibility="${subscribedTopicVO.visibility}"
                                seriousness="${subscribedTopicVO.seriousness}" topicId="${subscribedTopicVO.topicId}"
                                subscriptionId="${subscribedTopicVO.subscriptionId}"/>
</div>
<br>