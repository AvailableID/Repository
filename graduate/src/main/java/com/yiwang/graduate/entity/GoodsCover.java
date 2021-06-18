package com.yiwang.graduate.entity;

import com.baomidou.mybatisplus.annotation.TableId;

import java.io.Serializable;

public class GoodsCover implements Serializable{

    private Long gcId;
    private Long goodsId;
    private String gcPicUrl;
    private Long gcOrder;

    public Long getGcId() {
        return gcId;
    }

    public void setGcId(Long gcId) {
        this.gcId = gcId;
    }

    public Long getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Long goodsId) {
        this.goodsId = goodsId;
    }

    public String getGcPicUrl() {
        return gcPicUrl;
    }

    public void setGcPicUrl(String gcPicUrl) {
        this.gcPicUrl = gcPicUrl;
    }

    public Long getGcOrder() {
        return gcOrder;
    }

    public void setGcOrder(Long gcOrder) {
        this.gcOrder = gcOrder;
    }


}
