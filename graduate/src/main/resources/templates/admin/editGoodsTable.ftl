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
        <label class="layui-form-label">商品编号</label>
        <div class="layui-input-block">
            <input type="text" name="goodsId" lay-verify="id" autocomplete="off" class="layui-input" id="goodsId" readonly>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">商品标题</label>
        <div class="layui-input-block">
            <input type="text" name="title" lay-verify="" autocomplete="off" placeholder="" class="layui-input" id="title">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">子描述</label>
        <div class="layui-input-block">
            <input type="text" name="subTitle" lay-verify="" autocomplete="off" placeholder="" class="layui-input" id="subTitle">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">原价</label>
        <div class="layui-input-block">
            <input type="text" name="originalCost" lay-verify="" autocomplete="off" placeholder="" class="layui-input" id="originalCost">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">秒杀价</label>
        <div class="layui-input-block">
            <input type="text" name="currentPrice" lay-verify="" autocomplete="off" placeholder="" class="layui-input" id="currentPrice">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">库存</label>
        <div class="layui-input-block">
            <input type="text" name="stock" lay-verify="" autocomplete="off" placeholder="" class="layui-input" id="stock">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">促销活动</label>
        <div class="layui-input-block">
            <input type="text" name="status" lay-verify="" autocomplete="off" placeholder="" class="layui-input" id="status">
        </div>
    </div>


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
        $("input[name='goodsId']").val(parent_json.goodsId);
        $("input[name='title']").val(parent_json.title);
        $("input[name='subTitle']").val(parent_json.subTitle);
        $("input[name='originalCost']").val(parent_json.originalCost);
        $("input[name='currentPrice']").val(parent_json.currentPrice);
        $("input[name='stock']").val(parent_json.stock);
        $("input[name='status']").val(parent_json.status);    //少了个单引号所以没有获取到值
        form.render();//刷新

       // 自定义验证规则
       //  form.verify({
       //      country: function (value) {
       //          if (value.length < 2) {
       //              return '国家名称至少2个字符啊';
       //          }
       //      },
       //      cumulative: function (value) {
       //          if (value.length < 1) {
       //              return '累计确诊至少得1个字符啊';
       //          }
       //      },
       //      cure: function (value) {
       //          if (value.length < 1) {
       //              return '累计确诊至少得1个字符啊';
       //          }
       //      }
       //
       //      ,pass: [
       //          /^[\S]{6,12}$/
       //          ,'密码必须6到12位，且不能出现空格'
       //      ]
       //      ,content: function(value){
       //          layedit.sync(editIndex);
       //      }
       //  });
       //
        //监听提交
        form.on('submit(edit)', function (data) {
            //获取文本框的值
            var goodsId = $("#goodsId").val();
            var title = $("#title").val();
            var subTitle = $("#subTitle").val();
            var originalCost = $("#originalCost").val();
            var currentPrice = $("#currentPrice").val();
            var stock = $("#stock").val();
            var status = $("#status").val();
            $.ajax({
                type: 'post',
                url: '/editGoods',
                async: true,
                datype: "json",
                data: {
                    goodsId: goodsId,
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