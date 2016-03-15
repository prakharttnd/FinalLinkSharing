<div class="row">
    <ls:renderBigImageMargin photo="${resource.createdBy.photo}"/>
    <div style="margin-left: 120px;">
        <div class="col-xs-9">
            <span><strong>${resource.createdBy.fullName}</strong></span> <span
                class="text-muted">@${resource.createdBy.username} <ls:timePeriod
                    date="${resource.dateCreated}"/></span>
        </div>

        <div class="col-xs-3">
            <g:link controller="topic" action="show"
                    id="${resource.topic.id}">${resource.topic.name}</g:link>
        </div>

        <div class="col-xs-12">
            <p style="overflow: hidden; text-overflow: ellipsis; display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;">${resource.description}</p>
        </div>

        <div class="col-xs-4">
            <a href="http://www.facebook.com"><i class="fa fa-facebook-official"
                                                 style="color: blue; font-size: 20px;"></i></a>&nbsp;&nbsp;
            <a href="http://www.tumblr.com"><i class="fa fa-tumblr" style="color: black; font-size: 20px;"></i>
            </a>&nbsp;&nbsp;
            <a href="http://www.google.com"><i class="fa fa-google-plus" style="color: red; font-size: 20px;"></i></a>
        </div>

        <div class="col-xs-8">
            <g:if test="${(resource.class == com.ttnd.linksharing.LinkResource)}">
                <g:link url="${resource.url}" target="_blank">View Full Site</g:link>
            </g:if>
            &nbsp;&nbsp;
            <g:if test="${(resource.class == com.ttnd.linksharing.DocumentResource)}">
                <g:link uri="/resource/download?filepath=${resource.filepath}" target="_blank">Download</g:link>
            </g:if>
            &nbsp;&nbsp;
            <ls:markAsReadOrUnreadLink id="${resource.id}"/>
            &nbsp;&nbsp;
            <g:link controller="resource" action="show" id="${resource.id}">View Post</g:link>
        </div>
    </div>
</div>
<br>