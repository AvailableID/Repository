package com.yiwang.graduate.schedule;

import com.yiwang.graduate.entity.Goods;
import com.yiwang.graduate.entity.Promotion;
import com.yiwang.graduate.mapper.GoodsMapper;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import javax.annotation.Resource;
import java.util.List;

@Component
public class SecKillTask {
    @Resource
    private RedisTemplate redisTemplate;
    @Resource
    private GoodsMapper goodsMapper;
    @Scheduled(cron = "0/5 * * * * ?")
    public void startSecKill(){
        List<Goods> list = goodsMapper.searchPromotion();
        for (Goods goods:list) {
            //删除掉之前重复的活动缓存
            redisTemplate.delete("promotion:stock:" + goods.getGoodsId());
            for(int i = 0 ; i < goods.getStock() ; i++){
                redisTemplate.opsForList().rightPush("promotion:stock:"+goods.getGoodsId(), goods.getGoodsId());
            }
            goods.setStatus(1);
            goodsMapper.updateGoods(goods);
            System.out.println(goods.getGoodsId()+"号商品已存入Redis预防超卖队列!");
        }
    }
}
