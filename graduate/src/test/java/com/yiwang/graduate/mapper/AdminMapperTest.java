package com.yiwang.graduate.mapper;

import com.yiwang.graduate.entity.Admin;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import javax.annotation.Resource;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class AdminMapperTest {
    @Resource
    private AdminMapper adminMapper;

    @Test
    void test(){
        adminMapper.findByUserId(1);
    }
}