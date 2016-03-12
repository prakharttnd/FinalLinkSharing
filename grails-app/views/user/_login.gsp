<div class="panel panel-default">
    <div class="panel-heading">Login</div>

    <div class="panel-body">
        <g:form class="form-horizontal" name="loginForm" controller="user" action="loginHandler">
            <div class="form-group">
                <label class="control-label col-md-5" for="username">Email/Username *</label>

                <div class="col-md-7">
                    <g:textField name="username" id="username" class="form-control"/>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-5" for="password">Password *</label>

                <div class="col-md-7">
                    <g:passwordField name="password" id="password" class="form-control"/>
                </div>
            </div>

            <div class="form-group">
                <span id="forgetPassword" data-toggle="modal" data-target="#forgetPasswordModal"
                      style="color: blue; margin-left: 75px;"><u>Forgot Password</u></span>
                <g:submitButton name="Login" class="btn btn-default btn-xs active"
                                style="float: right; width: 125px; margin-right: 15px;"/>
            </div>

            <div class="form-group loggingIn hidden">
                <div class="col-md-12">
                    <div class="loggingInLoader hidden">
                        <asset:image src="spinner.gif"/> Loading...
                    </div>
                    <b><p id="loginMessage"></p></b>
                </div>
            </div>
        </g:form>
    </div>
</div>


<div id="forgetPasswordModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Forgot Password</h4>
            </div>

            <div class="modal-body" id="forgetPasswordModalBody">
                <asset:image src="spinner.gif"/> Loading...
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {

        $('#forgetPassword').click(function () {
            $.post("/user/renderForgetPasswordTemplate", function (response) {
                $('#forgetPasswordModalBody').html(response);
            });
        });

        $("#loginForm").validate({
            rules: {
                username: {
                    required: true,
                    blank: true
                },
                password: {
                    required: true,
                    blank: true,
                    minlength: 5
                }
            },
            messages: {
                username: {
                    blank: jQuery.validator.format("Username should not be blank")
                },
                password: {
                    blank: jQuery.validator.format("Password should not be blank")
                }
            },
            submitHandler: function (form) {
                var isValidForm = $('#loginForm').valid();
                if (isValidForm) {
                    $(".loggingIn").removeClass("hidden");
                    $(".loggingInLoader").toggleClass("hidden");
                    var data = {
                        username: $("#username").val(),
                        password: $("#password").val()
                    }
                    $.post(form.action, data, onLoginResponse);
                }
            }
        });

        var onLoginResponse = function (response) {
            if (response.status == 200 || response.status == 201) {
                $(".loggingInLoader").toggleClass("hidden");
                if (response.object == null) {
                    if (response.status == 200) {
                        $('#loginForm').trigger('reset');
                        $('#loginMessage').removeClass('error').removeClass('success').addClass('warning').html(response.message);
                    } else {
                        $('#loginForm').trigger('reset');
                        $('#loginMessage').removeClass('success').removeClass('warning').addClass('error').html(response.message);
                    }
                } else {
                    $('#loginForm').trigger('reset');
                    $('#loginMessage').removeClass('warning').removeClass('error').addClass('success').html(response.message);
                    window.location.href = "/user/dashboard";
                }
            } else {
                $(".loggingInLoader").toggleClass("hidden");
                $('#loginMessage').removeClass('success').removeClass('warning').addClass('error').html(response.message);
            }
        }
    });
</script>

