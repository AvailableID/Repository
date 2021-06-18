package com.yiwang.graduate.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yiwang.graduate.domain.AjaxRes;
import com.yiwang.graduate.entity.GoodsOrder;
import com.yiwang.graduate.entity.User;
import com.yiwang.graduate.mapper.OrderMapper;
import com.yiwang.graduate.service.SidebarOrderService;
import com.yiwang.graduate.vo.DataVO;
import com.yiwang.graduate.vo.OrderVO;
import com.yiwang.graduate.vo.UserVO;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Controller
public class SidebarOrderCtrl {
    @Resource
    private SidebarOrderService sidebarOrderService;
    @Resource
    private OrderMapper orderMapper;

    @GetMapping("/admin/orderTable")
    public String orderTable(String orderTable){
        return orderTable;
    }

    //侧边栏-订单表-添加订单表
    @GetMapping("/admin/addOrderTable")
    public String add(String add) {
        return add;       //1.前面不能加/  2.无参方式不管用
    }

    //侧边栏-订单表-编辑订单表
    @RequestMapping(value = "/admin/editOrderTable", method = RequestMethod.GET)
    public String edit(String edit) {
        return edit;
    }


//-----------------------------------------json数据接口---------------------------------------------------

    //获取订单数据分页
    @GetMapping("/orderlist")
    @ResponseBody
    public DataVO list(Integer page, Integer limit) {
        return sidebarOrderService.findData(page, limit);
    }

    //订单查询
    @RequestMapping(value = "/queryorder")
    @ResponseBody
    public DataVO<OrderVO> queryOrder(@RequestParam(name="key",required = false)String key,
                                     @RequestParam(name = "page",required = false)int page,
                                     @RequestParam(name = "limit",required = false)int limit){

        DataVO dataVO = new DataVO();
        IPage<GoodsOrder> orderIPage = new Page<>(page,limit);
        IPage<GoodsOrder> result = orderMapper.selectPage(orderIPage,new QueryWrapper<GoodsOrder>()
                .like(StringUtils.isNotBlank(key),"order_id",key)
                .or().like(StringUtils.isNotBlank(key),"title",key)
        );

        dataVO.setData(orderIPage.getRecords());
        dataVO.setCount(result.getTotal()); //获取对象总数
        dataVO.setCode(0);
        dataVO.setMsg("");
        return dataVO;
    }

    //添加订单
    @PostMapping("/addOrder")
    @Transactional
    public String addOrder(GoodsOrder goodsOrder) {
        sidebarOrderService.insertOrder(goodsOrder);
        System.out.println(goodsOrder);
        return "ok";
    }

    //删除订单
    @PostMapping("/delOrder")
    @ResponseBody
    public AjaxRes delOrder(Integer orderId) {
        System.out.println(orderId);
        return sidebarOrderService.delOrder(orderId);
    }

    //订单删除订单
    @RequestMapping("/delAllOrder")
    @ResponseBody
    public AjaxRes delAllOrder(String orderId) {
        List<String> delList = new ArrayList<>();
        String[] strs = orderId.split(",");
        for (String str : strs) {
            delList.add(str);
        }
        return sidebarOrderService.delAllOrder(delList);
    }

    //编辑订单
    @PostMapping("/editOrder")
    public String editOrder(GoodsOrder goodsOrder) {
        sidebarOrderService.updateOrder(goodsOrder);
        System.out.println(goodsOrder);
        return "ok";
    }
}