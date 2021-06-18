<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="/layui/css/layui.css" rel="stylesheet">
    <script src="/layui/layui.js"></script>
    <script src="/layui/jquery-1.8.3.js"></script>
    <style>
        .bb-info li {
            margin-top: 20px;
        }

        .bb-description img {
            width: 100%;
        }

        .bb-param td:first-child {
            background-color: #eeeeee;
        }
        .layui-this a{
            font-size: 18px;
        }
    </style>
</head>
<body style="background-color: #eeeeee">

<ul class="layui-nav layui-bg-green" style="text-align: right;">
    <li class="layui-nav-item" style="margin-right: 45px;" >
        <#if Session["username"]?exists>
            <img src="/images/adminlogin.jpg" class="layui-nav-img">${Session["username"]}
<#--            <dl class="layui-nav-child">-->
<#--                <dd><a href="/userlogout">退出登录</a></dd>-->
<#--            </dl>-->
        </#if>

        <#if !Session["username"]?exists>
            <a href="javascript:;"><img src="/images/adminlogin.jpg" class="layui-nav-img" id="userlogin">登录</a>
        </#if>
    </li>
</ul>
<div class="layui-container" style="padding: 10px;border: 1px solid #ccc;background-color:white">
    <span class="layui-breadcrumb" style="visibility: visible;">
      <a href="/">首页</a><span lay-separator="">/</span>
      <a><cite>确认订单 </cite></a>
    </span>
    <div class="layui-row" style="padding-top: 10px">
        <div class="layui-col-xs4">
            <div class="layui-carousel" id="test1">
                <div carousel-item>
                    <#list covers as c>
                        <div>
                            <img src="${c.gcPicUrl}" style="width:100%">
                        </div>
                    </#list>
                </div>
            </div>
        </div>
        <div class="layui-col-xs8" style="padding: 10px">
            <ul class="bb-info">
				<li>
                    <h1 >确认订单</h1>
                </li>
                <li>
                    <h2>${goods.title}</h2>
                </li>
                <li class="layui-bg-green" style="padding:10px;line-height: 30px">
                    收件人：<#if Session["username"]?exists>${Session["username"]}</#if><span  style="margin-left:30px">
                    联系电话：<#if Session["mobile"]?exists>${Session["mobile"]}</#if></span><br/>
					收货地址：<#if Session["address"]?exists>${Session["address"]}</#if><br/>
					购买数量：1</span><br/>
					邮费：¥0.00</span><br/>
<#--					实付款：<span style="font-size: 26px;color: orange;font-weight: bold">${goods.currentPrice?string('￥0.00')}</span><br/>-->
                    <#if (goods.goodsId)??>商品价格：<span style="text-decoration: blink; font-size: 20px;color: #393D49">${goods.originalCost?string('￥0.00')}</span></#if>
                    <#if (goods.currentPrice)??>秒杀价：<span></span><span style="font-size: 20px;color: white;font-weight: bold">${goods.currentPrice?string('￥0.00')}</span></#if>
                </li>

                <li>
<#--                    <img src='./layui/images/weixin.jpg' id="oImg" width="180px" hight="180px">-->
                    <button class="layui-btn layui-btn-normal layui-bg-red" id="pay" >支付</button>
                </li>
            </ul>
        </div>
    </div>
</div>

<#--<Script LANGUAGE="JavaScript">-->
<#--    function reP(){-->
<#--        document.getElementById('oImg').style.display = "block";-->
<#--    }-->
<#--</Script>-->
<script>
    var $ = layui.$;
    var goodsid =${goods.goodsId};
    $("#pay").click(function (data) {
        $.ajax({
            url: '/decrease',
            async: true,
            datype: "json",
            data: {
                goodsid: goodsid
            },
            success: function (data) {
                layer.alert('支付成功', {icon: 6, title: '提示', time: 1500})
                setTimeout(function () {
                    window.parent.location.reload();
                    //window.location.href="index.ftl";
                }, 1500);
            },
            error: function () {
                layer.alert('请求失败，系统错误', {icon: 7, title: '提示', time: 1000})
            }
        });
    });
</script>
<script>
    //由于模块都一次性加载，因此不用执行 layui.use() 来加载对应模块，直接使用即可：
    ;!function () {
        var layer = layui.layer
            , form = layui.form;

    }();
</script>

<script>
    layui.use('carousel', function () {
        var carousel = layui.carousel;
        //建造实例
        carousel.render({
            elem: '#test1'
            , width: '380px' //设置容器宽度
            , height: '380px'
            , arrow: 'hover' //始终显示箭头
            , anim: 'fade' //切换动画方式
        });
    });
</script>
<script>
layui.use('util', function(){
  var util = layui.util;
  
  //示例
  var endTime = new Date().getTime() + (3600 * 1000 * 24) //假设为结束日期
  ,serverTime = new Date().getTime(); //假设为当前服务器时间，这里采用的是本地时间，实际使用一般是取服务端的
   
  util.countdown(endTime, serverTime, function(date, serverTime, timer){
    var str = date[0] + '天' + date[1] + '时' +  date[2] + '分' + date[3] + '秒';
    layui.$('#ds').html(str);
  });
});
</script>


</body>
</html>
