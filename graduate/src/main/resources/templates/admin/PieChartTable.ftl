<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PieChartTable</title>
    <script src="/layui/echarts.min.js"></script>
    <script src="/layui/jquery-1.8.3.js"></script>
</head>
<body>

    <div id="main" style="width: 1100px;height: 599px"></div> <!--    dom节点-->

</body>
<script type="text/javascript">
    $(function(){
        $.ajax({
            "url":"/PieGraphTableData",
            "success":function (data) {
                console.log(data);
                // 基于准备好的dom，初始化echarts实例
                var myChart = echarts.init(document.getElementById('main'));
                option = {
                    backgroundColor: '#2c343c',

                    title: {
                        text: '商品销量饼状图',
                        left: 'center',
                        top: 20,
                        textStyle: {
                            color: 'rgb(255, 255, 255)'
                        }
                    },

                    tooltip: {
                        trigger: 'item'
                    },

                    // visualMap: {
                    //     show: false,
                    //     min: 80,
                    //     max: 600,
                    //     inRange: {
                    //         colorLightness: [0, 1]
                    //     }
                    // },
                    series: [
                        {
                            name: '',
                            type: 'pie',
                            radius: '55%',
                            center: ['50%', '50%'],
                            data: data.sort(function (a, b) { return a.value - b.value; }),
                            roseType: 'radius',
                            label: {
                                color: 'rgb(255, 255, 255)'
                            },
                            labelLine: {
                                lineStyle: {
                                    color: 'rgba(255, 255, 255, 0.1)'
                                },
                                smooth: 0.2,
                                length: 10,
                                length2: 20
                            },
                            itemStyle: {
                                color: '#c23531',
                                shadowBlur: 10,
                                shadowColor: 'rgba(255, 255, 255, 0.5)'
                            },

                            animationType: 'scale',
                            animationEasing: 'elasticOut',
                            animationDelay: function (idx) {
                                return Math.random() * 200;
                            }
                        }
                    ]
                };
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
            }
        });
    })




    // 指定图表的配置项和数据



</script>
</html>