package com.yiwang.graduate.controller;

import com.yiwang.graduate.service.SidebarGraphService;
import com.yiwang.graduate.vo.BarGraphVO;
import com.yiwang.graduate.vo.PieGraphVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class SidebarBarGraphCtrl {
@Resource
private SidebarGraphService sidebarGraphService;

    @GetMapping("/admin/BarGraphTable")
    public String BarGraphTable(){
        return "admin/BarGraphTable";
    }

    @GetMapping("/admin/PieChartTable")
    public String PieChartTable(){
        return "admin/PieChartTable";
    }

    //-----------------------------------------json数据接口---------------------------------------------------
    @PostMapping("/BarGraphTableData")
    @ResponseBody
    public BarGraphVO BarGraphTableData(){
        return sidebarGraphService.getBarGraphVO();
    }

    @GetMapping("/PieGraphTableData")
    @ResponseBody
    public List<PieGraphVO> PieGraphTableData(){
        return sidebarGraphService.getPieVO();
    }

}
