package com.ncwuhe.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ncwuhe.entity.User;

public interface UserMapper extends BaseMapper<User> {
    String getNicknameByUsername(String username);
}
