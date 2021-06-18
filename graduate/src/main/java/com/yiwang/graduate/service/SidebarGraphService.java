package com.yiwang.graduate.service;

import com.yiwang.graduate.vo.BarGraphVO;
import com.yiwang.graduate.vo.PieGraphVO;

import java.util.List;

public interface SidebarGraphService {
    BarGraphVO getBarGraphVO();
    List<PieGraphVO> getPieVO();
}
