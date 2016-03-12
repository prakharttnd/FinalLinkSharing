<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Link Sharing</title>
</head>

<body>
<div class="col-md-7">
    <g:render template="/shared/recentShares"></g:render>
</div>

<div class="col-md-5">
    <g:render template="login"></g:render>
    <g:render template="register"></g:render>
</div>

</body>
</html>