package com.yiwang.graduate.service;

import com.yiwang.graduate.entity.Goods;
import com.yiwang.graduate.entity.GoodsOrder;
import com.yiwang.graduate.entity.User;
import com.yiwang.graduate.mapper.GoodsMapper;
import com.yiwang.graduate.mapper.OrderMapper;
import com.yiwang.graduate.mapper.UserMapper;
import com.yiwang.graduate.service.exception.SecKillException;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.*;


@Service
public class PromotionService {
    @Resource
    private RabbitTemplate rabbitTemplate;
    @Resource
    private GoodsMapper goodsMapper;
    @Resource
    private RedisTemplate redisTemplate;
    @Resource
    private OrderMapper orderMapper;
    @Resource
    private UserMapper userMapper;

    public void processSecKill(Integer goodsid,String username) throws SecKillException {
        Goods goods = goodsMapper.findById(goodsid);    //通过id获取对象
        if (goods == null){
            throw new SecKillException("该商品秒杀活动不存在");
        }if(goods.getStatus() == 0){
            throw new SecKillException("活动还未开始");
        }else if(goods.getStatus() == 2){
            throw new SecKillException("活动已结束");
        }
        Integer temp = (Integer) redisTemplate.opsForList().leftPop("promotion:stock:"+goods.getGoodsId());
        if(temp != null){
            System.out.println("Redis:判断队列商品数量>0后执行了1次");
            redisTemplate.opsForList().leftPush("promotion:record:" + goods.getGoodsId(),username);
//            boolean isExisted = redisTemplate.opsForSet().isMember("seckill:users:" + ps.getPsId(),username);
//            if(!isExisted){
//                System.out.println("恭喜您，抢到商品啦。快去下单吧");
//                redisTemplate.opsForSet().add("seckill:users:" + ps.getPsId(),username);
//            }else{
//                redisTemplate.opsForList().rightPush("seckill:count:" + ps.getPsId(),ps.getGoodsId());
//                throw new SecKillException("抱歉，您已经参加过此活动，请勿重复抢购！");
//            }
        }else{
            throw new SecKillException("Redis:商品已售罄");
        }
    }

    public String sendOrderToQueue(Integer goodsId,String username) {
        //System.out.println("准备向队列发送信息");
        //订单基本信息
        Map data = new HashMap();
        HashSet<Object> objects1 = new HashSet<>();
        data.put("goodsid",null);
        String orderNo = UUID.randomUUID().toString();
        data.put("orderNo", orderNo);
        User user = userMapper.findUserByName(username);
        Integer userid = user.getUserid();
        data.put("userid",userid);
        data.put("username", username);
        //附加额外的订单信息
        rabbitTemplate.convertAndSend("exchange-order" , null , data);  //order configuration info
        return orderNo;
    }

    public GoodsOrder checkOrder(String orderNo){
        GoodsOrder goodsOrder = orderMapper.findByOrderNo(orderNo);
        return goodsOrder;
    }
}
