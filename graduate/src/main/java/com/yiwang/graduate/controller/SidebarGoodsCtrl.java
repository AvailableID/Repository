package com.yiwang.graduate.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yiwang.graduate.domain.AjaxRes;
import com.yiwang.graduate.entity.Goods;
import com.yiwang.graduate.mapper.GoodsMapper;
import com.yiwang.graduate.service.SidebarGoodsService;
import com.yiwang.graduate.vo.DataVO;
import com.yiwang.graduate.vo.GoodsVO;
import io.netty.util.internal.StringUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

@Controller
public class SidebarGoodsCtrl {
    @Resource
    private SidebarGoodsService sidebarGoodsService;
    @Resource
    private GoodsMapper goodsMapper;


    //后台主页
    @GetMapping("/admin/index")
    public String index() {
        return "admin/index";
    }

    //侧边栏-商品表
    @GetMapping("/admin/goodsTable")
    public String goodsTable(String goodsTable) {
        return goodsTable;
    }

    //侧边栏-商品表-添加商品表
    @GetMapping("/admin/addGoodsTable")
    public String add(String add) {
        return add;       //1.前面不能加/  2.无参方式不管用
    }

    //侧边栏-商品表-编辑商品表
    @RequestMapping(value = "/admin/editGoodsTable", method = RequestMethod.GET)
    public String edit(String edit) {
        return edit;
    }


//-----------------------------------------json数据接口---------------------------------------------------

    //获取商品数据分页
    @GetMapping("/goodslist")
    @ResponseBody
    public DataVO list(Integer page, Integer limit) {
        return sidebarGoodsService.findData(page, limit);
    }

    //商品查询
    @RequestMapping(value = "/querygoods")
    @ResponseBody
    public DataVO<GoodsVO> queryGoods(@RequestParam(name="key",required = false)String key,
                                      @RequestParam(name = "page",required = false)int page,
                                      @RequestParam(name = "limit",required = false)int limit){

        DataVO dataVO = new DataVO();
        IPage<Goods> goodsIPage = new Page<>(page,limit);
        IPage<Goods> result = goodsMapper.selectPage(goodsIPage,new QueryWrapper<Goods>()
            .like(StringUtils.isNotBlank(key),"title",key)
            .or().like(StringUtils.isNotBlank(key),"goods_id",key)
        );

        dataVO.setData(goodsIPage.getRecords());
        dataVO.setCount(result.getTotal()); //获取对象总数
        dataVO.setCode(0);
        dataVO.setMsg("");
        return dataVO;
    }

    //添加商品
    @PostMapping("/addGoods")
    @Transactional
    public String addGoods(Goods goods) {
        sidebarGoodsService.insertGoods(goods);
        System.out.println(goods);
        return "ok";
    }

    //删除商品
    @PostMapping("/delGoods")
    @ResponseBody
    public AjaxRes delGoods(Integer goodsId) {
        System.out.println(goodsId);
        return sidebarGoodsService.delGoods(goodsId);
    }

    //批量删除商品
    @PostMapping("/delAllGoods")
    @ResponseBody
    public AjaxRes delAllGoods(String goodsId) {
        List<String> delList = new ArrayList<>();
        String[] strs = goodsId.split(",");
        for (String str : strs) {
            delList.add(str);
        }
        return sidebarGoodsService.delAllGoods(delList);
    }

    //编辑商品
    @PostMapping("/editGoods")
    public String editGoods(Goods goods) {
        sidebarGoodsService.updateGoods(goods);
        System.out.println(goods);
        return "ok";
    }

}