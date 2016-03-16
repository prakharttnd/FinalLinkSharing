<%@ page import="com.ttnd.linksharing.enums.Visibility" %>

<g:form class="form-horizontal" name="createTopicForm" controller="topic" action="save">
    <div class="form-group">
        <label class="control-label col-md-3" for="name">Name *:</label>

        <div class="col-md-9">
            <g:textField name="name" id="name" class="form-control"/>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-md-3" for="visibility">Visibilty *:</label>

        <div class="col-md-9">
            <g:select name="visibility" from="${Visibility.values()}" optionValue="displayText"
                      class="form-control"></g:select>
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
                <g:submitButton name="Save" class="btn btn-default btn-xs active" style="width: 125px;"/>
                <g:submitButton name="Cancel" class="btn btn-default btn-xs active" style="width: 125px;"
                                data-dismiss="modal"/>
            </center>
        </div>
    </div>
</g:form>

<script type="text/javascript">
    $(document).ready(function () {
        $("#createTopicForm").validate({
            rules: {
                name: {
                    required: true,
                    blank: true,
                    remote: "/topic/isTopicExists"
                },
                visibility: {
                    required: true
                }
            },
            messages: {
                name: {
                    blank: jQuery.validator.format("Topic name should not be blank"),
                    remote: jQuery.validator.format("You have already created topic with name '{0}'")
                }
            },
            submitHandler: function (form) {
                var isValidForm = $("#createTopicForm").valid();
                if (isValidForm) {
                    $("#saving").toggleClass("hidden");
                    var data = {
                        name: $("#name").val(),
                        visibility: $("#visibility").val()
                    };
                    $.post(form.action, data, onTopicSave);
                }
            }
        });

        var onTopicSave = function (response) {
            $("#responseMessage").html("");
            $("#responseMessage").removeClass("success");
            $("#responseMessage").removeClass("error");
            $("#saving").toggleClass("hidden");
            if (response.status == 200) {
                $("#createTopicForm").trigger('reset');
                $("#responseMessage").addClass("success").html(response.message);
                setTimeout(function () {
                    $('#createTopicModal').modal('hide');
                }, 1000);
            } else {
                $("#responseMessage").addClass("error").html(response.message);
            }
        }
    });
</script>