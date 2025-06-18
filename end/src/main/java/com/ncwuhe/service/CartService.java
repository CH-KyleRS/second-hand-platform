package com.ncwuhe.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ncwuhe.entity.Cart;
import com.ncwuhe.entity.Goods;
import com.ncwuhe.mapper.CartMapper;
import org.json.JSONException;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CartService extends ServiceImpl<CartMapper, Cart> {

    @Resource
    private GoodsService goodsService;

    /**
     * 计算购物车商品总价和优惠金额
     * @param carts
     * @return
     * @throws JSONException
     */
    public Map<String, Object> findAll(List<Cart> carts) throws JSONException {
        if (carts == null) {
            carts = new ArrayList<>();
        }
        
        BigDecimal totalPrice = new BigDecimal(0);
        BigDecimal originPrice = new BigDecimal(0);
        Map<String, Object> res = new HashMap<>();

        for (Cart cart : carts) {
            if (cart == null || cart.getGoodsId() == null) {
                continue;
            }
            
            Long goodsId = cart.getGoodsId();
            Goods goods = goodsService.getById(goodsId);
            if (goods == null || goods.getPrice() == null || goods.getDiscount() == null) {
                continue;
            }
            
            goods.setRealPrice(goods.getPrice().multiply(BigDecimal.valueOf(goods.getDiscount())));
            cart.setGoods(goods);

            totalPrice = totalPrice.add(goods.getRealPrice().multiply(BigDecimal.valueOf(cart.getCount())));
            originPrice = originPrice.add(goods.getPrice().multiply(BigDecimal.valueOf(cart.getCount())));
        }

        res.put("list", carts);  // 购物车列表
        res.put("totalPrice", totalPrice);  // 总价
        res.put("discount", originPrice.subtract(totalPrice));    // 折扣优惠金额
        return res;
    }
}
