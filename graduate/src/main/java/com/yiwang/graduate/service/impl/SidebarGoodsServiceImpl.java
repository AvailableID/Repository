package com.yiwang.graduate.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yiwang.graduate.domain.AjaxRes;
import com.yiwang.graduate.entity.Goods;
import com.yiwang.graduate.mapper.GoodsMapper;
import com.yiwang.graduate.service.SidebarGoodsService;
import com.yiwang.graduate.vo.DataVO;
import com.yiwang.graduate.vo.GoodsVO;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class SidebarGoodsServiceImpl implements SidebarGoodsService {
    @Resource
    private GoodsMapper goodsMapper;

    //分页查询
    @Override
    public DataVO<GoodsVO> findData(Integer page,Integer limit) {
        QueryWrapper wrapper = new QueryWrapper();
        DataVO dataVO = new DataVO();
        dataVO.setCode(0);
        dataVO.setMsg("");

//        dataVO.setCount(goodsMapper.selectCount(null));
        IPage<Goods> goodsIPage = new Page<>(page,limit);
        IPage<Goods> result = goodsMapper.selectPage(goodsIPage,null);

        dataVO.setCount(result.getTotal()); //获取对象总数

//        List<Goods> goodsList = goodsMapper.selectList(null);
        List<Goods> goodsList = result.getRecords();
        List<GoodsVO> goodsVOList = new ArrayList<>();
        for (Goods goods : goodsList) {
            GoodsVO goodsVO = new GoodsVO();
            BeanUtils.copyProperties(goods,goodsVO);
            goodsVOList.add(goodsVO);
        }
        dataVO.setData(goodsVOList);

        return dataVO;
    }

    //插入
    @Override
    public String insertGoods(Goods goods) {
        goodsMapper.insertGoods(goods);
        return "ok";
    }

    //删除
    @Override
    public AjaxRes delGoods(Integer goodId) {
        AjaxRes ajaxRes = new AjaxRes();
        try {
            goodsMapper.delGoods(goodId);
            ajaxRes.setMsg("删除信息成功");
            ajaxRes.setSuccess(true);
        } catch (Exception e) {
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("删除信息失败");
        }
        return ajaxRes;
    }

    //批量删除
    @Override
    public AjaxRes delAllGoods(List<String> delList) {
        AjaxRes ajaxRes = new AjaxRes();
        try {
            goodsMapper.delAllGoods(delList);
            ajaxRes.setMsg("删除商品成功");
            ajaxRes.setSuccess(true);
        } catch (Exception e) {
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("删除商品失败");
        }
        return ajaxRes;
    }

    //更新
    @Override
    public String updateGoods(Goods goods) {
        goodsMapper.updateGoods(goods);
        return "ok";
    }

    //模糊查询
    @Override
    public DataVO<GoodsVO> queryGoods(Integer page, Integer limit, String title) {
        findData(page,limit);
//        goodsMapper.queryGoods(title);
        return null;
    }

    //模糊查询
    @Override
    public void findGoodsByTitle(String title) {
//        goodsMapper.queryGoods(title);
    }


}
