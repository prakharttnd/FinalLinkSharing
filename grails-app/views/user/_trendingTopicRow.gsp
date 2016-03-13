<div class="row">
    <ls:renderSmallImage photo="${trendingTopicVO.photo}"/>
    <div style="margin-left: 90px;">
        <div class="col-sm-12">
            <strong><g:link controller="topic" action="show"
                            id="${trendingTopicVO.topicId}">${trendingTopicVO.topicName}</g:link></strong>
            <br><br>
        </div>

        <div class="col-xs-4">
            <span class="text-muted">@${trendingTopicVO.topicCreatorUsername}</span>
            <br>
            <g:if test="${trendingTopicVO.subscriptionId == 0}">
                <g:link controller="subscription" action="save" id="${trendingTopicVO.topicId}"
                        class="subscribeTopic">Subscribe</g:link>
            </g:if>
            <g:else>
                <g:link uri="/subscription/delete?id=${trendingTopicVO.subscriptionId}&creatorId=${trendingTopicVO.topicCreatorId}"
                        class="unsubscribeTopic">Unsubscribe</g:link>
            </g:else>
        </div>

        <div class="col-xs-4">
            <span class="text-muted">Subscriptions</span>
            <br>
            <span style="color: blue;">${trendingTopicVO.numberOfSubscriptions}</span>
        </div>

        <div class="col-xs-4">
            <span class="text-muted">Post</span>
            <br>
            <span style="color: blue;">${trendingTopicVO.numberOfPosts}</span>
            <br>
            <br>
        </div>
    </div>

    <div class="col-sm-5">
        <g:if test="${trendingTopicVO.subscriptionId != 0}">
            <g:select name="seriousness" id="${trendingTopicVO.subscriptionId}"
                      from="${com.ttnd.linksharing.enums.Seriousness.values()}"
                      optionValue="displayText" value="${trendingTopicVO.seriousness}"
                      class="form-control seriousness"/>
        </g:if>
    </div>

    <div class="col-sm-4">
        <g:if test="${(session.user.admin || (trendingTopicVO.topicCreatorId == session.user.id))}">
            <g:select name="visibility" id="${trendingTopicVO.topicId}"
                      from="${com.ttnd.linksharing.enums.Visibility.values()}"
                      optionValue="displayText" value="${trendingTopicVO.visibility}" class="form-control visibility"/>
        </g:if>
    </div>

    <div class="col-sm-3">
        <a id="sendInvitation" href="#" data-toggle="modal" data-target="#sendInvitationModal"><span
                class="fa fa-envelope-o" style="font-size: 20px;"></span></a>&nbsp;
        <g:if test="${(session.user.admin || (trendingTopicVO.topicCreatorId == session.user.id))}">
            <i class="fa fa-pencil-square-o" style="font-size: 20px;"></i>&nbsp;
            <g:link controller="topic" action="delete" id="${trendingTopicVO.topicId}"
                    class="glyphicon glyphicon-trash deletetopic"
                    style="font-size: 20px;"></g:link>
        </g:if>
        <br>
        <br>
    </div>
</div>
<br>