<div class="panel panel-default">
    <div class="panel-heading">Login</div>

    <div class="panel-body">
        <g:form class="form-horizontal" name="login" controller="user" action="loginHandler">
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
                <g:link action="#" id="forget-password" data-toggle="modal" data-target="#forgetPasswordModal"
                        style="color: blue; margin-left: 75px;"><U>Forgot Password</U></g:link>
                <g:submitButton name="Login" class="btn btn-default btn-xs active"
                                style="float: right; width: 125px; margin-right: 15px;"/>
            </div>
        </g:form>
    </div>
</div>


<div id="forgetPasswordModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Forgot Password</h4>
            </div>

            <div class="modal-body" id="forgetPasswordModalBody">
                <asset:image src="spinner.gif"/> Loading...
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var loadForgetPasswordModal = $.post("/user/renderForgetPasswordTemplate", function (response) {
        $('#forgetPasswordModalBody').html(response);
    });

    $('#forget-password').click(loadForgetPasswordModal);
</script>