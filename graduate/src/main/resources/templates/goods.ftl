<!DOCTYPE html>
<meta charset="UTF-8">
<title></title>
<link href="/layui/css/layui.css" rel="stylesheet">
<script src="/layui/layui.js"></script>
<script src="https://cdn.bootcss.com/limonte-sweetalert2/7.21.1/sweetalert2.all.js"></script>

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
            <dl class="layui-nav-child">
                <dd><a href="userlogout" id="userlogout">退出登录</a></dd>
            </dl>
        </#if>

        <#if !Session["username"]?exists>
            <a href="javascript:;"><img src="/images/adminlogin.jpg" class="layui-nav-img" id="userlogin">登录</a>
        </#if>
    </li>
</ul>

<div class="layui-container" style="padding: 10px;border: 1px solid #ccc;background-color:white">
    <span class="layui-breadcrumb" style="visibility: visible;">
      <a href="/">首页</a><span lay-separator="">/</span>
      <a><cite><#if (goods.title)??>${goods.title}</#if></cite></a>
    </span>
    <div class="layui-row" style="padding-top: 10px">
        <div class="layui-col-xs4">
            <div class="layui-carousel" id="test1">
                <div carousel-item >
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
            <#if (goods.currentPrice)??>
                <li class="layui-bg-red" style="padding:10px;line-height: 30px">
                    <h2>活动结束倒计时<span id="ds"></span></h2>
                </li>
            </#if>
        <li>
            <h2><#if (goods.title)??>${goods.title}</#if></h2>
        </li>

        <li class="layui-bg-green" style="padding:10px;line-height: 30px">
            <#if (goods.subTitle)??>${goods.subTitle}</#if>
        </li>
            </br>
        <li style="color: darkgrey">
            <#if (goods.currentPrice)??>秒杀价：<span></span><span style="font-size: 26px;color: orange;font-weight: bold">${goods.currentPrice?string('￥0.00')}</span></#if>
            <#if (goods.originalCost)??>商品价格：<span style="text-decoration: blink; font-size: 20px;color: #393D49">${goods.originalCost?string('￥0.00')}</span></#if>,
            <#if (goods.goodsId)??><span> 商品库存仅剩<span style="font-size: 26px;color: orange;font-weight: bold">${goods.stock}</span>件!</span></#if>
        </li>
            </br>
    <#--       <li>-->
    <#--           数量：-->
    <#--           <div class="layui-btn-group">-->
    <#--               <button class="layui-btn layui-btn-primary layui-btn-sm">-->
    <#--                   <span style="font-size: 18px">-</span></button>-->
    <#--               <button class="layui-btn layui-btn-primary layui-btn-sm" style="width: 50px">1</button>-->
    <#--               <button class="layui-btn layui-btn-primary layui-btn-sm"><span style="font-size: 18px">+</span>-->
    <#--               </button>-->
    <#--           </div>-->
    <#--       </li>-->
            <li>
                <button class="layui-btn layui-btn-normal layui-bg-red"  id="btnSecKill" >立即购买</button>
            </li>
        </ul>
    </div>
</div>

    <div class="layui-row">
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            <ul class="layui-tab-title">
                <li class="layui-this">产品详情</li>
                <li>产品参数</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show bb-description layui-col-xs8 layui-col-xs-offset2">
                    <#list details as d>
                    <img src="${d.gdPicUrl}">
                    </#list>
            </div>
                <div class="layui-tab-item layui-col-xs8 layui-col-xs-offset2">
                    <table class="layui-table bb-param" lay-size="lg">
                        <colgroup>
                            <col width="30%">
                            <col width="70%">
                        </colgroup>
                        <tbody>
                        <#list params as p>
                        <tr>
                            <td>${p.gpParamName}</td>
                            <td>${p.gpParamValue}</td>
                        </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>

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
    var $ = layui.$;
    var goodsid =${goods.goodsId};

        if(status==1){      //走redis
            $("#btnSecKill").click(function () {

                <#if !Session["username"]?exists>
                        layui.use('layer', function () {
                            layer.open({
                                // title: '用户登录',
                                type: 2,
                                content: 'userlogin',
                                area: ['500px', '380px'],
                                // maxmin: true
                            })
                        })
                </#if>

                <#if Session["username"]?exists>
                     var username = '${Session["username"]}';
                    $.getJSON("/seckill?goodsid="+goodsid+"username="+username,function(json){       //利用session获取商品id和用户id
                        if(json.code == "0"){                    //0代表数据处理成功
                            alert("抢购成功！正在下单，请稍候....");
                            var orderNo = json.data.orderNo;
                            console.info(orderNo);
                            swal({
                                title : "正在创建订单，请稍后...",
                                timer : 3000 ,
                                showConfirmButton: false ,
                                type : "info"
                            }).then(function(){
                                window.location.href = "/checkorder?orderNo=" + orderNo;
                            })
                        }else{
                            alert(json.message);
                        }
                    });
                </#if>

            });
        }else{      //不走redis
            $("#btnSecKill").click(function () {
                <#if !Session["username"]?exists>
                alert("请先登录");
                        layui.use('layer', function () {
                            layer.open({
                                // title: '用户登录',
                                type: 2,
                                content: 'userlogin',
                                area: ['500px', '380px'],
                                // maxmin: true
                            })
                        })
                </#if>

                <#if Session["username"]?exists>
                     var username = '${Session["username"]}';
                    $.getJSON("/purchase?goodsid=" + goodsid + "&username="+username, function (json) {   //利用session获取商品id和用户id
                        if (json.code == "0") {   //0代表数据处理成功
                            alert("正在下单，请稍候....");
                            var orderNo = json.data.orderNo;
                            console.info(orderNo);
                            swal({
                                title: "正在创建订单，请稍后...",
                                timer: 3000,
                                showConfirmButton: false,
                                type: "info"
                            }).then(function () {
                                window.location.href = "/checkorder?orderNo=" + orderNo;
                            })
                        } else {
                            alert(json.message);
                        }
                    });
                </#if>

            });
        }

    //用户登录
    $("#userlogin").click(function () {
        layui.use('layer', function () {
            layer.open({
               // title: '用户登录',
                type: 2,
                content: 'userlogin',
                area: ['500px', '380px'],
                maxmin: true
            })
        })
    });


    //用户退出  木大
    $("#userlogout").click(function () {
        layui.use('layer', function () {
            sessionStorage.removeItem("username");
            layer.alert('退出成功', {icon: 6, title: '提示', time: 1000})
            setTimeout(function () {
                window.parent.location.reload();
                //window.location.href="index.ftl";
            }, 1500);
        })
    });




</script>
<#--倒计时-->
<script>
    layui.use('util', function(){
        var util = layui.util;

        //示例
        var endTime = new Date().getTime() + (3599 * 1000 * 5) //假设为结束日期
            ,serverTime = new Date().getTime(); //假设为当前服务器时间，这里采用的是本地时间，实际使用一般是取服务端的

        util.countdown(endTime, serverTime, function(date, serverTime, timer){
            var str = date[0] + '天' + date[1] + '时' +  date[2] + '分' + date[3] + '秒';
            layui.$('#ds').html(str);
        });
    });
</script>

</html>
