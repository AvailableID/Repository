package com.yiwang.graduate.vo;

import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class GoodsVO {
    private Integer goodsId;
    private String title;
    private String subTitle;
    private Float originalCost;
    private Float currentPrice;
    private Integer stock;
    private Integer status;
}

