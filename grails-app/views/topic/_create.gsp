<%@ page import="com.ttnd.linksharing.enums.Visibility" %>

<div class="modal-header">
    <label class="close" data-dismiss="modal">&times;</label>
    <h4 class="modal-title">Create Topic</h4>
</div>

<div class="modal-body">
    <g:form class="form-horizontal" name="createTopic" id="createTopic" controller="topic" action="save">
        <div class="form-group">
            <label class="control-label col-md-4" for="name">Name *:</label>

            <div class="col-md-8">
                <g:textField name="name" id="name" class="form-control"/>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-md-4" for="visibility">Visibilty *:</label>

            <div class="col-md-8">
                <g:select name="visibility" from="${Visibility.values()}" optionValue="displayText"
                          class="form-control"></g:select>
            </div>
        </div>

        <div class="form-group">
            <div class="col-md-6">
                <div class="hidden" id="saving">
                    <asset:image src="spinner.gif"/> Saving...
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
</div>