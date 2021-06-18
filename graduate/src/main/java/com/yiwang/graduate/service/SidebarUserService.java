package com.yiwang.graduate.service;

import com.yiwang.graduate.domain.AjaxRes;
import com.yiwang.graduate.entity.Goods;
import com.yiwang.graduate.entity.User;
import com.yiwang.graduate.vo.DataVO;
import com.yiwang.graduate.vo.UserVO;

import java.util.List;

public interface SidebarUserService {
    DataVO<UserVO> findData(Integer page, Integer limit);
    void insertUser(User user);
    AjaxRes delUser(Integer userId);
    void updateUser(User user);
    AjaxRes delAllUser(List<String> delList);
}
