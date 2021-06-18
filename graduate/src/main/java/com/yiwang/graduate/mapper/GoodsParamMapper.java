package com.yiwang.graduate.mapper;



import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yiwang.graduate.entity.GoodsParam;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface GoodsParamMapper extends BaseMapper<GoodsParam> {
    List<GoodsParam> findByGoodsId(Integer goodsId);
}
