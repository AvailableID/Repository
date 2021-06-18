package com.yiwang.graduate.controller;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class SidebarGoodsCtrlTest {
@Resource
private SidebarGoodsCtrl sidebarGoodsCtrl;

    @Test
    void delAllGoods() {
        sidebarGoodsCtrl.delAllGoods("743");
    }

    @Test
    void test2(){
        String a="2";
        double b=2;
        if(a.equals(b)){
            System.out.println("true");
        }else {
            System.out.println("false");
        }
    }
}