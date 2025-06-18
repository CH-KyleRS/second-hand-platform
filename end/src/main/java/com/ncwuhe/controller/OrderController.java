package com.ncwuhe.controller;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.lang.TypeReference;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.auth0.jwt.JWT;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ncwuhe.common.Result;
import com.ncwuhe.dto.PreOrderQo;
import com.ncwuhe.entity.*;
import com.ncwuhe.exception.CustomException;
import com.ncwuhe.service.*;
import org.json.JSONException;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/order")
public class OrderController {
    @Resource
    private OrderService orderService;
    @Resource
    private HttpServletRequest request;
    @Resource
    private UserService userService;
    @Resource
    private CartService cartService;
    @Resource
    private OrderGoodsService orderGoodsService;
    @Resource
    private GoodsService goodsService;

    public User getUser() {
        String token = request.getHeader("token");
        String username = JWT.decode(token).getAudience().get(0);
        return userService.getOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, username));
    }

    @Transactional
    @PostMapping
    public Result<?> save(@RequestBody Order order) {
        order.setUserId(getUser().getId());
        order.setOrderNo(DateUtil.format(new Date(), "yyyyMMddHHmmss") + RandomUtil.randomNumbers(6));
        order.setCreateTime(DateUtil.now());
        String cartsStr = order.getCarts();
        List<Cart> carts = JSONUtil.toBean(cartsStr, new TypeReference<List<Cart>>() {
        }, true);
        orderService.save(order);

        for (Cart cart : carts) {
            Integer count = cart.getCount();
            Long goodsId = cart.getGoodsId();
            // 扣库存
            Goods goods = goodsService.getById(goodsId);
            if(goods.getStore() - cart.getCount() < 0) {
                throw new CustomException("-1", "库存不足");
            }
            goods.setStore(goods.getStore() - cart.getCount());
            goods.setSales(goods.getSales() + cart.getCount());
            goodsService.updateById(goods);
            OrderGoods orderGoods = new OrderGoods();
            orderGoods.setOrderId(order.getId());
            orderGoods.setGoodsId(goodsId);
            orderGoods.setCount(count);
            orderGoodsService.save(orderGoods);
        }

        if (order.getType() == 1) {  // 1表示购物车，0表示直接购买
            // 提交订单时清空个人的购物车商品
            cartService.remove(Wrappers.<Cart>lambdaUpdate().eq(Cart::getUserId, getUser().getId()));
        }

        return Result.success(order);
    }

    @PutMapping
    public Result<?> update(@RequestBody Order order) {
        orderService.updateById(order);
        return Result.success();
    }


    @Transactional
    @PutMapping("/pay/{id}")
    public Result<?> pay(@PathVariable Long id) {
        Order order = orderService.getById(id);
        BigDecimal totalPrice = order.getTotalPrice();

        Long userId = getUser().getId();
        User user = userService.findById(userId);


        user.setAccount(user.getAccount().subtract(totalPrice));
        userService.updateById(user);
        order.setState("待发货");
        orderService.updateById(order);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        orderService.removeById(id);
        return Result.success();
    }


    @PostMapping("/pre")
    public Result<?> pre(@RequestBody PreOrderQo preOrderQo) throws JSONException {
        String cartsStr = preOrderQo.getCarts();
        // 讲前台传来的json字符串转换成 list对象
        List<Cart> carts = JSONUtil.toBean(cartsStr, new TypeReference<List<Cart>>() {
        }, true);
        Map<String, Object> all = cartService.findAll(carts);
        return Result.success(all);
    }

    @GetMapping("/{id}")
    public Result<?> findById(@PathVariable Long id) {
        return Result.success(orderService.getById(id));
    }

    @GetMapping
    public Result<?> findAll() {
        List<Order> list = orderService.list();
        return Result.success(list);
    }

    @GetMapping("/page")
    public Result<?> findPage(@RequestParam(required = false, defaultValue = "") String name,//模糊查询 默认返回值
                              @RequestParam(required = false, defaultValue = "1") Integer pageNum,
                              @RequestParam(required = false, defaultValue = "10") Integer pageSize) {
        LambdaQueryWrapper<Order> query = Wrappers.<Order>lambdaQuery().orderByAsc(Order::getId);
        //使用orderByDesc(Order::getId)方法对查询结果进行降序排序，根据Order实体类的id字段进行排序。这段代码的作用是创建一个查询条件对象，查询Order实体类的数据，并按照id字段降序排序。
        if (StrUtil.isNotBlank(name)) {
            query.like(Order::getOrderNo, name);
        }
        IPage<Order> page = orderService.page(new Page<>(pageNum, pageSize), query);
        return Result.success(page);
    }


    @GetMapping("/page/front")
    public Result<?> findPageFront(@RequestParam(required = false, defaultValue = "") String state,
                                   @RequestParam(required = false, defaultValue = "1") Integer pageNum,
                                   @RequestParam(required = false, defaultValue = "10") Integer pageSize) {
        LambdaQueryWrapper<Order> query = Wrappers.<Order>lambdaQuery().orderByDesc(Order::getId);
        query.eq(Order::getUserId, getUser().getId());
        // 根据状态查询
        if (StrUtil.isNotBlank(state)) {
            query.eq(Order::getState, state);
        }
        IPage<Order> page = orderService.page(new Page<>(pageNum, pageSize), query);// 执行分页查询，获取对应页数和页面大小的订单数据。

        for (Order order : page.getRecords()) {//遍历了查询结果中的每个订单，并为每个订单查询了与之关联的购物车数据。
            Long orderId = order.getId();
            List<Cart> carts = orderGoodsService.findByOrderId(orderId);
            order.setCarts(JSONUtil.toJsonStr(carts));
        }
        return Result.success(page);
    }

}
