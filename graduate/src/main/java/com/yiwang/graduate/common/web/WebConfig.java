//package com.yiwang.graduate.common.web;//package com.yi.demo.common.web;
//
//import org.springframework.context.annotation.Configuration;
//import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//import javax.annotation.Resource;
//
//@Configuration
//public class WebConfig implements WebMvcConfigurer {
//    @Resource
//    private AntiRefreshIntercepter antiRefreshIntercepter;
//
//    @Override
//    public void addInterceptors(InterceptorRegistry registry) {
//        registry.addInterceptor(antiRefreshIntercepter).addPathPatterns("/goods");
//    }
//}
