package com.yiwang.graduate.mapper;



import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yiwang.graduate.entity.GoodsCover;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface GoodsCoverMapper extends BaseMapper<GoodsCover> {
    List<GoodsCover> findByGoodsId(Integer goodsId);

}
