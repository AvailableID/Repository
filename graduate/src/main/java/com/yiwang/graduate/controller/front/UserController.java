package com.yiwang.graduate.controller.front;

import com.yiwang.graduate.common.Result;
import com.yiwang.graduate.domain.AjaxRes;
import com.yiwang.graduate.entity.User;
import com.yiwang.graduate.mapper.UserMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class UserController {
    @Resource
    private UserMapper userMapper;

    @GetMapping("/userlogin")
    public String userlogin(String userlogin){
        return userlogin;
    }

    @RequestMapping(value = "/userlogout",method = RequestMethod.GET)
    public String userlogout(HttpSession session){
//        User dbUser = userMapper.findByUserNameAndPassword(user.getUserName(),user.getPassword());
//        if (dbUser == null){
//            return Result.error("-1","账号或密码错误");
//        }
        session.invalidate();
        return "redirect:/goods?gid=888";
    }

    @GetMapping("/register")
    public String register(){
        return "register";
    }


// -----------------------------------------json数据接口---------------------------------------------------

    //登录
    @ResponseBody
    @PostMapping("/userlogindata")
    public Result<User> userlogindata(@RequestBody User user, HttpSession session){
        User dbUser = userMapper.findByUserNameAndPassword(user.getUserName(),user.getPassword());
        if (dbUser == null){
            return Result.error("-1","账号或密码错误");
        }
        session.setAttribute("username",user.getUserName());
        session.setAttribute("mobile", dbUser.getMobile());
        session.setAttribute("address",dbUser.getAddress());
        return Result.success(dbUser);
    }

    //注册数据
    @ResponseBody
    @PostMapping("/registerdata")
    public boolean registerdata(User user) {
        Integer i = userMapper.userRegister(user);
        if (i>0){
            return true;
        }
        return false;
    }

    //注册blur检测
    @ResponseBody
    @PostMapping("/registerblur")
    public boolean registerblur(String username) {
        User userByName = userMapper.findUserByName(username);
        if (userByName==null){
            return true;
        }else{
            return false;
        }
    }
}
