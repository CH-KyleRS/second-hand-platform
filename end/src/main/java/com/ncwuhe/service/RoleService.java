package com.ncwuhe.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ncwuhe.entity.Role;
import com.ncwuhe.mapper.RoleMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class RoleService extends ServiceImpl<RoleMapper, Role> {

    @Resource
    private RoleMapper roleMapper;

}
