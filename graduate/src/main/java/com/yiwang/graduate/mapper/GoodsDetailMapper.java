package com.yiwang.graduate.mapper;



import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yiwang.graduate.entity.GoodsDetail;

import java.util.List;

public interface GoodsDetailMapper extends BaseMapper<GoodsDetail> {
    List<GoodsDetail> findByGoodsId(Integer goodsId);
}
