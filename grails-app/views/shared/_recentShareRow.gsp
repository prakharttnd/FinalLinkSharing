<div class="row">
    <ls:renderBigImageMargin photo="${recentShareVO.photo}"/>

    <div style="margin-left: 120px;">
        <div class="col-md-9">
            <span><strong>${recentShareVO.fullName}</strong></span>  <span
                class="text-muted">@${recentShareVO.username} <ls:timePeriod
                    date="${recentShareVO.dateCreated}"/></span>
        </div>

        <div class="col-md-3">
            <g:link controller="topic" action="show" id="${recentShareVO.topicId}">${recentShareVO.topicName}</g:link>
        </div>

        <div class="col-xs-12">
            <p style="overflow: hidden; text-overflow: ellipsis; display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;">${recentShareVO.description}</p>
        </div>

        <div class="col-sm-9">
            <a href="http://www.facebook.com"><i class="fa fa-facebook-official"
                                                 style="color: blue; font-size: 20px;"></i></a>&nbsp;&nbsp;
        %{--<a class="fb-share-button" data-href="https://developers.facebook.com/docs/plugins/"--}%
        %{--data-layout="button"></a>&nbsp;&nbsp;--}%
        %{--<a class="tumblr-share-button" href="https://www.tumblr.com/share"></a>&nbsp;&nbsp;--}%
            <a href="http://www.tumblr.com"><i class="fa fa-tumblr" style="color: black; font-size: 20px;"></i>
            </a>&nbsp;&nbsp;
            <a href="http://www.google.com"><i class="fa fa-google-plus" style="color: red; font-size: 20px;"></i></a>
        </div>

        <div class="col-sm-3">
            <g:link controller="resource" action="show" id="${recentShareVO.resourceId}"><u>View post</u></g:link>
        </div>
    </div>
</div>
<br>