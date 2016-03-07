<div class="panel panel-default">
    <div class="panel-heading">Register</div>

    <div class="panel-body">
        <g:form class="form-horizontal" name="register" controller="user" action="register">
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
                    <g:field type="email" name="email" id="email" class="form-control"/>
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
                    <input type="file" name="photo" id="photo">
                </div>
            </div>
            <g:submitButton name="Submit" class="btn btn-default btn-xs active" style="float: right; width: 125px;"/>
        </g:form>
    </div>
</div>