<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Resource Show</title>
</head>

<body>
<div class="col-md-7">
    <g:render template="resource"/>
</div>

<div class="col-md-5">
    <g:render template="/user/trendingTopics"/>
</div>



<script type="text/javascript">
    $(document).ready(function () {
        var fetchTrendingTopics = function () {
            $.ajax({
                url: '/resource/fetchTrendingTopics',
                type: 'post',
                success: function (response) {
                    $('#trendingTopicsBody').html(response.html);
                }
            });
        }

        var fetchResourceInfo = function () {
            $.ajax({
                url: "/resource/info/" + window.location.pathname.split("/")[3],
                type: 'post',
                success: function (response) {
                    $("#resourceBody").html(response.html);
                }
            })
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

        $(document).on('click', ".deleteResource", function (event) {
            $.ajax({
                url: this.href,
                type: 'post',
                success: function (response) {
                    console.log(response)
                    if (response.status == 200) {
                        showalert(response.message);
                        window.location.href = "/";
                    } else {
                        showalert(response.message);
                    }
                }
            });
            event.preventDefault();
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

        window.onload = function () {
            fetchTrendingTopics();
            fetchResourceInfo();
            $("#stars-default").rating();
            $("#stars-green").rating('create', {
                coloron: 'green', onClick: function () {
                    alert('rating is ' + this.attr('data-rating'));
                }
            });
        }
    });
</script>
</body>
</html>