<div class="col-sm-5"></div>

<div class="col-sm-5">
    <g:select name="seriousness" id="${subscriptionId}" from="${com.ttnd.linksharing.enums.Seriousness.values()}"
              optionValue="displayText"
              value="${seriousness}" class="form-control seriousness"/>
</div>

<div class="col-sm-2">
    <a id="sendInvitation" href="#" data-toggle="modal" data-target="#sendInvitationModal"><span
            class="fa fa-envelope-o" style="font-size: 20px;"></span></a>
</div>