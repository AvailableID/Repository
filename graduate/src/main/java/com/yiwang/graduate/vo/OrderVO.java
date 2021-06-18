package com.yiwang.graduate.vo;

import lombok.Data;

import java.util.Date;

@Data
public class OrderVO {
    private Integer orderId;
    private Integer goodsId;
    private String title;
    private String orderNo;
    private Integer orderStatus;
    private String userid;
    private String userName;
    private Date createTime;
}

