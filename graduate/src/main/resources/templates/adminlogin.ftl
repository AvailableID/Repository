<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AdminLogin</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <link rel="stylesheet" href="layui/css/public.css" media="all">
    <script src="layui/layui.js" charset="utf-8" type="text/javascript"></script>
</head>
<body class="loginBody">
    <form class="layui-form">
        <div>
            <div class="loginbox-title">后台登录</div>
            <div class="loginbox-social">
                <div class="social-title">管理员</div>
            </div>

            <div class="layui-form-item input-item">
                <label>用户名</label>
                <input type="text" placeholder="请输入用户名" autocomplete="off" name="adminName" class="layui-input"
                       lay-verify="required">
            </div>

            <div class="layui-form-item input-item">
                <label>密码</label>
                <input type="password" placeholder="请输入密码" autocomplete="off" name="password" class="layui-input"
                       lay-verify="required">
            </div>

<!--            <div class="layui-form-item input-item" id="imgCode">-->
<!--                <input type="text" placeholder="请输入验证码" name="code" autocomplete="off" id="code" class="layui-input">-->
<!--                <img style="margin-right: 20px" width="100px" id="verify_code_img" height="32"-->
<!--                     src="/verifyCode/getImg" onclick="javascript:changeImg()"><br>-->
<!--            </div>-->

            <div class="layui-form-item">
                <button class="layui-btn layui-block" lay-filter="login" lay-submit>登录</button>
            </div>

<!--            <div class="layui-form-item">-->
<!--                <a href="/register/toRegister">还未账户？点击注册</a>-->
<!--                <a style="text-decoration:underline	;padding-left: 10px;color: #2badce" href="/">回首页</a>-->
<!--                &lt;!&ndash;<input id="butt" type="button" value="注册" /><br><br><br>&ndash;&gt;-->
<!--            </div>-->
        </div>
    </form>
</body>

<script>
    layui.use(['form', 'layer', 'jquery'], function () {
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : top.layer
             $ = layui.jquery;

        //登录按钮
        form.on('submit(login)', function (result) {
            var btn = $(this);
            //设置登录按钮为不可点击
            btn.text("登录中...").attr("disabled", "disabled").addClass("layui-disabled");
            $.ajax({
                url: '/adminlogindata',
                contentType: "application/json",
                dataType: 'json',
                type:"post",
                data: JSON.stringify(result.field),
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
                        layer.msg(res.msg);
                        location.href = "/admin/index";
                    }
                }
            })
        });

        //表单输入效果
        $(".loginBody .input-item").click(function (e) {
            e.stopPropagation();
            $(this).addClass("layui-input-focus").find(".layui-input").focus();
        })
        $(".loginBody .layui-form-item .layui-input").focus(function () {
            $(this).parent().addClass("layui-input-focus");
        })
        $(".loginBody .layui-form-item .layui-input").blur(function () {
            $(this).parent().removeClass("layui-input-focus");
            if ($(this).val() != '') {
                $(this).parent().addClass("layui-input-active");
            } else {
                $(this).parent().removeClass("layui-input-active");
            }
        })
    })

    /* 触发JS刷新  切换验证码*/
    function changeImg() {
        var img = document.getElementById("verify_code_img");
        img.src = "/verifyCode/getImg?date=" + new Date();
    }
</script>
</html>