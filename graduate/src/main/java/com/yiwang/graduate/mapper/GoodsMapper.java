package com.yiwang.graduate.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yiwang.graduate.entity.Goods;
import com.yiwang.graduate.entity.Promotion;
import com.yiwang.graduate.vo.GoodsBarGraphVO;
import com.yiwang.graduate.vo.GoodsVO;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GoodsMapper extends BaseMapper<Goods> {
    void delGoods(Integer goodsId);
    void updateGoods(Goods goods);
    void insertGoods(Goods goods);
    //List<GoodsVO> queryGoods(String title);//模糊查询
    Goods findById(Integer goodsid);
    List<Goods> findAll();
    List<Goods> searchPromotion();
    @Select("select gd.title ,SUM(order_status) count from goods_order go,goods gd where go.goods_id=gd.goods_id group by go.goods_id;")
    List<GoodsBarGraphVO> findAllGoodsBarGraphVO();
    void delAllGoods(List<String> delList);
}
