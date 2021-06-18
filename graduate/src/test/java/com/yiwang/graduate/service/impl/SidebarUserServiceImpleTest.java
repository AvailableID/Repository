package com.yiwang.graduate.service.impl;

import com.yiwang.graduate.entity.User;
import com.yiwang.graduate.mapper.UserMapper;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class SidebarUserServiceImpleTest {
@Resource
private UserMapper userMapper;

    @Test
    void addUser() {
        User user = new User();
        user.setUserid(12);
        user.setUserName("user012");
        user.setPassword("user012");
        user.setGender("女");
        user.setAddress("河南省");
        user.setMobile("15993039089");
        user.setEmail("");
        userMapper.insert(user);
    }
}