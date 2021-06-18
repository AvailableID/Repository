package com.yiwang.graduate.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yiwang.graduate.entity.User;

import java.io.Serializable;
import java.util.List;

public interface UserMapper extends BaseMapper<User> {
    User findByUserNameAndPassword(String userName,String password);
    void deleteUserId(Integer userId);
    void updateUser(User user);
    User findUserByName(String username);
    Integer userRegister(User user);
    void delAllUser(List<String> delList);
}
