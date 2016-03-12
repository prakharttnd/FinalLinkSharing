<g:form class="form-horizontal" name="forgetPasswordForm" controller="user" action="forgetPassword">
    <div class="form-group">
        <label class="control-label col-md-3" for="emailField">Email *:</label>

        <div class="col-md-9">
            <g:textField name="emailField" id="emailField" class="form-control"/>
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
                <g:submitButton name="Submit" class="btn btn-default btn-xs active"
                                style="width: 125px;"/>
                <g:submitButton name="Cancel" class="btn btn-default btn-xs active"
                                style="width: 125px;" data-dismiss="modal"/>
            </center>
        </div>
    </div>
</g:form>


<script type="text/javascript">
    $(document).ready(function () {
        $("#forgetPasswordForm").validate({
            rules: {
                emailField: {
                    required: true,
                    blank: true,
                    email: true,
                    remote: '/base/isEmailExists'
                }
            },
            messages: {
                emailField: {
                    blank: jQuery.validator.format("Email should not be blank"),
                    remote: jQuery.validator.format("No user with email {0}")
                }
            },
            submitHandler: function (form) {
                var isValidForm = $("#forgetPasswordForm").valid();
                if (isValidForm) {
                    $("#sending").toggleClass("hidden");
                    var data = {
                        email: $("#emailField").val()
                    };
                    $.post(form.action, data, onEmailSend);
                }
            }
        });

        var onEmailSend = function (response) {
            console.log(response);
            $("#responseMessage").html("");
            $("#responseMessage").removeClass("success");
            $("#responseMessage").removeClass("error");
            $("#sending").toggleClass("hidden");
            if (response.status == 200) {
                $("#forgetPasswordForm").trigger('reset');
                $("#responseMessage").addClass("success").html(response.message);
            } else {
                $("#forgetPasswordForm").trigger('reset');
                $("#responseMessage").addClass("error").html(response.message);
            }
        }
    });
</script>

