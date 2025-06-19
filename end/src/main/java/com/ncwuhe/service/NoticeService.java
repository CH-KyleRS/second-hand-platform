package com.ncwuhe.service;

import com.ncwuhe.entity.Notice;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ncwuhe.mapper.NoticeMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class NoticeService extends ServiceImpl<NoticeMapper, Notice> {

    @Resource
    private NoticeMapper noticeMapper;

}
