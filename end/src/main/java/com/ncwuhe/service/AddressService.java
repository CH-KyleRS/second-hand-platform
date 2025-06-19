package com.ncwuhe.service;

import com.ncwuhe.entity.Address;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ncwuhe.mapper.AddressMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AddressService extends ServiceImpl<AddressMapper, Address> {

    @Resource
    private AddressMapper addressMapper;

}
