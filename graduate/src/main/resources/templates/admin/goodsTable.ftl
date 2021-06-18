<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>GoodsTable</title>
    <link rel="stylesheet" href="/layui/css/layui.css" media="all">
    <script src="/layui/jquery-1.8.3.js"></script>
    <script src="/layui/layui.js" charset="utf-8" type="text/javascript"></script>

</head>
<body>
        <div class="layui-inline">
            <label class="layui-form-label">搜索商品：</label>
            <div class="layui-inline">
                <input class="layui-input" type="text" placeholder="请输入商品名或商品id" id="title_search" style="width: 220px" autocomplete="off">
            </div>
            <button class="layui-btn" type="submit" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
            <button class="layui-btn layui-bg-green" id="add"><i class="layui-icon">&#xe654;</i>添加</button>
            <button class="layui-btn layui-btn-danger delAll_btn" id="delAll_btn"><i class="layui-icon">&#xe640;</i>批量删除</button>
        </div>
    <table class="layui-hide" id="test" lay-filter="test"></table>  <!--lay-filter=""相当于ID选择器-->
</body>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm layui-bg-green" lay-event="getCheckData">获取选中行数据</button>
        <button class="layui-btn layui-btn-sm layui-bg-green" lay-event="getCheckLength">获取选中数目</button>
<#--        <button class="layui-btn layui-btn-sm layui-bg-green" lay-event="isAll">验证是否全选</button>-->
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit"><i class="layui-icon">&#xe642;</i>编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon">&#xe640;</i>删除</a>
</script>

<script>
    //温馨提示：默认由前端自动合计当前行数据。从 layui 2.5.6 开始： 若接口直接返回了合计行数据，则优先读取接口合计行数据。
    //详见：https://www.layui.com/doc/modules/table.html#totalRow

    layui.use('table', function(){
        var table = layui.table;
        var tableIns = table.render({
            elem: '#test'   //绑定对应表格
            ,url:'/goodslist'    //数据来源
            ,toolbar: '#toolbarDemo'    //绑定三个按钮
            ,title: '商品数据表'    //导出表格的文件名就叫这个
            ,totalRow: true         //统计总数
            ,id:"goodsListTable"
            ,cols: [[
                {type: 'checkbox', fixed: 'left', totalRowText: '合计'}   //复选框
                ,{field:'goodsId', title:'商品id', width:100,align:"center", fixed: 'left'}
                ,{field:'title', title:'名称', width:240}
                ,{field:'subTitle', title:'子名称', width:240}
                ,{field:'originalCost', title:'原价', width:120,align:"center"}
                ,{field:'currentPrice', title:'秒杀价', width:120,align:"center"}
                ,{field:'stock', title:'库存', width:120 ,align:"center"}
                ,{field:'status', title:'Redis缓存', width:120,align:"center"}
                ,{fixed: 'right',title:'操作',toolbar:'#barDemo',width:173,align:"center"}
            ]]
            ,page: true //分页功能
            ,request: {
                pageName: 'page'  //页码的参数名称，默认：page
                ,limitName: 'limit'  //每页数据量的参数名，默认：limit
                ,statusName:'code'//数据状态的字段名称，默认：code
                ,statusCode:0 //成功的状态码，默认：0
            }
        });
        //全选三
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                // case 'isAll':
                //     layer.msg(checkStatus.isAll ? '全选': '未全选')
                //     break;
            };
        });

        //查询按钮
        var $ = layui.$, active={
            reload: function(){
                var title = $('#title_search').val();
                table.reload('goodsListTable',{
                    page: {
                        curr: 1 //重新从第 1 页开始
                    },
                    where: {
                        key: title
                    },
                    url: '/querygoods'//后台做模糊搜索接口路径
                });
            }
        };
        $("#search").on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        //添加按钮
        $("#add").click(function () {
            layui.use('layer', function () {
                layer.open({
                    title: '添加信息',
                    type: 2,
                    content: 'addGoodsTable',   //前面不能加/
                    area: ['800px', '600px'],
                    maxmin: true
                })
            })
        })

        //批量删除
        $(".delAll_btn").click(function () {
            var checkStatus = table.checkStatus('goodsListTable'),  //获取表格选中行
                data = checkStatus.data, //.data方法获得当前行数据，前面的checkStatus是上一行的变量名
                goodsId = "";
                    if (data.length > 0) {
                        console.log(data);
                        console.log(checkStatus);
                        for (var i in data) {
                            goodsId += data[i].goodsId + ",";
                        }
                        //console.log(goodsId);
                        layer.confirm('确定删除选中的用户？', {icon: 3, title: '提示信息'}, function (index) {
                            $.post('/delAllGoods', {goodsId: goodsId}, function (data) {
                                layer.msg(data.msg);
                                tableIns.reload();
                                layer.close(index);
                            });
                        })
                    } else {
                        layer.msg("请选择需要删除的用户");
                    }
        });

        //编辑按钮、删除按钮
        table.on('tool(test)', function(obj){
            var data = obj.data;
            if(obj.event === 'edit'){
                json = JSON.stringify(data);
                layui.use('layer', function () {
                    layer.open({
                        title: '修改信息',
                        type: 2,    //unsure
                        content: 'editGoodsTable',    //映射地址
                        area: ['800px', '600px'],
                        maxmin: true    //设置显示最大最小化按钮
                    })
                })
            }else if(obj.event === 'del'){    //del对应上面的lay-event
                layer.confirm('确定要删除行吗', function(index){
                    $.post('/delGoods', {goodsId: obj.data.goodsId}, function (data) {
                        layer.msg(data.msg);
                        tableIns.reload();
                        layer.close(index);
                    })
                    setTimeout(function () {
                        window.parent.location.reload();
                        // window.location.href="index.ftl";
                    }, 1500);
                });
            }
        });
    });
</script>


</html>