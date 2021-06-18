<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>EditPage</title>
    <link rel="stylesheet" href="/layui/css/layui.css" media="all">
    <script src="/layui/layui.js" charset="utf-8" ></script>
<!--    <script src="/layui/jquery-1.8.3.js"></script>-->
</head>
<body>
<blockquote class="layui-elem-quote layui-text">
    <h3>修改信息</h3>
</blockquote>
<form class="layui-form" action="">
    <div class="layui-form-item">
        <label class="layui-form-label" >订单ID</label>
        <div class="layui-input-block">
            <input type="text" name="orderId" lay-verify="" autocomplete="off" placeholder="请输入订单ID" class="layui-input" id="orderId" readonly>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">商品ID</label>
        <div class="layui-input-block">
            <input type="text" name="goodsId" lay-verify="" autocomplete="off" placeholder="请输入商品ID" class="layui-input" id="goodsId">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">订单号</label>
        <div class="layui-input-block">
            <input type="text" name="orderNo" lay-verify="" autocomplete="off" placeholder="请输入订单号" class="layui-input" id="orderNo">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">订单数量</label>
        <div class="layui-input-block">
            <input type="text" name="orderStatus" lay-verify="" autocomplete="off" placeholder="请输入订单状态" class="layui-input" id="orderStatus">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">用户ID</label>
        <div class="layui-input-block">
            <input type="text" name="userid" lay-verify="" autocomplete="off" placeholder="请输入用户ID" class="layui-input" id="userid">
        </div>
    </div>
<#--    <div class="layui-form-item">-->
<#--        <label class="layui-form-label">用户名称</label>-->
<#--        <div class="layui-input-block">-->
<#--            <input type="text" name="userName" lay-verify="" autocomplete="off" placeholder="请输入用户名称" class="layui-input" id="userName">-->
<#--        </div>-->
<#--    </div>-->
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button type="submit" class="layui-btn" lay-submit="" lay-filter="edit">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>

<script>
    layui.use(['form', 'layer', 'jquery'], function () {
        $ = layui.jquery;
        var form = layui.form,
            layer = layui.layer,
            layedit = layui.layedit,
            laydate = layui.laydate;
        var parent_json = eval('(' + parent.json + ')');
        //从数据库获取值到文本框中
        $("input[name='orderId']").val(parent_json.orderId);
        $("input[name='goodsId']").val(parent_json.goodsId);
        $("input[name='orderNo']").val(parent_json.orderNo);
        $("input[name='orderStatus']").val(parent_json.orderStatus);
        $("input[name='userid']").val(parent_json.userid);
        // $("input[name='userName']").val(parent_json.userName);

        form.render();//刷新

        //监听提交
        form.on('submit(edit)', function (data) {
            //获取文本框的值
            var orderId = $("#orderId").val();
            var goodsId = $("#goodsId").val();
            var orderNo = $("#orderNo").val();
            var orderStatus = $("#orderStatus").val();
            var userid = $("#userid").val();
            // var userName = $("#userName").val();

            $.ajax({
                type: 'post',
                url: '/editOrder',
                async: true,
                datype: "json",
                data: {
                    orderId: orderId,
                    goodsId: goodsId,
                    orderNo:orderNo,
                    orderStatus: orderStatus,
                    userid: userid,
                    // userName: userName
                },
                success: function (data) {
                    layer.alert('请求失败，系统错误', {icon: 7, title: '提示', time: 1000})

                },
                error: function () {
                    layer.alert('修改成功', {icon: 6, title: '提示', time: 1500})
                    setTimeout(function () {
                        window.parent.location.reload();
                        //window.location.href="index.ftl";
                    }, 1500);
                }
            });
            return false;
        });
    });
</script>
</body>
</html>