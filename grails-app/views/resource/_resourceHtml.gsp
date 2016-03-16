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
                <g:link controller="topic" action="show" id="${resourceVO.topicId}">${resourceVO.topicName}</g:link>
                <br>
                <span class="text-muted"><ls:timePeriod date="${resourceVO.dateCreated}"/></span>
            </div>
        </div>

        <div class="row">
            <br>
        </div>

        <div class="row">
            <div class="col-sm-6">

            </div>

            <div class="col-sm-6">
                <g:form controller="resourceRating" action="save" id="${resourceVO.resourceId}">
                    <div class="form-group">
                        <div class="col-xs-6">
                            <g:select name="rating" class="form-control" from="[1, 2, 3, 4, 5]"
                                      value="${resourceVO.score}"></g:select>
                        </div>

                        <div class="col-xs-6">
                            <g:submitButton name="Vote" class="btn btn-default"/>
                        </div>
                    </div>
                </g:form>
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


<div class="modal fade" id="editDescriptionModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Edit Description</h4>
            </div>

            <div class="modal-body" id="editDescriptionModalBody">
                <g:form class="form-horizontal" name="editDescriptionForm" controller="resource" action="update"
                        id="${resourceVO.resourceId}">
                    <div class="form-group">
                        <label class="control-label col-md-3" for="description">Description *:</label>

                        <div class="col-md-9">
                            <g:textArea name="description" id="description" rows="5" value="${resourceVO.description}"
                                        class="form-control"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-6">
                            <div class="hidden" id="saving">
                                <asset:image src="spinner.gif"/> Saving...
                            </div>

                            <div>
                                <b><p id="responseMessage"></p></b>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <center>
                                <g:submitButton name="Save" class="btn btn-default btn-xs active"
                                                style="width: 125px;"/>
                                <g:submitButton name="Cancel" class="btn btn-default btn-xs active"
                                                style="width: 125px;"
                                                data-dismiss="modal"/>
                            </center>
                        </div>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $("#editDescriptionForm").validate({
            rules: {
                description: {
                    required: true,
                    blank: true
                }
            },
            messages: {
                description: {
                    blank: jQuery.validator.format("Description should not be blank")
                }
            },
            submitHandler: function (form) {
                var isValidForm = $("#editDescriptionForm").valid();
                if (isValidForm) {
                    $("#saving").toggleClass("hidden");
                    var data = {
                        description: $("#description").val()
                    };
                    $.post(form.action, data, onDescriptionUpdate);
                }
            }
        });

        var onDescriptionUpdate = function (response) {
            $("#responseMessage").html("");
            $("#responseMessage").removeClass("success");
            $("#responseMessage").removeClass("error");
            $("#saving").toggleClass("hidden");
            if (response.status == 200) {
                $("#responseMessage").addClass("success").html(response.message);
                setTimeout(function () {
                    $('#editDescriptionModal').modal('hide');
                }, 1000);
            } else {
                $("#responseMessage").addClass("error").html(response.message);
            }
        }
    });
</script>
