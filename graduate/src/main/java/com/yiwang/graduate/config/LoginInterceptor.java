package com.yiwang.graduate.config;

import com.yiwang.graduate.entity.Admin;
import org.springframework.web.servlet.HandlerInterceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Admin admin = (Admin) request.getSession().getAttribute("loginAdmin");
        if (admin == null) {
            request.getRequestDispatcher("/adminlogin").forward(request, response);
            return true;
        } else {
            return true;
        }
    }
}
