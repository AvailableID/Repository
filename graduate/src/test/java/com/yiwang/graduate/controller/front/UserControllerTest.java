package com.yiwang.graduate.controller.front;

import com.yiwang.graduate.entity.User;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class UserControllerTest {

    @Resource
    private UserController userController;
//    @Test
//    void registerdata() {
//        User user = new User();
//        user.setUserName("王五");
//        user.setPassword("wangwu");
//        user.setGender("男");
//        user.setAddress("河北");
//        user.setMobile("159");
//        userController.registerdata(user);
//    }
}