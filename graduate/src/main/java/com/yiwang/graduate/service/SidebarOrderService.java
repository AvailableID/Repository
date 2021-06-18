package com.yiwang.graduate.service;

import com.yiwang.graduate.domain.AjaxRes;
import com.yiwang.graduate.entity.GoodsOrder;
import com.yiwang.graduate.vo.DataVO;
import com.yiwang.graduate.vo.OrderVO;
import com.yiwang.graduate.vo.UserVO;

import java.util.List;

public interface SidebarOrderService {
    DataVO<OrderVO> findData(Integer page, Integer limit);

    void insertOrder(GoodsOrder goodsOrder);

    AjaxRes delOrder(Integer orderId);

    void updateOrder(GoodsOrder goodsOrder);

    AjaxRes delAllOrder(List<String> delList);
}
