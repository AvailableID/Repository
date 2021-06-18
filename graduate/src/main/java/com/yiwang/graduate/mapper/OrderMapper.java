package com.yiwang.graduate.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yiwang.graduate.entity.GoodsOrder;

import java.util.List;

public interface OrderMapper extends BaseMapper<GoodsOrder> {
    void insertOrder(GoodsOrder order);
    GoodsOrder findByOrderNo(String orderNo);
    void deleteOrder(Integer orderId);
    void updateOrder(GoodsOrder goodsOrder);
    void delAllUser(List<String> delList);
}
