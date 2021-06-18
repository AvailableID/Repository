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
    <div class="layui-form-item">
        <label class="layui-form-label" >商品ID</label>
        <div class="layui-input-block">
            <input type="text" name="goodsId" lay-verify="" autocomplete="off" placeholder="请输入商品ID" class="layui-input" id="goodsId">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">商品标题</label>
        <div class="layui-input-block">
            <input type="text" name="title" lay-verify="" autocomplete="off" placeholder="请输入商品名称" class="layui-input" id="title">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">子描述</label>
        <div class="layui-input-block">
            <input type="text" name="subTitle" lay-verify="" autocomplete="off" placeholder="请输入副标题" class="layui-input" id="subTitle">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">原价</label>
        <div class="layui-input-block">
            <input type="text" name="originalCost" lay-verify="" autocomplete="off" placeholder="请输入商品价格" class="layui-input" id="originalCost">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">秒杀价</label>
        <div class="layui-input-block">
            <input type="text" name="currentPrice" lay-verify="" autocomplete="off" placeholder="请输入商品秒杀价" class="layui-input" id="currentPrice">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">库存</label>
        <div class="layui-input-block">
            <input type="text" name="stock" lay-verify="" autocomplete="off" placeholder="请输入库存数量" class="layui-input" id="stock">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">是否活动</label>
        <div class="layui-input-block">
            <input type="text" name="status" lay-verify="" autocomplete="off" placeholder="请输入 ”是” 或 “否“ " class="layui-input" id="status">
        </div>
    </div>
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

        form.on('submit(add)', function (data) {
            var goodsId = $("#goodsId").val();
            var title = $("#title").val();
            var subTitle = $("#subTitle").val();
            var originalCost = $("#originalCost").val();
            var currentPrice = $("#currentPrice").val();
            var stock = $("#stock").val();
            var status = $("#status").val();
            $.ajax({
                type: 'post',
                url: '/addGoods',
                async: true,
                dataType: "json",
                data: {
                    goodsId:goodsId,
                    title: title,
                    subTitle:subTitle,
                    originalCost: originalCost,
                    currentPrice: currentPrice,
                    stock: stock,
                    status: status
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