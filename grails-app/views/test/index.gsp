<%--
  Created by IntelliJ IDEA.
  User: prakhar
  Date: 10/3/16
  Time: 7:09 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title></title>
</head>

<body>

<script>
    $(document).ready(function () {
//        setInterval(function () {
//            console.log("Hello");
//        }, 2000);
        $.ajax({
            type: 'post',
            data: null,
            url: '/test/fetchData',
            success: function (res) {
                console.log("Success" + res.data);
            },
            error: function (res) {
                console.log("Error" + res);
            }
        })
    });
</script>
</body>
</html>