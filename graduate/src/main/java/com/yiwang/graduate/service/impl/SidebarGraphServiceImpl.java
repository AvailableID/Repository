package com.yiwang.graduate.service.impl;

import com.yiwang.graduate.mapper.GoodsMapper;
import com.yiwang.graduate.service.SidebarGraphService;
import com.yiwang.graduate.vo.BarGraphVO;
import com.yiwang.graduate.vo.GoodsBarGraphVO;
import com.yiwang.graduate.vo.PieGraphVO;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class SidebarGraphServiceImpl implements SidebarGraphService {
    @Resource
    private GoodsMapper goodsMapper;

    @Override
    public BarGraphVO getBarGraphVO() {
        List<GoodsBarGraphVO> list = goodsMapper.findAllGoodsBarGraphVO();
        List<String> title = new ArrayList<>();
        List<Integer> values = new ArrayList<>();
        for (GoodsBarGraphVO goodsBarGraphVO : list) {
            title.add(goodsBarGraphVO.getTitle());
            values.add(goodsBarGraphVO.getCount());
        }
        BarGraphVO barVO = new BarGraphVO();
        barVO.setTitle(title);
        barVO.setValues(values);
        return barVO;
    }

    @Override
    public List<PieGraphVO> getPieVO() {
        List<GoodsBarGraphVO> list = goodsMapper.findAllGoodsBarGraphVO();
        List<PieGraphVO> pieGraphVOList = list.stream()
                .map(e -> new PieGraphVO(   //λ表达式
                        e.getCount().intValue(),
                        e.getTitle()
                )).collect(Collectors.toList());
        return pieGraphVOList;
    }
}
