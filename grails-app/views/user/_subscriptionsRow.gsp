<div class="row">
    <ls:renderSmallImage photo="${subscribedTopicVO.photo}"/>
    <div style="margin-left: 90px;">
        <div class="col-sm-12">
            <div class="hidden editTopicForm">
                <g:form class="form-horizontal" controller="topic" action="update">
                    <div class="col-sm-6">
                        <g:textField name="topicName" value="${subscribedTopicVO.topicName}" class="form-control"/>
                    </div>

                    <div class="col-sm-6">
                        <g:submitButton name="Save" id="updateTopicName" class="btn btn-default active"/>
                        <g:submitButton name="Cancel" id="cancelUpdate" class="btn btn-default active"/>
                    </div>
                </g:form>
            </div>
            <strong class="topicText"><g:link controller="topic" action="show"
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