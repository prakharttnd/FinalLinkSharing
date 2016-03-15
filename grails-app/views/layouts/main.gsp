<!DOCTYPE html>
<head>
    <title><g:layoutTitle default="Link Sharing"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
    <g:layoutHead/>
</head>

<body style="margin-top: 15px;">
<div class="container">
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <g:link uri="/" class="navbar-brand">Link Sharing</g:link>
                %{--<a class="navbar-brand" href="#">Link Sharing</a>--}%
            </div>

            <div class="collapse navbar-collapse" id="myNavbar">
                <ul class="nav navbar-nav navbar-right">
                    <li style="margin-top: 10px;"><form action="/user/search" method="post">
                        <div class="form-group has-feedback has-feedback-left">
                            <input type="text" class="form-control" name="search" id="search" placeholder="Search"
                                   style="border-radius: 20px;" value="${search}"/>
                            <g:if test="${!session?.user?.admin}">
                                <script>
                                    $('#search').prop("required", "required");
                                </script>
                            </g:if>
                            <i class="glyphicon glyphicon-search form-control-feedback"></i>
                        </div>
                    </form></li>
                    <g:if test="${session.user}">
                        <li><a id="createTopic" href="#" data-toggle="modal" data-target="#createTopicModal"><span
                                class="fa fa-comment" style="font-size: 20px;"></span></a></li>
                        <li><a id="sendInvitation" href="#" data-toggle="modal" data-target="#sendInvitationModal"><span
                                class="fa fa-envelope-o" style="font-size: 20px;"></span></a></li>
                        <li><a id="createLinkResource" href="#" data-toggle="modal"
                               data-target="#createLinkResourceModal"><span
                                    class="glyphicon glyphicon-link" style="font-size: 20px;"></span></a></li>
                        <li><a id="createDocumentResource" href="#" data-toggle="modal"
                               data-target="#createDocumentResourceModal"><span
                                    class="fa fa-file-o" style="font-size: 20px;"></span></a></li>
                        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><span
                                class="glyphicon glyphicon-user"
                                style="font-size: 20px;"></span> ${session.user?.username} <span
                                class="caret"/></a>
                            <ul class="dropdown-menu">
                                <li><a href="/user/profile">Profile</a></li>
                                <g:if test="${session.user?.admin}">
                                    <li><a href="/user/list">Users</a></li>
                                </g:if>
                                <li><a href="/user/logout">Logout</a></li>
                            </ul>
                        </li>
                    </g:if>
                </ul>
            </div>
        </div>
    </nav>

    <g:if test="${flash.error}">
        <div class="alert alert-danger" id="error-alert">
            <strong>Error!!</strong> ${flash.error}
        </div>
    </g:if>

    <g:if test="${flash.message}">
        <div class="alert alert-success" id="success-alert">
            ${flash.message}
        </div>
    </g:if>

    <div id="message">

    </div>

    <g:layoutBody/>

    <g:if test="${session.user}">
        <div class="modal fade" id="createTopicModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Create Topic</h4>
                    </div>

                    <div class="modal-body" id="createTopicModalBody">
                        <asset:image src="spinner.gif"/> Loading...
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="sendInvitationModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Send Invitation</h4>
                    </div>

                    <div class="modal-body" id="sendInvitationModalBody">
                        <asset:image src="spinner.gif"/> Loading...
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="createLinkResourceModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Create Link Resource</h4>
                    </div>

                    <div class="modal-body" id="createLinkResourceModalBody">
                        <asset:image src="spinner.gif"/> Loading...
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="createDocumentResourceModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Create Document Resource</h4>
                    </div>

                    <div class="modal-body" id="createDocumentResourceModalBody">
                        <asset:image src="spinner.gif"/> Loading...
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            $('#createTopic').click(function () {
                $.post("/topic/renderCreateTopicTemplate", function (response) {
                    $('#createTopicModalBody').html(response);
                });
            });

            $(document).on('click', '#sendInvitation', function () {
                $.post("/topic/renderSendInvitationTemplate", function (response) {
                    $('#sendInvitationModalBody').html(response);
                });
            });

            $('#createLinkResource').click(function () {
                $.post("/linkResource/renderCreateLinkResourceTemplate", function (response) {
                    $('#createLinkResourceModalBody').html(response);
                });
            });

            $('#createDocumentResource').click(function () {
                $.post("/documentResource/renderCreateDocumentResourceTemplate", function (response) {
                    $('#createDocumentResourceModalBody').html(response);
                });
            });
        </script>
    </g:if>

</div>
<script>
    $("#success-alert").fadeTo(2000, 500).slideUp(500, function () {
        $("#success-alert").alert('close');
    });

    $("#error-alert").fadeTo(2000, 500).slideUp(500, function () {
        $("#error-alert").alert('close');
    });

    var showalert = function (message) {
        $("#message").html("<div class='alert alert-warning" +
                "' id='message-alert'>" + message + "</div>");
        closealert();
    }

    var closealert = function () {
        $("#message-alert").fadeTo(2000, 500).slideUp(500, function () {
            $("#message-alert").alert('close');
        });
    }
</script>
</body>
</html>
