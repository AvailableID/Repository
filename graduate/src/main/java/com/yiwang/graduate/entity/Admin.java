package com.yiwang.graduate.entity;

import lombok.Data;

import java.io.Serializable;

@Data
public class Admin {
    private Integer adminId;
    private String adminName;
    private String password;

}
