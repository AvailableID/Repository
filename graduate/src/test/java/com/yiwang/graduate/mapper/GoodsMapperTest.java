package com.yiwang.graduate.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.yiwang.graduate.entity.Goods;
import com.yiwang.graduate.vo.GoodsBarGraphVO;
import com.yiwang.graduate.vo.GoodsVO;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class GoodsMapperTest {
    @Resource
    private GoodsMapper mapper;
    @Test
    void del(){
        mapper.delGoods(930);
    }



    @Test
    void vo(){
        List<GoodsBarGraphVO> list = mapper.findAllGoodsBarGraphVO();
        int i = 0;
    }
}