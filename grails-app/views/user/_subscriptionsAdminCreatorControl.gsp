<%@ page import="com.ttnd.linksharing.enums.*" %>
<div class="col-sm-5">
    <g:select name="seriousness" id="${subscriptionId}" from="${Seriousness.values()}" optionValue="displayText"
              class="form-control seriousness"
              value="${seriousness}"/>
</div>

<div class="col-sm-4">
    <g:select name="visibility" id="${topicId}" from="${Visibility.values()}" optionValue="displayText"
              class="form-control visibility"
              value="${visibility}"/>
</div>

<div class="col-sm-3">
    <a id="sendInvitation" href="#" data-toggle="modal" data-target="#sendInvitationModal"><span
            class="fa fa-envelope-o" style="font-size: 20px;"></span></a>&nbsp;
    <i id="${topicId}" class="fa fa-pencil-square-o editTopicName" style="font-size: 20px;"></i>&nbsp;
<g:link controller="topic" action="delete" id="${topicId}" class="glyphicon glyphicon-trash deletetopic"
        style="font-size: 20px;"></g:link>
    <br>
    <br>
</div>