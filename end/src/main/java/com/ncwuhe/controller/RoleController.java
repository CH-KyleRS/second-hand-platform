package com.ncwuhe.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ncwuhe.common.Result;
import com.ncwuhe.entity.Role;
import com.ncwuhe.service.LogService;
import com.ncwuhe.service.RoleService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/api/role")
public class RoleController {
    @Resource
    private RoleService roleService;
    @Resource
    private LogService logService;

    @PostMapping
    public Result<?> save(@RequestBody Role role) {
        logService.log(StrUtil.format("新增角色：{}", role.getName()));//对角色权限进行更新
        return Result.success(roleService.save(role));
    }

    @PutMapping
    public Result<?> update(@RequestBody Role role) {
        logService.log(StrUtil.format("更新角色：{}", role.getName()));
        return Result.success(roleService.updateById(role));
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        Role role = roleService.getById(id);
        logService.log(StrUtil.format("删除角色：{}", role.getName()));

        roleService.removeById(id);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result<Role> findById(@PathVariable Long id) {
        return Result.success(roleService.getById(id));
    }

    @GetMapping
    public Result<List<Role>> findAll() {
        return Result.success(roleService.list());
    }

    @GetMapping("/page")
    public Result<IPage<Role>> findPage(@RequestParam(required = false, defaultValue = "") String name,
                                        @RequestParam(required = false, defaultValue = "1") Integer pageNum,
                                        @RequestParam(required = false, defaultValue = "10") Integer pageSize) {
        return Result.success(roleService.page(new Page<>(pageNum, pageSize), Wrappers.<Role>lambdaQuery().like(Role::getName, name)));
        //name 参数为空字符串，那么模糊查询将不会对查询结果进行过滤，返回所有的 Role 数据。
    }

}
