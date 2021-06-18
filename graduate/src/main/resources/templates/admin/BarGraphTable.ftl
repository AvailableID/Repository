<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>BarGraphTable</title>
    <script src="/layui/echarts.min.js"></script>
    <script src="/layui/jquery-1.8.3.js"></script>
</head>
<body>

    <div id="main" style="width: 1100px;height: 599px"></div> <!-- dom节点-->

</body>
<script type="text/javascript">
    $(function(){
        $.ajax({
            "url":"/BarGraphTableData",
            "type":"POST",
            "success":function (data) {
                var myChart = echarts.init(document.getElementById('main'));
                var option = {
                    title: {
                        text: ''
                    },
                    tooltip: {},
                    legend: {
                        data:['销量'],
                    },
                    xAxis: {

                        data: data.title
                    },
                    yAxis: {
                        type:'value',

                    },
                    series: [{
                        type: 'bar',
                        name: '销量',
                        data: data.values
                    }]
                };
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
            }
        });
    })
</script>
</html>