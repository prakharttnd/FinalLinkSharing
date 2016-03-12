<g:form class="form-horizontal" name="createResourceForm" controller="linkResource" action="save">
    <div class="form-group">
        <label class="control-label col-md-3" for="urlField">Link *:</label>

        <div class="col-md-9">
            <g:textField name="urlField" id="urlField" class="form-control"/>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-md-3" for="description">Description *:</label>

        <div class="col-md-9">
            <g:textArea name="description" id="description" class="form-control" rows="5"/>
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
        $("#createResourceForm").validate({
            rules: {
                urlField: {
                    required: true,
                    blank: true,
                    url: true
                },
                description: {
                    required: true,
                    blank: true
                },
                topic: {
                    required: true
                }
            },
            messages: {
                urlField: {
                    blank: jQuery.validator.format("Link should not be blank")
                },
                description: {
                    blank: jQuery.validator.format("Description should not be blank")
                }
            },
            submitHandler: function (form) {
                var isValidForm = $("#createResourceForm").valid();
                if (isValidForm) {
                    $("#saving").toggleClass("hidden");
                    var data = {
                        url: $("#urlField").val(),
                        description: $("#description").val(),
                        topic: $("#topic").val()
                    };
                    $.post(form.action, data, onLinkResourceSave);
                }
            }
        });

        var onLinkResourceSave = function (response) {
            console.log(response)
            $("#responseMessage").html("");
            $("#responseMessage").removeClass("success");
            $("#responseMessage").removeClass("error");
            $("#saving").toggleClass("hidden");
            if (response.status == 200) {
                $("#createResourceForm").trigger('reset');
                $("#responseMessage").addClass("success").html(response.message);
            } else {
                $("#responseMessage").addClass("error").html(response.message);
            }
        }
    });
</script>