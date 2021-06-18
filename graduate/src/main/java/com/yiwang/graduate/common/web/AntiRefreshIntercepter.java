//package com.yiwang.graduate.common.web;//package com.yi.demo.common.web;
//
//import org.springframework.data.redis.core.RedisTemplate;
//import org.springframework.stereotype.Component;
//import org.springframework.web.servlet.HandlerInterceptor;
//import javax.annotation.Resource;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.util.concurrent.TimeUnit;
//
//@Component
//public class AntiRefreshIntercepter implements HandlerInterceptor {
//    @Resource
//    private RedisTemplate<String,Object> redisTemplate;
//    @Override
//    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//        System.out.println("----------商品页面执行拦截器执行1次-------------");
//        String clientIP = request.getRemoteAddr();//获取地址
//        String userAgent = request.getHeader("user-Agent");
//        String key = userAgent;
//        Integer num = (Integer)redisTemplate.opsForValue().get(key);//ip作为Key保存
//        response.setContentType("text/html;charset=utf-8");
//
//        if(redisTemplate.hasKey("anti:refresh:blacklist")){
//            if (redisTemplate.opsForSet().isMember("anti:refresh:blacklist",key)){
//                response.getWriter().print("检测到您的IP访问异常，已被加入黑名单");
//                return false;
//            }
//        }
//
//        if(num == null){
//            redisTemplate.opsForValue().set(key,1,60, TimeUnit.SECONDS);//init,ttl
//        }else{          //不是第一次访问
//            if(num > 15 && num < 25){
//                response.getWriter().print("请求过于频繁，请稍后再试");
//                redisTemplate.opsForValue().increment(key,1);
//                return false;
//            }else if(num >= 25){
//                response.getWriter().print("检测到您的IP 访问异常，已被加入黑名单");
//                redisTemplate.opsForSet().add("anti:refresh:blacklist",key);
//                return false;
//            }else {
//                redisTemplate.opsForValue().increment(key,1);
//            }
//        }
//        return true;
//    }
//}
