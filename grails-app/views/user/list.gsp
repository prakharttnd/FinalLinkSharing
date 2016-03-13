<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Users List</title>
</head>

<body>
<table class="table table-bordered">
    <caption><h4>Users</h4></caption>
    <thead>
    <tr>
        <th>Id</th>
        <th>Username</th>
        <th>Email</th>
        <th>Firstname</th>
        <th>Lastname</th>
        <th>Active</th>
        <th>Manage</th>
    </tr>
    </thead>

    <tbody>
    <g:each in="${users}" var="user">
        <tr>
            <td>${user.id}</td>
            <td>${user.username}</td>
            <td>${user.email}</td>
            <td>${user.firstName}</td>
            <td>${user.lastName}</td>
            <g:if test="${user.active}">
                <td>Yes</td>
                <td><g:link controller="user" action="deactivate" id="${user.id}">Deactivate</g:link></td>
            </g:if>
            <g:else>
                <td>No</td>
                <td><g:link controller="user" action="activate" id="${user.id}">Activate</g:link></td>
            </g:else>
        </tr>
    </g:each>
    </tbody>
</table>
<g:paginate total="${userCount}" controller="user" action="list" next="Forward" prev="Back" maxsteps="2"/>
</body>
</html>