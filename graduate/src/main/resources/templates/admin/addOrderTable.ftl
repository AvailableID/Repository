<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AddPage</title>
    <link rel="stylesheet" href="/layui/css/layui.css" media="all">
    <script src="/layui/layui.js" charset="utf-8" ></script>
    <script src="/layui/jquery-1.8.3.js"></script>
</head>
<body>
<blockquote class="layui-elem-quote layui-text">
    <h3>添加信息</h3>
</blockquote>
<form class="layui-form" action="">
<#--    <div class="layui-form-item">-->
<#--        <label class="layui-form-label" >订单ID</label>-->
<#--        <div class="layui-input-block">-->
<#--            <input type="text" name="orderId" lay-verify="" autocomplete="off" placeholder="请输入订单ID" class="layui-input" id="orderId">-->
<#--        </div>-->
<#--    </div>-->
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
            <button type="submit" class="layui-btn" lay-submit="" lay-filter="add">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
</body>
<script>
    layui.use(['form', 'layedit', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;

        //自定义验证规则
        // form.verify({
        //     country: function (value) {
        //         if (value.length < 2) {
        //             return '国家名称至少2个字符啊';
        //         }
        //     },
        //     cumulative: function (value) {
        //         if (value.length < 1) {
        //             return '累计确诊至少得1个字符啊';
        //         }
        //     },
        //     cure: function (value) {
        //         if (value.length < 1) {
        //             return '累计确诊至少得1个字符啊';
        //         }
        //     }
        //
        //     ,pass: [
        //         /^[\S]{6,12}$/
        //         ,'密码必须6到12位，且不能出现空格'
        //     ]
        //     ,content: function(value){
        //         layedit.sync(editIndex);
        //     }
        // });
        //监听提交
        form.on('submit(add)', function (data) {
            //获取文本框的值
            // var orderId = $("#orderId").val();
            var goodsId = $("#goodsId").val();
            var orderNo = $("#orderNo").val();
            var orderStatus = $("#orderStatus").val();
            var userid = $("#userid").val();
            // var username = $("#userName").val();

            $.ajax({
                type: 'post',
                url: '/addOrder',
                async: true,
                dataType: "json",
                data: {
                    // orderId:orderId,
                    goodsId: goodsId,
                    orderNo:orderNo,
                    orderStatus: orderStatus,
                    userid: userid,
                    // userName: username
                },
                success: function (data) {
                    layer.alert('请求失败，系统错误', {icon: 7, title: '提示', time: 1000})
                },
                error: function () {
                    layer.alert('增加成功', {icon: 6, title: '提示', time: 1500})
                    setTimeout(function () {
                        window.parent.location.reload();
                        // window.location.href="index.ftl";
                    }, 1500);
                }
            });
            return false;
        });
    });
</script>

</html>