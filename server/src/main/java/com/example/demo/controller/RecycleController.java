package com.example.demo.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.annotation.LoginValidator;
import com.example.demo.common.annotation.ResponseResult;
import com.example.demo.entity.constants.Constants;
import com.example.demo.entity.enums.FileDelFlagEnums;
import com.example.demo.entity.query.FileInfoQuery;
import com.example.demo.entity.vo.FileInfoVO;
import com.example.demo.entity.vo.SessionWebUserVO;
import com.example.demo.pojo.FileInfo;
import com.example.demo.service.FileInfoService;
import com.example.demo.service.common.UserFileService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.constraints.NotEmpty;

@LoginValidator
@Validated
@RestController
@ResponseResult
@RequestMapping("/recycle")
public class RecycleController {
    private final FileInfoService fileInfoService;
    private final UserFileService userFileService;

    public RecycleController(FileInfoService fileInfoService, UserFileService userFileService) {
        this.fileInfoService = fileInfoService;
        this.userFileService = userFileService;
    }

    // 加载所有回收站数据
    @GetMapping("/loadRecycleList")
    public IPage<FileInfoVO> loadRecycleList(HttpSession session,
                                             FileInfoQuery query) {
        Page<FileInfo> pageParam = new Page<>(query.getPage(), query.getLimit());
        query.setUserId(((SessionWebUserVO) session.getAttribute(Constants.SESSION_KEY)).getId());
        query.setDeleted(FileDelFlagEnums.RECYCLE.getFlag());
        query.setOrderBy("recovery_time desc");
        return fileInfoService.pageInfo(pageParam, query);
    }

    // 恢复文件
    @PutMapping("/recoverFile/{ids}")
    public void recoverFile(HttpSession session,
                            @PathVariable("ids") @NotEmpty String ids) {
        SessionWebUserVO user = (SessionWebUserVO) session.getAttribute(Constants.SESSION_KEY);
        fileInfoService.recoverFileBatch(user.getId(), ids);
    }

    // 彻底删除文件
    @DeleteMapping ("/delFile/{ids}")
    public void delFile(HttpSession session,
                        @PathVariable("ids") @NotEmpty String ids) {
        SessionWebUserVO user = (SessionWebUserVO) session.getAttribute(Constants.SESSION_KEY);
        userFileService.delFileBatch(user.getId(), ids, false);
    }
}
