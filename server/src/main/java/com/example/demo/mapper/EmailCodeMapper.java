package com.example.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.pojo.EmailCode;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 *  邮箱验证码Mapper 接口
 */
@Mapper
public interface EmailCodeMapper extends BaseMapper<EmailCode> {

    void disableEmailCode(@Param("email") String email);
}
