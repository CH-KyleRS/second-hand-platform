package com.ncwuhe.controller;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import com.auth0.jwt.JWT;
import com.ncwuhe.common.Result;
import com.ncwuhe.exception.CustomException;
import com.ncwuhe.service.UserService;
import com.ncwuhe.entity.Collect;
import com.ncwuhe.service.CollectService;
import com.ncwuhe.entity.User;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping("/api/collect")
public class CollectController {
    @Resource
    private CollectService collectService;
    @Resource
    private HttpServletRequest request;
    @Resource
    private UserService userService;

    public User getUser() {
        String token = request.getHeader("token");
        String username = JWT.decode(token).getAudience().get(0);
        return userService.getOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, username));
    }

    @PostMapping
    public Result<?> save(@RequestBody Collect collect) {
        List<Collect> list = collectService.list(Wrappers.<Collect>lambdaQuery().eq(Collect::getGoodsId, collect.getGoodsId())
                .eq(Collect::getUserId, getUser().getId()));
        if (CollUtil.isNotEmpty(list)) {
            throw new CustomException("-1", "您已收藏该商品");
        }
        collect.setCreateTime(DateUtil.now());
        collectService.save(collect);
        return Result.success();
    }

    @PutMapping
    public Result<?> update(@RequestBody Collect collect) {
        collectService.updateById(collect);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        collectService.removeById(id);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result<?> findById(@PathVariable Long id) {
        return Result.success(collectService.getById(id));
    }

    @GetMapping
    public Result<?> findAll() {
        List<Collect> list = collectService.list();
        return Result.success(list);
    }

    @GetMapping("/page")
    public Result<?> findPage(@RequestParam(required = false, defaultValue = "") String name,
                              @RequestParam(required = false, defaultValue = "1") Integer pageNum,
                              @RequestParam(required = false, defaultValue = "10") Integer pageSize) {
        LambdaQueryWrapper<Collect> query = Wrappers.<Collect>lambdaQuery().orderByDesc(Collect::getId);
        IPage<Collect> page = collectService.page(new Page<>(pageNum, pageSize), query);
        return Result.success(page);
    }

    @GetMapping("/page/front")
    public Result<?> findPageFront(@RequestParam(required = false, defaultValue = "") String name,
                                                @RequestParam(required = false, defaultValue = "1") Integer pageNum,
                                                @RequestParam(required = false, defaultValue = "10") Integer pageSize) {
        User user = getUser();
        if (user == null) {
            return Result.success(new Page<>());
        }
        LambdaQueryWrapper<Collect> query = Wrappers.<Collect>lambdaQuery().eq(Collect::getUserId, getUser().getId()).orderByDesc(Collect::getId);
        IPage<Collect> page = collectService.page(new Page<>(pageNum, pageSize), query);
        return Result.success(page);
    }

}
