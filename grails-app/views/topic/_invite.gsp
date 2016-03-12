<g:form class="form-horizontal" name="inviteTopicForm" controller="topic" action="invite">
    <div class="form-group">
        <label class="control-label col-md-3" for="emailField">Email *:</label>

        <div class="col-md-9">
            <g:textField name="emailField" id="emailField" class="form-control"/>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-md-3" for="topic">Topic *:</label>

        <div class="col-md-9">
            <g:select name="topic" from="${subscribedTopics}" optionKey="id" optionValue="displayName"
                      class="form-control"></g:select>
        </div>
    </div>

    <div class="form-group">
        <div class="col-md-6">
            <div class="hidden" id="sending">
                <asset:image src="spinner.gif"/> Sending...
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
        $("#inviteTopicForm").validate({
            rules: {
                emailField: {
                    required: true,
                    blank: true,
                    email: true,
                    remote: '/base/isEmailExists'
                },
                topic: {
                    required: true
                }
            },
            messages: {
                emailField: {
                    blank: jQuery.validator.format("Email should not be blank"),
                    remote: jQuery.validator.format("No user with email {0}")
                }
            },
            submitHandler: function (form) {
                var isValidForm = $("#inviteTopicForm").valid();
                if (isValidForm) {
                    $("#sending").toggleClass("hidden");
                    var data = {
                        email: $("#emailField").val(),
                        topic: $("#topic").val()
                    };
                    $.post(form.action, data, onTopicInvite);
                }
            }
        });

        var onTopicInvite = function (response) {
            $("#responseMessage").html("");
            $("#responseMessage").removeClass("success");
            $("#responseMessage").removeClass("error");
            $("#sending").toggleClass("hidden");
            if (response.status == 200) {
                $("#inviteTopicForm").trigger('reset');
                $("#responseMessage").addClass("success").html(response.message);
            } else {
                $("#responseMessage").addClass("error").html(response.message);
            }
        }
    });
</script>