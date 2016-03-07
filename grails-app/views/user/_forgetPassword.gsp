<g:form class="form-horizontal" controller="user" action="forgetPassword">
    <div class="form-group">
        <label class="control-label col-md-4" for="email">Email *:</label>

        <div class="col-md-8">
            <g:field type="email" name="email" id="email" class="form-control"/>
        </div>
    </div>

    <div class="form-group">
        <div class="col-md-6"></div>

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

