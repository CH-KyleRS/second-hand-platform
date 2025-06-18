package com.ncwuhe.service;

import com.ncwuhe.entity.Collect;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ncwuhe.mapper.CollectMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class CollectService extends ServiceImpl<CollectMapper, Collect> {

    @Resource
    private CollectMapper collectMapper;

}
