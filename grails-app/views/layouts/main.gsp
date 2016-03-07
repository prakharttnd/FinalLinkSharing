<!DOCTYPE html>
<head>
    <title><g:layoutTitle default="Link Sharing"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
    <asset:javascript src="modalOperations.js"/>
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
                <a class="navbar-brand" href="#">Link Sharing</a>
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
                        <li><a href="#" data-toggle="modal" data-target="#sendInvitationModal"><span
                                class="fa fa-envelope-o" style="font-size: 20px;"></span></a></li>
                        <li><a href="#" data-toggle="modal" data-target="#createLinkResourceModal"><span
                                class="glyphicon glyphicon-link" style="font-size: 20px;"></span></a></li>
                        <li><a href="#" data-toggle="modal" data-target="#createDocumentResourceModal"><span
                                class="fa fa-file-o" style="font-size: 20px;"></span></a></li>
                        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><span
                                class="glyphicon glyphicon-user"
                                style="font-size: 20px;"></span> ${session.user?.username} <span
                                class="caret"/></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Profile</a></li>
                                <g:if test="${session.user?.admin}">
                                    <li><a href="#">Users</a></li>
                                    <li><a href="#">Topics</a></li>
                                    <li><a href="#">Posts</a></li>
                                </g:if>
                                <li><a href="/login/logout">Logout</a></li>
                            </ul>
                        </li>
                    </g:if>
                </ul>
            </div>
        </div>
    </nav>
    <g:if test="${flash.error}">
        <div class="alert alert-danger">
            <strong>Error!!</strong> ${flash.error}
        </div>
    </g:if>
    <g:if test="${flash.message}">
        <div class="alert alert-warning">
            ${flash.message}
        </div>
    </g:if>
    <g:layoutBody/>
    <g:if test="${session.user}">
        <div class="modal fade" id="createTopicModal">
            <div class="modal-dialog">
                <div class="modal-content" id="modalContent">
                    <div class="modal-body">
                        <asset:image src="spinner.gif"/> Loading...
                    </div>
                </div>
            </div>
        </div>
    </g:if>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $('#createTopic').click(function () {
            $.post("/topic/create", function (response) {
                $('#modalContent').html(response);
            });
        });
    })
</script>
</body>
</html>
