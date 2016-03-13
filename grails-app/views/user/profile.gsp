<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>User Profile</title>
</head>

<body>
<div class="col-md-5">
    <g:render template="userInfo"/>
    <g:render template="topics"/>
</div>

<div class="col-md-7">
    <div class="panel panel-default">
        <div class="panel-heading">Profile</div>

        <div class="panel-body">
            <g:form enctype="multipart/form-data" class="form-horizontal" name="profileForm" controller="user"
                    action="update">
                <div class="form-group">
                    <label class="control-label col-md-4" for="firstName">First name *</label>

                    <div class="col-md-8">
                        <g:textField name="firstName" id="firstName" class="form-control" value="${user.firstName}"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-4" for="lastName">Last name *</label>

                    <div class="col-md-8">
                        <g:textField name="lastName" id="lastName" class="form-control" value="${user.lastName}"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-4" for="username">Username *</label>

                    <div class="col-md-8">
                        <g:textField name="username" id="username" class="form-control" value="${user.username}"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-4" for="photo">Photo</label>

                    <div class="col-md-8">
                        <input type="file" name="photo" id="photo" accept="image/*">
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-md-8">
                        <div class="hidden loader">
                            <asset:image src="spinner.gif"/> Saving...
                        </div>

                        <div>
                            <b><p id="responseMessage"></p></b>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <g:submitButton name="Update" id="saveUser" class="btn btn-default btn-xs active"
                                        style="float: right; width: 125px;"/>
                    </div>
                </div>
            </g:form>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">Change Password</div>

        <div class="panel-body">
            <g:form class="form-horizontal" name="updatepasswordForm" controller="user"
                    action="updatePassword">
                <div class="form-group">
                    <label class="control-label col-md-4" for="firstName">Password *</label>

                    <div class="col-md-8">
                        <g:passwordField name="passwordField" id="passwordField" class="form-control"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-4" for="firstName">Confirm Password *</label>

                    <div class="col-md-8">
                        <g:passwordField name="confirmPasswordField" id="confirmPasswordField" class="form-control"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-md-8">
                        <div class="hidden loader">
                            <asset:image src="spinner.gif"/> Saving...
                        </div>

                        <div>
                            <b><p id=""></p></b>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <g:submitButton name="Update" id="saveUser" class="btn btn-default btn-xs active"
                                        style="float: right; width: 125px;"/>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        var fetchUserInfo = function () {
            $.ajax({
                url: "/user/fetchUserInfo",
                type: "post",
                success: function (response) {
                    $('#userInfoBody').html(response.html);
                }
            });
        }

        var fetchTopics = function () {
            $.ajax({
                url: "/user/topics",
                type: 'post',
                success: function (response) {
                    $('#topicsBody').html(response.html);
                }
            });
        }

        $(document).on('change', '.seriousness', function () {
//            console.log(this)
//            console.log(this.value)
            var data = {
                seriousness: this.value,
                subscriptionId: this.id
            }
            $.ajax({
                url: '/subscription/update',
                data: data,
                type: 'post',
                success: function (response) {
                    console.log(response)
                    if (response.status == 200) {
                        showalert(response.message);
                    } else {
                        showalert(response.message);
                    }
                }
            });
        });

        $(document).on('click', '.unsubscribeTopic', function (event) {
            $.ajax({
                url: this.href,
                type: 'post',
                success: function (response) {
                    console.log(response)
                    if (response.status == 200) {
                        showalert(response.message);
                    } else if (response.status == 202) {
                        showalert(response.message);
                    } else {
                        showalert(response.message);
                    }
                }
            });
            event.preventDefault();
        });

        $(document).on('click', '.subscribeTopic', function (event) {
            $.ajax({
                url: this.href,
                type: 'post',
                success: function (response) {
                    console.log(response)
                    if (response.status == 200) {
                        showalert(response.message);
                    } else {
                        showalert(response.message);
                    }
                }
            });
            event.preventDefault();
        });

        $(document).on('click', '.deletetopic', function (event) {
            $.ajax({
                url: this.href,
                type: 'post',
                success: function (response) {
                    if (response.status == 200) {
                        showalert(response.message);
                        fetchUserInfo();
                        fetchTopics();
                    } else {
                        showalert(response.message);
                    }
                }
            });
            event.preventDefault();
        });

        $(document).on('change', '.visibility', function () {
            console.log(this.id)
            console.log(this.value)
            var data = {
                visibility: this.value,
                topicId: this.id
            }
            $.ajax({
                url: '/topic/update',
                data: data,
                type: 'post',
                success: function (response) {
                    console.log(response)
                    if (response.status == 200) {
                        $('#message-alert').html(response.message);
                    } else {
                        $('#message-alert').html(response.message);
                    }
                }
            });
        });

        window.onload = function () {
            fetchUserInfo();
            fetchTopics();
        }

        $("#profileForm").validate({
            rules: {
                firstName: {
                    required: true,
                    blank: true
                },
                lastName: {
                    required: true,
                    blank: true
                },
                username: {
                    required: true,
                    blank: true
                }
            },
            messages: {
                firstName: {
                    blank: jQuery.validator.format("Firstname should not be blank")
                },
                lastName: {
                    blank: jQuery.validator.format("Lastname should not be blank")
                },
                username: {
                    blank: jQuery.validator.format("Username should not be blank"),
                    //remote: jQuery.validator.format("Username with {0} already exists.")
                }
            },
            submitHandler: function (form) {
                var isValidForm = $("#profileForm").valid();
                if (isValidForm) {
                    form.trigger('submit');
                }
            }
        });

        $("#updatepasswordForm").validate({
            rules: {
                passwordField: {
                    required: true,
                    blank: true,
                    minlength: 5,
                    equalTo: "#confirmPasswordField"
                },
                confirmPasswordField: {
                    required: true,
                    blank: true,
                    minlength: 5
                }
            },
            messages: {
                passwordField: {
                    blank: jQuery.validator.format("Password should not be blank"),
                    equalTo: jQuery.validator.format("Password do not match Confirm Password.")
                },
                confirmPasswordField: {
                    blank: jQuery.validator.format("Confirm Password should not be blank")
                }
            },
            submitHandler: function (form) {
                var isValidForm = $("#updatepasswordForm").valid();
                if (isValidForm) {
                    form.trigger('submit');
                }
            }
        });
    });
</script>
</body>
</html>