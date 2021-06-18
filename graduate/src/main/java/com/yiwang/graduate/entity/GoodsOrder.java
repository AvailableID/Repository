package com.yiwang.graduate.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class GoodsOrder implements Serializable {
    private Integer orderId;
    private Integer goodsId;
    private String orderNo;
    private Integer orderStatus;
    private String userid;
//    private String userName;
    private Date createTime;


    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public Integer getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(Integer orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

//    public String getUsername() {
//        return userName;
//    }
//
//    public void setUsername(String username) {
//        this.userName = username;
//    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

}
