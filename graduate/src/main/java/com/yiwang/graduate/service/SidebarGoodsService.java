package com.yiwang.graduate.service;

import com.yiwang.graduate.domain.AjaxRes;
import com.yiwang.graduate.entity.Goods;
import com.yiwang.graduate.vo.DataVO;
import com.yiwang.graduate.vo.GoodsVO;

import java.util.List;

public interface SidebarGoodsService {
    DataVO<GoodsVO> findData(Integer page, Integer limit);
    AjaxRes delGoods(Integer goodId);
    String updateGoods(Goods goods);
    String insertGoods(Goods goods);
    DataVO<GoodsVO> queryGoods(Integer page,Integer limit,String title);//模糊查询
    void findGoodsByTitle(String title);   //模糊查询
    AjaxRes delAllGoods(List<String> delList);
}
