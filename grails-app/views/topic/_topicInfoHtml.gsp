<div class="row">
    <ls:renderSmallImage photo="${topicInfoVO.photo}"/>
    <div style="margin-left: 90px;">
        <div class="col-sm-12">
            <div class="hidden" id="topicForm${topicInfoVO.topicId}">
                <g:form class="form-horizontal" controller="topic" action="update">
                    <div class="col-sm-6">
                        <g:textField name="topicName${topicInfoVO.topicId}"
                                     value="${topicInfoVO.name}"
                                     class="form-control" required="required"/>
                    </div>

                    <div class="col-sm-6">
                        <g:submitButton name="Save" id="${topicInfoVO.topicId}"
                                        class="btn btn-default active submitUpdate"/>
                        <g:submitButton name="Cancel" id="${topicInfoVO.topicId}"
                                        class="btn btn-default active cancelUpdate"/>
                    </div>
                </g:form>
            </div>
            <strong id="topicText${topicInfoVO.topicId}"><g:link controller="topic" action="show"
                                                                 id="${topicInfoVO.topicId}"
                                                                 class="showTopicName${topicInfoVO.topicId}">${topicInfoVO.name}</g:link></strong>
            <br><br>
        </div>

        <div class="col-xs-4">
            <span class="text-muted">@${topicInfoVO.topicCreatorUserName}</span>
            <br>
            <g:if test="${topicInfoVO.subscriptionId == 0}">
                <g:link controller="subscription" action="save" id="${topicInfoVO.topicId}"
                        class="subscribeTopic">Subscribe</g:link>
            </g:if>
            <g:else>
                <g:link uri="/subscription/delete?id=${topicInfoVO.subscriptionId}&creatorId=${topicInfoVO.topicCreatorId}"
                        class="unsubscribeTopic">Unsubscribe</g:link>
            </g:else>
        </div>

        <div class="col-xs-4">
            <span class="text-muted">Subscriptions</span>
            <br>
            <span style="color: blue;">${topicInfoVO.numberOfSubscriptions}</span>
        </div>

        <div class="col-xs-4">
            <span class="text-muted">Post</span>
            <br>
            <span style="color: blue;">${topicInfoVO.numberOfPosts}</span>
        </div>
    </div>

    <div class="col-sm-5">
        <g:if test="${topicInfoVO.subscriptionId != 0}">
            <g:select name="seriousness" id="${topicInfoVO.subscriptionId}"
                      from="${com.ttnd.linksharing.enums.Seriousness.values()}"
                      optionValue="displayText" value="${topicInfoVO.seriousness}"
                      class="form-control seriousness"/>
        </g:if>
    </div>

    <div class="col-sm-4">
        <g:if test="${(session.user.admin || (topicInfoVO.topicCreatorId == session.user.id))}">
            <g:select name="visibility" id="${topicInfoVO.topicId}"
                      from="${com.ttnd.linksharing.enums.Visibility.values()}"
                      optionValue="displayText" value="${topicInfoVO.visibility}" class="form-control visibility"/>
        </g:if>
    </div>

    <div class="col-sm-3">
        <a id="sendInvitation" href="#" data-toggle="modal" data-target="#sendInvitationModal"><span
                class="fa fa-envelope-o" style="font-size: 20px;"></span></a>&nbsp;
        <g:if test="${(session.user.admin || (topicInfoVO.topicCreatorId == session.user.id))}">
            <i class="fa fa-pencil-square-o editTopicName" id="${topicInfoVO.topicId}"
               style="font-size: 20px;"></i>&nbsp;
            <g:link controller="topic" action="delete" id="${topicInfoVO.topicId}"
                    class="glyphicon glyphicon-trash deletetopic"
                    style="font-size: 20px;"></g:link>
        </g:if>
        <br>
        <br>
    </div>
</div>