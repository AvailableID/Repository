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
    <h3>编辑信息</h3>
</blockquote>
<form class="layui-form" action="">
    <div class="layui-form-item">
        <label class="layui-form-label" >用户ID</label>
        <div class="layui-input-block">
            <input type="text" name="userid" lay-verify="" autocomplete="off" placeholder="请输入用户ID" class="layui-input" id="userid" readonly>
        </div>
    </div>
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

        $("input[name='userid']").val(parent_json.userid);
        $("input[name='userName']").val(parent_json.userName);
        $("input[name='password']").val(parent_json.password);
        $("input[name='gender']").val(parent_json.gender);
        $("input[name='address']").val(parent_json.address);
        $("input[name='mobile']").val(parent_json.mobile);
        $("input[name='email']").val(parent_json.email);    //少了个单引号所以没有获取到值
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
            var userid = $("#userid").val();
            var userName = $("#userName").val();
            var password = $("#password").val();
            var gender = $("#gender").val();
            var address = $("#address").val();
            var mobile = $("#mobile").val();
            var email = $("#email").val();
            $.ajax({
                type: 'post',
                url: '/editUser',
                async: true,
                datype: "json",
                data: {
                    userid: userid,
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