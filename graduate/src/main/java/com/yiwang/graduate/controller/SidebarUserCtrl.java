package com.yiwang.graduate.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yiwang.graduate.domain.AjaxRes;
import com.yiwang.graduate.entity.Goods;
import com.yiwang.graduate.entity.User;
import com.yiwang.graduate.mapper.UserMapper;
import com.yiwang.graduate.service.SidebarUserService;
import com.yiwang.graduate.vo.DataVO;
import com.yiwang.graduate.vo.GoodsVO;
import com.yiwang.graduate.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Controller
public class SidebarUserCtrl {
    @Resource
    private SidebarUserService sidebarUserService;
    @Resource
    private UserMapper userMapper;

    @GetMapping("/admin/userTable")
    public String userTable(String userTable){
        return userTable;
    }

    //侧边栏-用户表-添加用户表
    @GetMapping("/admin/addUserTable")      //2.无参方式不管用
    public String add(String add) {
        return add;
    }

    //侧边栏-用户表-编辑用户表
    @RequestMapping(value = "/admin/editUserTable", method = RequestMethod.GET)
    public String edit(String edit) {
        return edit;
    }


//-----------------------------------------json数据接口---------------------------------------------------

    //获取用户数据分页
    @GetMapping("/userlist")
    @ResponseBody
    public DataVO list(Integer page, Integer limit) {
        return sidebarUserService.findData(page, limit);
    }

    //商品查询
    @RequestMapping(value = "/queryuser")
    @ResponseBody
    public DataVO<UserVO> queryUser(@RequestParam(name="key",required = false)String key,
                                     @RequestParam(name = "page",required = false)int page,
                                     @RequestParam(name = "limit",required = false)int limit){

        DataVO dataVO = new DataVO();
        IPage<User> userIPage = new Page<>(page,limit);
        IPage<User> result = userMapper.selectPage(userIPage,new QueryWrapper<User>()
                .like(StringUtils.isNotBlank(key),"user_name",key)
                .or().like(StringUtils.isNotBlank(key),"userid",key)
        );

        dataVO.setData(userIPage.getRecords());
        dataVO.setCount(result.getTotal()); //获取对象总数
        dataVO.setCode(0);
        dataVO.setMsg("");
        return dataVO;
    }

    //添加用户
    @PostMapping("/addUser")
    @Transactional
    public String addUser(User user) {
        sidebarUserService.insertUser(user);
        System.out.println(user);
        return "ok";
    }

    //删除用户
    @PostMapping("/delUser")
    @ResponseBody
    public AjaxRes delUser(Integer userId) {
        System.out.println(userId);
        return sidebarUserService.delUser(userId);
    }

    //批量删除用户
    @PostMapping("/delAllUser")
    @ResponseBody
    public AjaxRes delAllUser(String userid) {
        List<String> delList = new ArrayList<>();
        String[] strs = userid.split(",");
        for (String str : strs) {
            delList.add(str);
        }
        return sidebarUserService.delAllUser(delList);
    }

    //编辑商品
    @PostMapping("/editUser")
    public String editUser(User user) {
        sidebarUserService.updateUser(user);
        System.out.println(user);
        return "ok";
    }

}