<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <title>UserRegister</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
<#--    <link rel="stylesheet" href="layui/css/public.css" media="all">-->
    <script src="/layui/layui.js" charset="utf-8" type="text/javascript"></script>
    <script src="/layui/jquery-1.8.3.js"></script>
</head>
<body>

<div class="login-main">
    <blockquote class="layui-elem-quote layui-text">
        <h3>用户注册</h3>
    </blockquote>
    <form class="layui-form">

        <div class="layui-form-item input-item" >
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-block" style="width: 300px">
                <input type="text" placeholder="请输入用户名" id="username"
                       name="userName" class="layui-input" autocomplete="off" lay-verify="required">
                <span style="display: none" id="noable" >已被注册</span>
                <span style="display: none" id="able">可用</span>
            </div>
<#--            <div class="layui-inline">-->
<#--                <i class="layui-icon" hidden id="ri" style="color: green; font-weight: bold"></i>-->
<#--                <i class="layui-icon" hidden id="le" style="color: red; font-weight: bold">ဆ</i>-->
<#--            </div>-->
        </div>

        <div class="layui-form-item input-item" >
            <label class="layui-form-label">密码</label>
            <div class="layui-input-block" style="width: 300px">
                <input type="password" placeholder="请输入密码" id="password" name="password" class="layui-input" lay-verify="required" >
            </div>
        </div>

        <div class="layui-form-item input-item">
            <label class="layui-form-label">确认密码</label>
            <div class="layui-input-block" style="width: 300px">
                <input type="password" name="password2"  lay-verify="required" placeholder="请再次输入密码" autocomplete="off" class="layui-input" id="password2">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <input type="radio" name="gender" value="男" title="男" checked>
                <input type="radio" name="gender" value="女" title="女">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline" >
                <label class="layui-form-label">所在地</label>
                <div class="layui-input-inline" style="width: 300px">
                    <select name="type" lay-verify="required" lay-filter="type" id='selection' >
                        <option value=""></option>
                        <option value="1">河南省</option>
                        <option value="2">湖北省</option>
                        <option value="3">上海</option>
                        <option value="4">山东省</option>
                        <option value="5">浙江省</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">联系方式</label>
            <div class="layui-input-inline" style="width: 300px">
                <input type="text" id="phone" placeholder="请输入手机号" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">电子邮箱</label>
            <div class="layui-input-inline" style="width: 300px">
                <input type="text" name="email" lay-verify="email" id="email" placeholder="请输入邮箱" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="" class="layui-btn" lay-submit lay-filter="regiterbtn"  >注册</button>
            </div>
        </div>


        <div class="layui-form-item">
            <div class="layui-input-block">
                <a href="/userlogin" class="fl">已注册？立即登录</a>
            </div>
        </div>
    </form>
</div>

<script>
    layui.use(['form', 'layer','jquery', 'layedit'], function () {
            var form  = layui.form,
            layer = layui.layer;
        form.on('submit(regiterbtn)', function (data) {
            //debugger
            var username = $("#username").val();
            var password = $("#password").val();
            var gender = $("input[name='gender']:checked").val();
            var address=$('#selection').find('option:selected').text();
            var mobile = $("#phone").val();
            var email = $("#email").val();
            // var btn = $(this);

            //设置注册按钮不可点击，防止多次点击
            //btn.text("注册中...").attr("disabled", "disabled").addClass("layui-disabled");
            $.ajax({
                type: 'post',
                url: '/registerdata',
                async: true,
                dataType: "json",
                data:{
                    userName: username,
                    password,
                    gender,
                    address,
                    mobile,
                    email
                },
                success: function (data) {
                    if (data){
                        layer.msg('注册成功', {icon: 7, title: '提示', time: 4000})
                    }else{
                        layer.msg('注册失败', {icon: 7, title: '提示', time: 4000})
                    }
                },
                error: function () {
                    layer.msg('失败', {icon: 6, title: '提示', time: 4000})
                }
            });
        });
    })

        //判断账号是否已存在
        $("#username").blur(function() {
            var username = $("#username").val();
            $.ajax({
                url:'/registerblur',
                type:'post',
                data:{
                    username:username,
                },
                success:function(data){
                    if(!data) {
                        layer.msg("用户名已存在，请切换用户名！", {
                            "icon": 2,
                            "time": 2500
                        });
                        return false;
                    }
                    return true;
                }
            })
        });

        //两次密码验证
        $("#password2").blur(function() {
            var pass1 = $("#password").val();
            var pass2 = $("#password2").val();
            if(pass1 != pass2) {
                layer.msg("两次输入的密码不一致", {
                    "icon": 2,
                    "time": 2000
                });
                $("#pass2").val("");
                return false;
            }
            return true;
        });

        //验证用户名不能为空
        $("#username").blur(function() {
            var userName = $("#username").val();
            if(userName.length<1) {
                layer.msg("用户名不能为空", {
                    "icon": 2,
                    "time": 2000
                });
                $("#userName").val("");
                return false;
            }
            return true;
        });

        //手机号验证
        $("#phone").blur(function() {
            var phone = $("#phone").val();
            if(phone.length<11||phone.length>11) {
                layer.msg("手机号为11位数", {
                    "icon": 2,
                    "time": 2000
                });
                return false;
            }
            return true;
        });

        //判断账号密码是否存在
        // form.on('submit(regiterbtn)',function () {
        //     $.ajax({
        //         url: 'registerdata',
        //         type: 'post',
        //         data: {
        //             userName: $('#userName').val(),        //紫色的username是entity的属性
        //             password: $('#password').val()
        //
        //         },
        //         dataType: 'json',
        //         //判断注册状态
        //         success: function (data) {
        //             layer.msg('注册失败')
        //         },
        //         error: function () {
        //             layer.msg('注册成功')
        //         }
        //     })
        //     //防止页面跳转
        //     return false;
        // });

</script>
</body>
</html>