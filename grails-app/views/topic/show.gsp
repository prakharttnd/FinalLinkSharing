<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Topic Show</title>
</head>

<body>
<div class="col-md-5">
    <g:render template="topicInfo" model="[topicName: topicName]"/>
    <g:render template="topicUsers" model="[topicName: topicName]"/>
</div>

<div class="col-md-7">
    <g:render template="topicPosts" model="[topicName: topicName]"/>
</div>

<script type="text/javascript">
    var fetchTopicInfo = function () {
        $.ajax({
            url: '/topic/info/' + window.location.pathname.split("/")[3],
            type: 'post',
            success: function (response) {
                $('#topicInfoBody').html(response.html);
            }
        });
    }

    $(document).on('click', '.subscribeTopic', function (event) {
        $.ajax({
            url: this.href,
            type: 'post',
            success: function (response) {
                console.log(response)
                if (response.status == 200) {
                    $('#message-alert').html(response.message);
                } else {
                    $('#message-alert').html(response.message);
                }
            }
        });
        event.preventDefault();
    });

    $(document).on('click', '.unsubscribeTopic', function (event) {
        $.ajax({
            url: this.href,
            type: 'post',
            success: function (response) {
                console.log(response)
                if (response.status == 200) {
                    $('#message-alert').html(response.message);
                } else if (response.status == 202) {
                    $('#message-alert').html(response.message);
                } else {
                    $('#message-alert').html(response.message);
                }
            }
        });
        event.preventDefault();
    });

    $(document).on('change', '.seriousness', function () {
//            console.log(this)
//            console.log(this.value)
        var data = {
            seriousness: this.value,
            subscriptionId: this.id
        }
        $.ajax({
            url: '/subscription/update',
            data: data,
            type: 'post',
            success: function (response) {
                console.log(response)
                if (response.status == 200) {
                    $('#message-alert').html(response.message);
                } else {
                    $('#message-alert').html(response.message);
                }
            }
        });
    });

    $(document).on('change', '.visibility', function () {
        console.log(this)
        console.log(this.value)
        var data = {
            visibility: this.value,
            topicId: this.id
        }
        $.ajax({
            url: '/topic/update',
            data: data,
            type: 'post',
            success: function (response) {
                console.log(response)
                if (response.status == 200) {
                    $('#message-alert').html(response.message);
                } else {
                    $('#message-alert').html(response.message);
                }
            }
        });
    });

    $(document).on('click', '.deletetopic', function (event) {
        $.ajax({
            url: this.href,
            type: 'post',
            success: function (response) {
                if (response.status == 200) {
                    window.location.href = "/user/dashboard";
                    $('#message-alert').html(response.message);
                } else {
                    $('#message-alert').html(response.message);
                }
            }
        });
        event.preventDefault();
    });

    window.onload = function () {
        fetchTopicInfo();

    }
</script>

</body>
</html>