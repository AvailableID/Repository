package com.yiwang.graduate.controller;

import com.yiwang.graduate.entity.User;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class SidebarUserCtrlTest {
@Resource
private SidebarUserCtrl sidebarUserCtrl;
    @Test
    void delUser() {
        sidebarUserCtrl.delUser(1);
    }

    @Test
    void edit(){
        User user = new User();
        user.setUserid(2);
        user.setUserName("user012");
        user.setPassword("user012");
        user.setGender("女");
        user.setAddress("河南省");
        user.setMobile("15993039089");
        user.setEmail("");
        sidebarUserCtrl.editUser(user);
    }
}