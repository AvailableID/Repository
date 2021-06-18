package com.yiwang.graduate.controller;

import com.yiwang.graduate.common.Result;
import com.yiwang.graduate.entity.Admin;
import com.yiwang.graduate.mapper.AdminMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
public class AdminLoginCtrl {
    @Resource
    private AdminMapper adminMapper;

//html页面跳转接口
    @GetMapping("/adminlogin")
    public String adminlogin(){
        return "adminlogin";
    }


    @GetMapping("/adminlogout")
    public String adminlogout(HttpSession session){
        session.invalidate();
        return "redirect:/adminlogin";
    }

//json数据接口
    @ResponseBody
    @PostMapping("/adminlogindata")
    public Result<Admin> adminlogindata(@RequestBody Admin admin,HttpSession session){

        Admin dbAdmin = adminMapper.findByAdminNameAndPassword(admin.getAdminName(),admin.getPassword());
        if (dbAdmin == null){
            return Result.error("-1","账号或密码错误");
        }
        session.setAttribute("loginAdmin",admin);
        return Result.success(dbAdmin);
    }

}
