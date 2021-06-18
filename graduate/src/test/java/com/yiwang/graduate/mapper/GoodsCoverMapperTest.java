package com.yiwang.graduate.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.yiwang.graduate.entity.Goods;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class GoodsCoverMapperTest {
    @Autowired
    private GoodsMapper goodsMapper ;
    @Test
    void test(){
//        QueryWrapper wrapper = new QueryWrapper();
//        wrapper.eq("goods_id",949);
//        System.out.println(goodsMapper.selectOne(wrapper));
        Goods goods = goodsMapper.findById(949);
    }
}