<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AddUserPage</title>
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
<#--        <label class="layui-form-label" >用户ID</label>-->
<#--        <div class="layui-input-block">-->
<#--            <input type="text" name="userid" lay-verify="" autocomplete="off" placeholder="请输入用户ID" class="layui-input" id="userid">-->
<#--        </div>-->
<#--    </div>-->
    <div class="layui-form-item">
        <label class="layui-form-label">用户名称</label>
        <div class="layui-input-block">
            <input type="text" name="userName" lay-verify="" autocomplete="off" placeholder="请输入用户名称" class="layui-input" id="userName">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密码</label>
        <div class="layui-input-block">
            <input type="text" name="password" lay-verify="" autocomplete="off" placeholder="请输入密码" class="layui-input" id="password">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-block">
            <input type="text" name="gender" lay-verify="" autocomplete="off" placeholder="请输入性别" class="layui-input" id="gender">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">地址</label>
        <div class="layui-input-block">
            <input type="text" name="address" lay-verify="" autocomplete="off" placeholder="请输入地址" class="layui-input" id="address">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">手机号</label>
        <div class="layui-input-block">
            <input type="text" name="mobile" lay-verify="" autocomplete="off" placeholder="请输入手机号" class="layui-input" id="mobile">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">邮箱</label>
        <div class="layui-input-block">
            <input type="text" name="email" lay-verify="" autocomplete="off" placeholder="请输入邮箱" class="layui-input" id="email">
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

        // 自定义验证规则
         form.verify({
             country: function (value) {
                 if (value.length < 2) {
                     return '国家名称至少2个字符啊';
                 }
             },
             cumulative: function (value) {
                 if (value.length < 1) {
                     return '累计确诊至少得1个字符啊';
                 }
             },
             cure: function (value) {
                 if (value.length < 1) {
                     return '累计确诊至少得1个字符啊';
                 }
             }
             ,pass: [
                 /^[\S]{6,12}$/
                 ,'密码必须6到12位，且不能出现空格'
             ]
             ,content: function(value){
                 layedit.sync(editIndex);
             }
         });

        // 监听提交
        form.on('submit(add)', function (data) {
            //获取文本框的值
            // var userid = $("#userid").val();
            var userName = $("#userName").val();
            var password = $("#password").val();
            var gender = $("#gender").val();
            var address = $("#address").val();
            var mobile = $("#mobile").val();
            var email = $("#email").val();
            $.ajax({
                type: 'post',
                url: '/addUser',
                async: true,
                dataType: "json",
                data: {
                    // userid:userid,
                    userName: userName,
                    password:password,
                    gender: gender,
                    address: address,
                    mobile: mobile,
                    email: email
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