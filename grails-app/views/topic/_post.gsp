<div class="row">
    <ls:renderBigImageMargin photo="${resourceVO.photo}"/>
    <div style="margin-left: 120px;">
        <div class="col-xs-9">
            <span><strong>${resourceVO.resourceCreatorName}</strong></span> <span
                class="text-muted">@${resourceVO.resourceCreatorUsername} <ls:timePeriod
                    date="${resourceVO.dateCreated}"/></span>
        </div>

        <div class="col-xs-3">
            <g:link controller="topic" action="show"
                    id="${resourceVO.topicId}">${resourceVO.topicName}</g:link>
        </div>

        <div class="col-xs-12">
            <p style="overflow: hidden; text-overflow: ellipsis; display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;">${resourceVO.description}</p>
        </div>

        <div class="col-xs-4">
            <a href="http://www.facebook.com"><i class="fa fa-facebook-official"
                                                 style="color: blue; font-size: 20px;"></i></a>&nbsp;&nbsp;
            <a href="http://www.tumblr.com"><i class="fa fa-tumblr" style="color: black; font-size: 20px;"></i>
            </a>&nbsp;&nbsp;
            <a href="http://www.google.com"><i class="fa fa-google-plus" style="color: red; font-size: 20px;"></i></a>
        </div>

        <div class="col-xs-8">
            <g:if test="${resourceVO.url}">
                <g:link url="${resourceVO.url}" target="_blank">View Full Site</g:link>
            </g:if>
            &nbsp;&nbsp;
            <g:if test="${resourceVO.filepath}">
                <g:link uri="/resource/download?filepath=${resourceVO.filepath}" target="_blank">Download</g:link>
            </g:if>
            &nbsp;&nbsp;
            <g:if test="${resourceVO.isRead}">
                <g:link controller="readingItem" action="unread" class="markasunread"
                        id="${resourceVO.readingItemId}">Mark as Unread</g:link>
            </g:if>
            <g:else>
                <g:link controller="readingItem" action="save" class="markasread"
                        id="${resourceVO.resourceId}">Mark as Read</g:link>
            </g:else>
            &nbsp;&nbsp;
            <g:link controller="resource" action="show" id="${resourceVO.resourceId}">View Post</g:link>
        </div>
    </div>
</div>
<br>