<div class="panel panel-default">
    <div class="panel-heading">Register</div>

    <div class="panel-body">
        <g:form enctype="multipart/form-data" class="form-horizontal" name="registerForm" controller="user"
                action="register">
            <div class="form-group">
                <label class="control-label col-md-5" for="firstName">First name *</label>

                <div class="col-md-7">
                    <g:textField name="firstName" id="firstName" class="form-control"/>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-5" for="lastName">Last name *</label>

                <div class="col-md-7">
                    <g:textField name="lastName" id="lastName" class="form-control"/>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-5" for="email">Email *</label>

                <div class="col-md-7">
                    <g:textField name="email" id="email" class="form-control"/>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-5" for="username">Username *</label>

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
                <label class="control-label col-md-5" for="confirmPassword">Confirm Password *</label>

                <div class="col-md-7">
                    <g:passwordField name="confirmPassword" id="confirmPassword" class="form-control"/>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-5" for="photo">Photo</label>

                <div class="col-md-7">
                    <input type="file" name="photo" id="photo" accept="image/*">
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-7">
                    <div class="hidden loader">
                        <asset:image src="spinner.gif"/> Saving...
                    </div>

                    <div>
                        <b><p id="responseMessage"></p></b>
                    </div>
                </div>

                <div class="col-md-5">
                    <g:submitButton name="Submit" id="saveUser" class="btn btn-default btn-xs active"
                                    style="float: right; width: 125px;"/>
                </div>
            </div>
        </g:form>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {

        $("#registerForm").validate({
            rules: {
                firstName: {
                    required: true,
                    blank: true
                },
                lastName: {
                    required: true,
                    blank: true
                },
                email: {
                    email: true,
                    required: true,
                    blank: true,
                    remote: "/user/isEmailExists"
                },
                username: {
                    required: true,
                    blank: true,
                    remote: "/user/isUsernameExists"
                },
                password: {
                    required: true,
                    blank: true,
                    minlength: 5,
                    equalTo: "#confirmPassword"
                },
                confirmPassword: {
                    required: true,
                    blank: true,
                    minlength: 5
                }
            },
            messages: {
                firstName: {
                    blank: jQuery.validator.format("Firstname should not be blank")
                },
                lastName: {
                    blank: jQuery.validator.format("Lastname should not be blank")
                },
                email: {
                    blank: jQuery.validator.format("Email should not be blank"),
                    remote: jQuery.validator.format("Email with {0} already exists.")
                },
                username: {
                    blank: jQuery.validator.format("Username should not be blank"),
                    remote: jQuery.validator.format("Username with {0} already exists.")
                },
                password: {
                    blank: jQuery.validator.format("Password should not be blank"),
                    equalTo: jQuery.validator.format("Password do not match Confirm Password.")
                },
                confirmPassword: {
                    blank: jQuery.validator.format("Confirm Password should not be blank")
                }
            },
            submitHandler: function (form) {
                var isValidForm = $("#registerForm").valid();
                if (isValidForm) {
                    form.trigger('submit');
                }
            }
        });
    });
</script>