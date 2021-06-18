package com.yiwang.graduate.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yiwang.graduate.domain.AjaxRes;
import com.yiwang.graduate.entity.Goods;
import com.yiwang.graduate.entity.GoodsOrder;
import com.yiwang.graduate.entity.User;
import com.yiwang.graduate.mapper.GoodsMapper;
import com.yiwang.graduate.mapper.OrderMapper;
import com.yiwang.graduate.mapper.UserMapper;
import com.yiwang.graduate.service.SidebarOrderService;
import com.yiwang.graduate.vo.DataVO;
import com.yiwang.graduate.vo.OrderVO;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class SidebarOrderServiceImpl implements SidebarOrderService {
    @Resource
    private OrderMapper orderMapper;
    @Resource
    private UserMapper userMapper;
    @Resource
    private GoodsMapper goodsMapper;

    @Override
    public DataVO<OrderVO> findData(Integer page, Integer limit) {
        DataVO dataVO = new DataVO();
        dataVO.setCode(0);
        dataVO.setMsg("");
        //dataVO.setCount(Long.valueOf(orderMapper.selectCount(null)));//原：查询所有数据的数量
        //分页
        IPage<GoodsOrder> orderIPage = new Page<>(page, limit);
        IPage<GoodsOrder> result = orderMapper.selectPage(orderIPage,null);

        dataVO.setCount(result.getTotal());//分页方法：查询所有数据的数量

        List<GoodsOrder> goodsOrderList = result.getRecords();  //分页方法：查询所有数据
        //List<Order> orderList = orderMapper.selectList(null);    //原：查询所有数据
        List<OrderVO> orderVOlist = new ArrayList<>();
        for (GoodsOrder goodsOrder : goodsOrderList) {
            OrderVO orderVO = new OrderVO();       //这句不能放在方法体外面
            BeanUtils.copyProperties(goodsOrder,orderVO);

            QueryWrapper wrapper = new QueryWrapper();
            wrapper.eq("goods_id",goodsOrder.getGoodsId()); //entity的id,绿色的column要和数据对应
            Goods goods = goodsMapper.selectOne(wrapper);      //去外表的DAO层找对应的id对象
            if (goods!=null){
                orderVO.setTitle(goods.getTitle());   //所以setVoname去外表查询上面的id,再.name;get谁的name?get别的表对应id对象的name
            }

            QueryWrapper wrapper2 = new QueryWrapper();
            wrapper2.eq("userid",goodsOrder.getUserid()); //entity的id,绿色的column要和数据对应
            User user = userMapper.selectOne(wrapper2);      //去外表的DAO层找对应的id对象
            if (user!=null){
                orderVO.setUserName(user.getUserName());   //所以setVoname去外表查询上面的id,再.name;get谁的name?get别的表对应id对象的name
            }

            orderVOlist.add(orderVO);
        }
        dataVO.setData(orderVOlist);
        return dataVO;
    }

    @Override
    public void insertOrder(GoodsOrder goodsOrder) {
        orderMapper.insert(goodsOrder);
    }

    @Override
    public AjaxRes delOrder(Integer orderId) {
        orderMapper.deleteOrder(orderId);
        return null;
    }

    @Override
    public void updateOrder(GoodsOrder goodsOrder) {
        orderMapper.updateOrder(goodsOrder);
    }

    @Override
    public AjaxRes delAllOrder(List<String> delList) {
        AjaxRes ajaxRes = new AjaxRes();
        try {
            orderMapper.delAllUser(delList);
            ajaxRes.setMsg("删除订单成功");
            ajaxRes.setSuccess(true);
        } catch (Exception e) {
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("删除订单失败");
        }
        return ajaxRes;
    }
}
