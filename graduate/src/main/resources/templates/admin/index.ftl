<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin</title>
    <link rel="stylesheet" href="/layui/css/layui.css" media="all">
    <link rel="shortcut icon" href="#"/>    <!--用于解决ERROR Circular view path [favicon.ico]-->
    <script src="/layui/jquery-1.8.3.js"></script>
    <script src="/layui/layui.js" charset="utf-8" type="text/javascript"></script>
</head>
<body>
<div class="layui-layout layui-layout-admin">

    <div class="layui-header">
        <div class="layui-logo">母婴用品后台管理系统</div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="/images/adminlogin.jpg" class="layui-nav-img">
                    Admin
                </a>
<!--                <dl class="layui-nav-child">-->
<!--                    <dd><a href="">set 1</a></dd>-->
<!--                    <dd><a href="">set 2</a></dd>-->
<!--                </dl>-->
            </li>
            <li class="layui-nav-item"><a href="/adminlogout" >退出</a></li>
        </ul>
    </div>


    <div class="layui-side layui-bg-black">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree" lay-filter="test">

                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">商品管理</a>
                    <dl class="layui-nav-child">
                        <dd class="layui-this"><a href="javascript:;" onclick="change('goodsTable')">商品信息</a></dd>
                    </dl>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:;">用户管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" onclick="change('userTable')">用户信息</a></dd>
                    </dl>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:;">订单管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" onclick="change('orderTable')">订单信息</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">商品销量图</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" onclick="change('BarTable')">柱状图</a></dd>
                        <dd><a href="javascript:;" onclick="change('PieChartTable')">饼状图</a></dd>
                    </dl>
                </li>

            </ul>
        </div>
    </div>

    <div class="layui-body">    <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <iframe src="/admin/goodsTable" frameborder="0" id="demoAdmin" style="width: 100%; height: 615px; border-radius: 2px;"></iframe>

        </div>
    </div>
<!--    <div class="layui-footer" >  &lt;!&ndash; 底部固定区域 &ndash;&gt;-->
<!--    </div>-->
</div>

<script>
    layui.use('element', function(){
        var element = layui.element;

    });
</script>

<script>
    function change(title){
        let url = "";
        switch (title) {
            case 'goodsTable':
                url = "/admin/goodsTable";
                break
            case 'userTable':
                url = "/admin/userTable";
                break
            case 'orderTable':
                url = "/admin/orderTable";
                break
            case 'BarTable':
                url = "/admin/BarGraphTable";
                break
            case 'PieChartTable':
                url = "/admin/PieChartTable";
                break
        }
        $('iframe').attr("src",url);
    }


    layui.use('jquery', function(){
        var $ = layui.$ //重点处
        //后面就跟你平时使用jQuery一样
        console.log($)


    });

</script>

</body>
</html>