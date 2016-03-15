<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>User Dashboard</title>
</head>

<body>
<div class="col-md-5">
    <g:render template="userInfo"/>
    <g:render template="subscriptions"/>
    <g:render template="trendingTopics"/>
</div>

<div class="col-md-7">
    <g:render template="inbox"/>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        var fetchSubscriptions = function () {
            $.ajax({
                url: '/subscription/subscribedTopics',
                type: 'post',
                success: function (response) {
                    $('#subscribedTopicsBody').html(response.html);
                }
            });
        }

        var fetchUserInfo = function () {
            $.ajax({
                url: "/user/fetchUserInfo",
                type: "post",
                success: function (response) {
                    $('#userInfoBody').html(response.html);
                }
            });
        }

        var fetchTrendingTopics = function () {
            $.ajax({
                url: '/resource/fetchTrendingTopics',
                type: 'post',
                success: function (response) {
                    $('#trendingTopicsBody').html(response.html);
                }
            });
        }

        var fetchUnreadResources = function () {
            $.ajax({
                url: '/resource/unreadResources',
                type: 'post',
                success: function (response) {
                    $('#inboxBody').html(response.html);
                }
            })
        };

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

        $(document).on('click', '.markasread', function (event) {
            $.ajax({
                url: this.href,
                type: 'post',
                success: function (response) {
                    if (response.status == 200) {
                        showalert(response.message);
                        fetchUnreadResources();
                    } else {
                        showalert(response.message);
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
                        showalert(response.message);
                        fetchUserInfo();
                        fetchSubscriptions();
                        fetchTrendingTopics();
                        fetchUnreadResources();
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
                        fetchUserInfo();
                        fetchSubscriptions();
                        fetchTrendingTopics();
                        fetchUnreadResources();
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
                        fetchUserInfo();
                        fetchSubscriptions();
                        fetchTrendingTopics();
                        fetchUnreadResources();
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

        $(document).on('click', ".editTopicName", function () {
            $("#subscriptionTopicForm" + this.id).toggleClass("hidden");
            $("#subscriptionTopicText" + this.id).toggleClass("hidden");
        });

        $(document).on('click', ".editTrendingTopicName", function () {
            $("#trendingTopicForm" + this.id).toggleClass("hidden");
            $("#trendingTopicText" + this.id).toggleClass("hidden");
        });

        $(document).on('click', ".subscriptionTopicNameSubmitUpdate", function (event) {
            var id = this.id;
            var name = $("#subscriptionTopicName" + id).val();
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
                        fetchSubscriptions();
                        fetchTrendingTopics();
                        fetchUnreadResources();
                        showalert(response.message)
                    } else {
                        showalert(response.message)
                    }
                }
            });
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
                        fetchSubscriptions();
                        fetchTrendingTopics();
                        fetchUnreadResources();
                        showalert(response.message)
                    } else {
                        showalert(response.message)
                    }
                }
            });
            event.preventDefault();
        });

        $(document).on('click', ".subscriptionTopicNameCancelUpdate", function (event) {
            $("#subscriptionTopicForm" + this.id).toggleClass("hidden");
            $("#subscriptionTopicText" + this.id).toggleClass("hidden");
            event.preventDefault();
        });

        $(document).on('click', ".trendingTopicNameCancelUpdate", function (event) {
            $("#trendingTopicForm" + this.id).toggleClass("hidden");
            $("#trendingTopicText" + this.id).toggleClass("hidden");
            event.preventDefault();
        });

        window.onload = function () {
            fetchUserInfo();
            fetchSubscriptions();
            fetchTrendingTopics();
            fetchUnreadResources();
        }
    });

</script>

</body>
</html>