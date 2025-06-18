package com.ncwuhe.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ncwuhe.entity.Order;
import com.ncwuhe.mapper.OrderMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class OrderService extends ServiceImpl<OrderMapper, Order> {

    @Resource
    private OrderMapper orderMapper;

}
