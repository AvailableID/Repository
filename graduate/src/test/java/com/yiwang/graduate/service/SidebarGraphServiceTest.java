package com.yiwang.graduate.service;

import com.yiwang.graduate.vo.BarGraphVO;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class SidebarGraphServiceTest {
@Resource
private SidebarGraphService sidebarGraphService;
    @Test
    void getBarGraphVO() {
        BarGraphVO barGraphVO = sidebarGraphService.getBarGraphVO();
        int i = 0;
    }
}