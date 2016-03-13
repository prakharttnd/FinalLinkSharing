<div class="row">
    <div class="col-xs-3">
        <ls:renderBigImage photo="${resourceVO.photo}"/>
    </div>

    <div class="col-xs-9" style="margin-left: -35px;">
        <div class="row">
            <div class="col-xs-8">
                <strong>${resourceVO.resourceCreatorName}</strong>
                <br>
                <span class="text-muted">@${resourceVO.resourceCreatorUsername}</span>
            </div>

            <div class="col-md-4">
                <span>${resourceVO.topicName}</span>
                <br>
                <span class="text-muted"><ls:timePeriod date="${resourceVO.dateCreated}"/></span>
            </div>
        </div>

        <div class="row">
            <br>
        </div>

        <div class="row">
            <div class="col-sm-12">
                <span style="float: right;">rate here</span>
            </div>
        </div>
    </div>
</div>
<br>

<div class="row">
    <div class="col-xs-12">
        <p>${resourceVO.description}</p>
    </div>
</div>

<div class="row">
    <div class="col-md-4">
        <a href="http://www.facebook.com"><i class="fa fa-facebook-official"
                                             style="color: blue; font-size: 20px;"></i></a>&nbsp;&nbsp;
        <a href="http://www.tumblr.com"><i class="fa fa-tumblr" style="color: black; font-size: 20px;"></i>
        </a>&nbsp;&nbsp;
        <a href="http://www.google.com"><i class="fa fa-google-plus" style="color: red; font-size: 20px;"></i>
        </a>
    </div>

    <div class="col-md-8" style="float:right; text-align: right;">
        <ls:resourceLinks resourceCreatorId="${resourceVO.resourceCreatorId}" resourceId="${resourceVO.resourceId}"
                          descriptioin="${resourceVO.description}"/>
        &nbsp;&nbsp;
        <g:if test="${resourceVO.url}">
            <g:link url="${resourceVO.url}" target="_blank">View Full Site</g:link>
        </g:if>
        &nbsp;&nbsp;
        <g:if test="${resourceVO.filepath}">
            <g:link uri="/resource/download?filepath=${resourceVO.filepath}" target="_blank">Download</g:link>
        </g:if>
    </div>
</div>