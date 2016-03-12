<ls:renderBigImage photo="${userVO.photo}"/>

<div style="margin-left: 100px;">
    <div class="col-sm-12">
        <strong>${userVO.fullName}</strong>
        <br>
        <span class="text-muted">@${userVO.username}</span>
        <br><br>
    </div>

    <div class="col-xs-6">
        <span class="text-muted">Subscriptions</span>
        <br>
        <span style="color: blue;">${userVO.numberOfSubscriptions}</span>
    </div>

    <div class="col-xs-6">
        <span class="text-muted">Topics</span>
        <br>
        <span style="color: blue;">${userVO.numberOfTopics}</span>
    </div>
</div>
