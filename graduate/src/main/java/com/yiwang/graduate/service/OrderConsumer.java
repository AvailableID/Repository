package com.yiwang.graduate.service;

import com.rabbitmq.client.Channel;
import com.yiwang.graduate.entity.GoodsOrder;
import com.yiwang.graduate.mapper.OrderMapper;
import org.springframework.amqp.rabbit.annotation.*;
import org.springframework.amqp.support.AmqpHeaders;
import org.springframework.messaging.handler.annotation.Headers;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Component;
import javax.annotation.Resource;
import java.io.IOException;
import java.util.Date;
import java.util.Map;


@Component
public class OrderConsumer {
    @Resource
    private OrderMapper orderMapper;
    @RabbitListener(
            bindings = @QueueBinding(
                    value = @Queue(value = "queue-order") ,
                    exchange = @Exchange(value = "exchange-order" , type = "fanout")
            )
    )
    @RabbitHandler             //recognice and convert to map obj
    public void handleMessage(@Payload Map data , Channel channel ,@Headers Map<String,Object> headers){   //aisle obj、mes header
//        System.out.println("=======获取到订单数据:" + data + "===========);");
        try {
            //对接支付宝、对接物流系统、日志登记。。。。
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            GoodsOrder goodsOrder = new GoodsOrder();
            goodsOrder.setOrderNo(data.get("orderNo").toString());
            goodsOrder.setOrderStatus(1);
            goodsOrder.setGoodsId(Integer.valueOf(data.get("goodsid").toString()));
            goodsOrder.setUserid(data.get("userid").toString());
            goodsOrder.setCreateTime(new Date());
            orderMapper.insertOrder(goodsOrder);
            Long tag = (Long)headers.get(AmqpHeaders.DELIVERY_TAG);
            channel.basicAck(tag , false);//(acquire cur obj id、bulk rev)
            System.out.println(data.get("orderNo") + "订单已创建");
            System.out.println();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
