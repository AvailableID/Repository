package com.yiwang.graduate.controller.front;

import com.yiwang.graduate.entity.Goods;
import com.yiwang.graduate.entity.GoodsOrder;
import com.yiwang.graduate.mapper.GoodsMapper;
import com.yiwang.graduate.service.PromotionService;
import com.yiwang.graduate.service.exception.SecKillException;
import com.yiwang.graduate.service.impl.GoodsServiceImpl;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import javax.annotation.Resource;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class GoodsController {
    Map getgid = new HashMap();
    @Resource
    private Configuration freemarkerConfig;
    @Resource
    private GoodsServiceImpl goodsService;
    @Resource
    private PromotionService promotionService;
    @Resource
    private GoodsMapper goodsMapper;


    @GetMapping("/goods")
    @ResponseBody
    public ModelAndView showGoods(Integer gid){
        ModelAndView mav = new ModelAndView("/goods");
        mav.addObject("goods",goodsService.getGoods(gid));
        mav.addObject("covers",goodsService.findCovers(gid));
        mav.addObject("details",goodsService.findDetails(gid));
        mav.addObject("params",goodsService.findParams(gid));
//        mav.addObject("promotion",goodsService.findSecGoodsId(gid));
        getgid.put("value",gid);
        return mav;
    }

    @GetMapping("/checkorder")
    @ResponseBody
    public ModelAndView checkOrder(String orderNo){
        GoodsOrder goodsOrder =  promotionService.checkOrder(orderNo);
        ModelAndView mav = new ModelAndView();
        if(goodsOrder != null){
            mav.addObject("order", goodsOrder);
            mav.setViewName("/order");
            mav.addObject("goods",goodsService.getGoods((Integer) getgid.get("value")));
            mav.addObject("covers",goodsService.findCovers((Integer) getgid.get("value")));
        }else{
            mav.addObject("orderNo", orderNo);
            mav.setViewName("/waiting");
        }
        return mav;
    }

    @GetMapping("/static_all")
    @ResponseBody
    public String doStaticAll() throws IOException, TemplateException {
        Template template = freemarkerConfig.getTemplate("goodsTable.ftl");
        List<Goods> allGoods = goodsService.findAllGoods();
        for (Goods g: allGoods) {
            Integer gid = g.getGoodsId();
            Map param = new HashMap();
            param.put("goods", goodsService.getGoods(gid));
            param.put("covers", goodsService.findCovers(gid));
            param.put("details", goodsService.findDetails(gid));
            param.put("params", goodsService.findParams(gid));
            File targetfile = new File("C:\\Users\\admin\\Desktop\\graduate\\html\\" + gid + ".html");
            FileWriter out = new FileWriter(targetfile);
            template.process(param,out);
            out.close();
        }
        return "ok";
    }

    @GetMapping("/seckill")
    @ResponseBody
    public Map processSecKill(Integer goodsid , String username){
        Map result = new HashMap();
        try {
            promotionService.processSecKill(goodsid , username);    //pop from redis
            String orderNo = promotionService.sendOrderToQueue(goodsid,username);
            Map data = new HashMap();
            data.put("orderNo", orderNo);
            result.put("code", "0");
            result.put("message", "success");
            result.put("data", data);
        } catch (SecKillException e) {
            result.put("code", "500");
            result.put("message", e.getMessage());
        }
        return result;
    }

    @GetMapping("/purchase")
    @ResponseBody
    public Map purchase(Integer goodsid,String username){
        Map result = new HashMap();
        try {
            String orderNo = promotionService.sendOrderToQueue(goodsid,username);
            Map data = new HashMap();
            data.put("orderNo", orderNo);
            result.put("code", "0");
            result.put("message", "success");
            result.put("data", data);
        }catch(Exception e) {
            result.put("code", "500");
            result.put("message", e.getMessage());
        }
        return result;
    }

    @RequestMapping(value ="/decrease",method = RequestMethod.GET)
    @ResponseBody
    public void decrease(Integer goodsid,String username){
        goodsService.decrease(goodsid,username);
    }
}
