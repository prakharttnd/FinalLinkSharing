<div class="row">
    <ls:renderSmallImage photo="${subscribedTopicVO.photo}"/>
    <div style="margin-left: 90px;">
        <div class="col-sm-12">
            <div class="hidden" id="subscriptionTopicForm${subscribedTopicVO.topicId}">
                <g:form class="form-horizontal" controller="topic" action="update">
                    <div class="col-sm-6">
                        <g:textField name="subscriptionTopicName${subscribedTopicVO.topicId}" value="${subscribedTopicVO.topicName}"
                                     class="form-control" required="required"/>
                    </div>

                    <div class="col-sm-6">
                        <g:submitButton name="Save" id="${subscribedTopicVO.topicId}"
                                        class="btn btn-default active subscriptionTopicNameSubmitUpdate"/>
                        <g:submitButton name="Cancel" id="${subscribedTopicVO.topicId}"
                                        class="btn btn-default active subscriptionTopicNameCancelUpdate"/>
                    </div>
                </g:form>
            </div>
            <strong id="subscriptionTopicText${subscribedTopicVO.topicId}"><g:link controller="topic" action="show"
                                                                                   id="${subscribedTopicVO.topicId}"
                                                                                   class="showTopicName${subscribedTopicVO.topicId}">${subscribedTopicVO.topicName}</g:link></strong>
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