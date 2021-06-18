package com.yiwang.graduate.config;

import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class MyBatisPlusConfig {
    @Bean   //表示把拦截器存在IOC里
    public PaginationInterceptor paginationInterceptor(){
        return  new PaginationInterceptor();
    }

}
