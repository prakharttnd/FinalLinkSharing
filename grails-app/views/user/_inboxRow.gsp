<div class="row">
    <ls:renderBigImageMargin photo="${unreadResourceVO.photo}"/>
    <div style="margin-left: 120px;">
        <div class="col-xs-9">
            <span><strong>${unreadResourceVO.resourceCreatorName}</strong></span> <span
                class="text-muted">@${unreadResourceVO.resourceCreatorUsername} <ls:timePeriod
                    date="${unreadResourceVO.dateCreated}"/></span>
        </div>

        <div class="col-xs-3">
            <g:link controller="topic" action="show"
                    id="${unreadResourceVO.topicId}">${unreadResourceVO.topicName}</g:link>
        </div>

        <div class="col-xs-12">
            <p style="overflow: hidden; text-overflow: ellipsis; display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;">${unreadResourceVO.description}</p>
        </div>

        <div class="col-xs-4">
            <a href="http://www.facebook.com"><i class="fa fa-facebook-official"
                                                 style="color: blue; font-size: 20px;"></i></a>&nbsp;&nbsp;
            <a href="http://www.tumblr.com"><i class="fa fa-tumblr" style="color: black; font-size: 20px;"></i>
            </a>&nbsp;&nbsp;
            <a href="http://www.google.com"><i class="fa fa-google-plus" style="color: red; font-size: 20px;"></i></a>
        </div>

        <div class="col-xs-8">
            <g:if test="${unreadResourceVO.url}">
                <g:link url="${unreadResourceVO.url}" target="_blank">View Full Site</g:link>
            </g:if>
            &nbsp;&nbsp;
            <g:if test="${unreadResourceVO.filepath}">
                <g:link uri="/resource/download?filepath=${unreadResourceVO.filepath}" target="_blank">Download</g:link>
            </g:if>
            &nbsp;&nbsp;
            <g:link controller="readingItem" action="save" class="markasread"
                    id="${unreadResourceVO.resourceId}">Mark as Read</g:link>
            &nbsp;&nbsp;
            <g:link controller="resource" action="show" id="${unreadResourceVO.resourceId}">View Post</g:link>
        </div>
    </div>
</div>
<br>