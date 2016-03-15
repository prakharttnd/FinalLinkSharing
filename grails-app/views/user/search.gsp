<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Resource Search</title>
</head>

<body>
<div class="col-md-5">
    <g:render template="/user/trendingTopics"/>
</div>

<input type="hidden" id="searchValue" value="${search}"/>

<div class="col-md-7">
    <g:render template="/resource/search" model="[search: search]"/>
</div>

<script type="text/javascript">
    var fetchTrendingTopics = function () {
        $.ajax({
            url: '/resource/fetchTrendingTopics',
            type: 'post',
            success: function (response) {
                $('#trendingTopicsBody').html(response.html);
            }
        });
    }

    var fetchResources = function () {
        var data = {
            q: $('#searchValue').val()
        }
        $.ajax({
            url: '/resource/search',
            type: 'post',
            data: data,
            success: function (response) {
                $("#resourceSearchBody").html(response.html);
            }
        });
    }

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
                    showalert(response.message);
                } else {
                    showalert(response.message);
                }
            }
        });
    });

    $(document).on('click', '.unsubscribeTopic', function (event) {
        $.ajax({
            url: this.href,
            type: 'post',
            success: function (response) {
                console.log(response)
                if (response.status == 200) {
                    showalert(response.message);
                    fetchTrendingTopics();
                } else if (response.status == 202) {
                    showalert(response.message);
                } else {
                    showalert(response.message);
                }
            }
        });
        event.preventDefault();
    });

    $(document).on('click', '.subscribeTopic', function (event) {
        $.ajax({
            url: this.href,
            type: 'post',
            success: function (response) {
                console.log(response)
                if (response.status == 200) {
                    showalert(response.message);
                    fetchTrendingTopics();
                } else {
                    showalert(response.message);
                }
            }
        });
        event.preventDefault();
    });

    $(document).on('click', '.deletetopic', function (event) {
        $.ajax({
            url: this.href,
            type: 'post',
            success: function (response) {
                if (response.status == 200) {
                    showalert(response.message);
                    fetchTrendingTopics();
                } else {
                    showalert(response.message);
                }
            }
        });
        event.preventDefault();
    });

    $(document).on('change', '.visibility', function () {
        console.log(this.id)
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
                    showalert(response.message);
                } else {
                    showalert(response.message);
                }
            }
        });
    });

    $(document).on('click', ".trendingTopicNameCancelUpdate", function (event) {
        $("#trendingTopicForm" + this.id).toggleClass("hidden");
        $("#trendingTopicText" + this.id).toggleClass("hidden");
        event.preventDefault();
    });

    $(document).on('click', ".trendingTopicNameSubmitUpdate", function (event) {
        var id = this.id;
        var name = $("#trendingTopicName" + id).val();
        var data = {
            topicName: name,
            topicId: id
        }
        $.ajax({
            url: '/topic/update/' + id,
            type: 'post',
            data: data,
            success: function (response) {
                if (response.status == 200) {
                    fetchTrendingTopics();
                    showalert(response.message)
                } else {
                    showalert(response.message)
                }
            }
        });
        event.preventDefault();
    });

    $(document).on('click', ".editTrendingTopicName", function () {
        $("#trendingTopicForm" + this.id).toggleClass("hidden");
        $("#trendingTopicText" + this.id).toggleClass("hidden");
    });

    $(document).on('click', '.toggleReadUnread', function (event) {
//        console.log(this.href);
        $.ajax({
            url: this.href,
            type: 'post',
            success: function (response) {
                console.log(response);
                if (response.status == 200) {
                    showalert(response.message);
                    fetchResources();
                } else {
                    showalert(response.message);
                }
            }
        });
        event.preventDefault();
    });

    window.onload = function () {
        fetchTrendingTopics();
        fetchResources();
    }
</script>
</body>
</html>