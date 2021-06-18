<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <title>UserLogin</title>
    <link rel="stylesheet" href="/layui/css/layui.css" media="all">
    <script src="/layui/layui.js" charset="utf-8" ></script>
    <script src="/layui/jquery-1.8.3.js"></script>
<#--    <link rel="stylesheet" href="/layui/css/public.css" media="all">-->
</head>
<body>
    <blockquote class="layui-elem-quote layui-text">
        <h3>登录页面</h3>
    </blockquote>
    <form class="layui-form">

            <div class="layui-form-item input-item" >
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-block" style="width: 300px">
                    <input type="text" placeholder="请输入用户名" autocomplete="off" name="userName" class="layui-input" lay-verify="required">
                </div>
            </div>

            <div class="layui-form-item input-item" >
                <label class="layui-form-label">密码</label>
                <div class="layui-input-block" style="width: 300px">
                    <input type="password" placeholder="请输入密码" autocomplete="off" name="password" class="layui-input" lay-verify="required">
                </div>
            </div>

            <!--            <div class="layui-form-item input-item" id="imgCode">-->
            <!--                <input type="text" placeholder="请输入验证码" name="code" autocomplete="off" id="code" class="layui-input">-->
            <!--                <img style="margin-right: 20px" width="100px" id="verify_code_img" height="32"-->
            <!--                     src="/verifyCode/getImg" onclick="javascript:changeImg()"><br>-->
            <!--            </div>-->

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn layui-block" lay-filter="login" lay-submit>登录</button>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <a href="/register">还未账户？点击注册</a>
                </div>
            </div>

    </form>
</body>

<script>
    layui.use(['form', 'layer', 'jquery'], function () {
        var form = layui.form,
            // layer = layui.layer,
            layer = parent.layer === undefined ? layui.layer : top.layer
            $ = layui.jquery;
            // , layedit = layui.layedit
            // , laydate = layui.laydate;

        form.on('submit(login)', function (data) {
            // console.log(data);
            var btn = $(this);
            //设置登录按钮为不可点击
            btn.text("登录中...").attr("disabled", "disabled").addClass("layui-disabled");
            $.ajax({
                url: '/userlogindata',
                contentType: "application/json",
                dataType: 'json',
                type:"post",
                data: JSON.stringify(data.field),
                success: function (res) {
                    //失败，返回错误信息
                    if (res.code!=0) {
                        layer.msg(res.msg);
                        //设置登录按钮  为不可点击
                        btn.text("登录").attr("disabled", false).removeClass("layui-disabled");
                        // $(function () {
                        //     changeImg();
                        // })
                    } else {
                        //成功，跳转到首页
                        layer.alert('登录成功', {icon: 6, title: '提示', time: 1500})
                        setTimeout(function () {
                            window.parent.location.reload();
                            // window.location.href="index.ftl";
                        }, 1500);
                    }
                }
            })
        });
    });
</script>


</html>
