package com.yiwang.graduate.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yiwang.graduate.domain.AjaxRes;
import com.yiwang.graduate.entity.User;
import com.yiwang.graduate.mapper.UserMapper;
import com.yiwang.graduate.service.SidebarUserService;
import com.yiwang.graduate.vo.DataVO;
import com.yiwang.graduate.vo.UserVO;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class SidebarUserServiceImple implements SidebarUserService {
    @Resource
    private UserMapper userMapper;

    @Override
    public DataVO<UserVO> findData(Integer page, Integer limit) {
        DataVO dataVO = new DataVO();
        dataVO.setCode(0);
        dataVO.setMsg("");
        //dataVO.setCount(Long.valueOf(userMapper.selectCount(null)));//原：查询所有数据的数量
        //分页
        IPage<User> userIPage = new Page<>(page, limit);
        IPage<User> result = userMapper.selectPage(userIPage,null);

        dataVO.setCount(result.getTotal());//分页方法：查询所有数据的数量

        List<User> usersList = result.getRecords();  //分页方法：查询所有数据
        //List<User> usersList = userMapper.selectList(null);    //原：查询所有数据
        List<UserVO> userVOlist = new ArrayList<>();
        for (User user : usersList) {
            UserVO userVO = new UserVO();       //这句不能放在方法体外面
            BeanUtils.copyProperties(user,userVO);
            userVOlist.add(userVO);
        }
        dataVO.setData(userVOlist);
        return dataVO;
    }

    @Override
    public void insertUser(User user) {
        userMapper.insert(user);
    }

    @Override
    public AjaxRes delUser(Integer userId) {
        AjaxRes ajaxRes = new AjaxRes();
        try {
            userMapper.deleteUserId(userId);
            ajaxRes.setMsg("删除信息成功");
            ajaxRes.setSuccess(true);
        } catch (Exception e) {
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("删除信息失败");
        }
        return ajaxRes;
    }

    @Override
    public AjaxRes delAllUser(List<String> delList) {
        AjaxRes ajaxRes = new AjaxRes();

        try {
            userMapper.delAllUser(delList);
            ajaxRes.setMsg("删除用户成功");
            ajaxRes.setSuccess(true);
        } catch (Exception e) {
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("删除用户失败");
        }
        return ajaxRes;
    }

    @Override
    public void updateUser(User user) {
        userMapper.updateUser(user);
    }


}
