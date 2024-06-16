package com.example.demo.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.demo.entity.vo.FileShareVo;
import com.example.demo.pojo.FileShare;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author sw-code
 * @since 2023-07-14
 */

public interface FileShareService extends IService<FileShare> {
    IPage<FileShareVo> pageInfo(Page<FileShare> pageParam, String userId);

    FileShare saveShare(FileShare fileShare);

    void deleteShareBatch(String shareIds, String userId);
}
