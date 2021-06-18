package com.yiwang.graduate.service.impl;
import com.yiwang.graduate.entity.*;
import com.yiwang.graduate.mapper.*;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

@Service
public class GoodsServiceImpl{
    @Resource
    private GoodsMapper goodsMapper;
    @Resource
    private GoodsCoverMapper goodsCoverMapper;
    @Resource
    private GoodsDetailMapper goodsDetailMapper;
    @Resource
    private GoodsParamMapper goodsParamMapper;

//    @Cacheable(value = "goods",key = "#goodsId")
    public Goods getGoods(Integer goodsId){
        return goodsMapper.findById(goodsId);
    }

//    @Cacheable(value = "covers", key = "#goodsId")
    public List<GoodsCover> findCovers(Integer goodsId){
        return goodsCoverMapper.findByGoodsId(goodsId);
    }

//    @Cacheable(value = "details",key = "#goodsId")
    public List<GoodsDetail> findDetails(Integer goodsId){
        return goodsDetailMapper.findByGoodsId(goodsId);
    }

//    @Cacheable(value = "params",key = "#goodsId")
    public List<GoodsParam> findParams(Integer goodsId){
        List list = goodsParamMapper.findByGoodsId(goodsId);
        return list;
    }

    public List<Goods> findAllGoods(){
        return goodsMapper.findAll();
    }

    public void purchase(Integer goodsid,String username) {
        Goods goods = goodsMapper.findById(goodsid);
//        Integer count=goods.getStock();
//        if (count>1){
//            count = count-1;
//            goodsMapper.updateGoods(goods);
//            System.out.println("商品购买成功");
//        }else{
//            System.out.println("商品已售罄");
//        }
    }

    //购买后商品数量减一
    public void decrease(Integer goodsid,String username) {
        Goods goods = goodsMapper.findById(goodsid);
        String title=goods.getTitle();
        String subTitle = goods.getSubTitle();
        Float originalCost = goods.getOriginalCost();
        Float currentPrice = goods.getCurrentPrice();
        Integer status = goods.getStatus();
        Integer stock=goods.getStock();
        if (stock>0){
            stock = stock-1;
            Goods temgoods = new Goods();
            temgoods.setStock(stock);
            temgoods.setGoodsId(goodsid);
            temgoods.setTitle(title);
            temgoods.setSubTitle(subTitle);
            temgoods.setOriginalCost(originalCost);
            temgoods.setCurrentPrice(currentPrice);
            temgoods.setStatus(status);
            goodsMapper.updateGoods(temgoods);
            System.out.println("Mysql:判断数据库中商品数量>0后执行了1次");
        }else{
            System.out.println("Mysql:商品已售罄");
        }
    }

//    public Promotion findSecGoodsId(Integer goodsId){
//        return goodsMapper.findSecGoodsId(goodsId);
//    }
}
