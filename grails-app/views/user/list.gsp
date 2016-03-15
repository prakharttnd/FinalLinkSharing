<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Users List</title>
</head>

<body>
<table class="table table-bordered">
    <thead>
    <tr>
        <g:form class="form-horizontal" controller="user" action="list">
            <div class="col-md-7"></div>

            <div class="form-group col-md-2">
                <g:select name="isActive" from="${com.ttnd.linksharing.enums.UserStatus.values()}"
                          optionValue="displayText"
                          class="form-control"/>
            </div>

            <div class="form-group col-md-2">
                <g:textField name="q" class="form-control" placeholder="search"/>
            </div>

            <div class="form-group col-md-1">
                <g:submitButton name="Search" class="btn btn-default active"/>
            </div>
        </g:form>
    </tr>
    <tr>
        <g:sortableColumn property="id" title="Id" defaultOrder="asc"/>
        <g:sortableColumn property="username" title="Username" defaultOrder="asc"/>
        <g:sortableColumn property="email" title="Email" defaultOrder="asc"/>
        <g:sortableColumn property="firstName" title="Firstname" defaultOrder="asc"/>
        <g:sortableColumn property="lastName" title="Lastname" defaultOrder="asc"/>
        <g:sortableColumn property="active" title="Active" defaultOrder="asc"/>
        <th>Manage</th>
    </tr>
    </thead>

    <tbody>
    <g:each in="${users}" var="user">
        <g:if test="${user.active}">
            <tr class="success">
                <td>${user.id}</td>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td>${user.firstName}</td>
                <td>${user.lastName}</td>
                <g:if test="${user.active}">
                    <td>Yes</td>
                    <td><g:link controller="user" action="toogleActive" id="${user.id}">Deactivate</g:link></td>
                </g:if>
                <g:else>
                    <td>No</td>
                    <td><g:link controller="user" action="toogleActive" id="${user.id}">Activate</g:link></td>
                </g:else>
            </tr>
        </g:if>
        <g:else>
            <tr class="danger">
                <td>${user.id}</td>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td>${user.firstName}</td>
                <td>${user.lastName}</td>
                <g:if test="${user.active}">
                    <td>Yes</td>
                    <td><g:link controller="user" action="toogleActive" id="${user.id}">Deactivate</g:link></td>
                </g:if>
                <g:else>
                    <td>No</td>
                    <td><g:link controller="user" action="toogleActive" id="${user.id}">Activate</g:link></td>
                </g:else>
            </tr>
        </g:else>
    </g:each>
    </tbody>
</table>
<g:paginate total="${userCount}" controller="user" action="list" next="Forward" prev="Back" maxsteps="5" max="20"/>
</body>
</html>