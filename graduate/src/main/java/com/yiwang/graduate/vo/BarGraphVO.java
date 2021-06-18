package com.yiwang.graduate.vo;

import lombok.Data;

import java.util.List;
@Data
public class BarGraphVO {
    private List<String> title;
    private List<Integer> values;
}
