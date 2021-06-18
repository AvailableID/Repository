package com.yiwang.graduate.mapper;

import com.yiwang.graduate.entity.Admin;

public interface AdminMapper {
    Admin  findByUserId(Integer adminId);
    Admin findByAdminNameAndPassword(String adminName, String password);
}
