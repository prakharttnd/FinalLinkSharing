<div class="panel panel-default">
    <div class="panel-heading">Recent Shares</div>

    <div class="panel-body" id="panelbody">
        %{--<ls:recentShares id="recentShares"/>--}%
        <asset:image src="spinner.gif"/>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        var fetchRecentShares = function () {
            $.ajax({
                type: 'post',
                url: '/user/recentShares',
                success: function (response) {
                    $("#panelbody").html(response.html);
                }
            });
        }
        window.onload = fetchRecentShares();
//        setTimeout(fetchRecentShares, 2000)
//        setInterval(fetchRecentShares, 2000);
    });
</script>
