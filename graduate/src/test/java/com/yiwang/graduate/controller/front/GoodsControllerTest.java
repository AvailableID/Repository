package com.yiwang.graduate.controller.front;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest

class GoodsControllerTest {
@Resource
private GoodsController goodsController;
    @Test
    void showGoods() {
        goodsController.showGoods(960);
    }
}