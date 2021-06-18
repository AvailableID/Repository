package com.yiwang.graduate.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.yiwang.graduate.entity.User;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class UserMapperTest {
    @Resource
    private UserMapper userMapper;

    @Test
    void test() {
        QueryWrapper wrapper = new QueryWrapper();
        wrapper.eq("userid",2);
        System.out.println(userMapper.selectOne(wrapper));
    }

    @Test
    void delUser() {
//        User user = new User();
//        user.setUserid(12);
//        user.setUserName("user012");
//        user.setPassword("user012");
//        user.setGender("女");
//        user.setAddress("河南省");
//        user.setMobile("15993039089");
//        user.setEmail("");
//        userMapper.addUser(user);
        userMapper.deleteUserId(13);
    }

    @Test
    void findUserByName() {
        userMapper.findUserByName("user004");
    }

    @Test
    void userRegister() {
        User user = new User();
        user.setUserName("王五");
        user.setPassword("wangwu");
        user.setGender("男");
        user.setAddress("河南省");
        user.setMobile("15993039089");
        user.setEmail("1157923342@qq.com");
        userMapper.userRegister(user);
    }
}