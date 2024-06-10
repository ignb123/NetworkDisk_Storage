package com.example.demo.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.demo.pojo.EmailCode;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author sw-code
 * @since 2023-05-17
 */
public interface EmailCodeService extends IService<EmailCode> {

    void sendEmailCode(String email, Integer type);

    void checkCode(String email, String code);
}
