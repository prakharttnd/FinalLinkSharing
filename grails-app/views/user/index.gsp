<%--
  Created by IntelliJ IDEA.
  User: prakhar
  Date: 4/3/16
  Time: 3:02 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Link Sharing</title>
</head>

<body>
<div class="col-md-7">
    <div class="panel panel-default">
        <div class="panel-body">
            <asset:image src="spinner.gif"/> Loading...
        </div>
    </div>
</div>

<div class="col-md-5">
    <g:render template="login"></g:render>
    <g:render template="register"></g:render>
</div>
</body>
</html>