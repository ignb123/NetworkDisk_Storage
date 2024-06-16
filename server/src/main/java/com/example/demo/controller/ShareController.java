package com.example.demo.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.annotation.LoginValidator;
import com.example.demo.common.annotation.ResponseResult;
import com.example.demo.entity.constants.Constants;
import com.example.demo.entity.vo.FileShareVo;
import com.example.demo.entity.vo.SessionWebUserVO;
import com.example.demo.entity.dto.ShareDTO;
import com.example.demo.pojo.FileShare;
import com.example.demo.service.FileShareService;
import org.springframework.beans.BeanUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.constraints.NotEmpty;
/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author sw-code
 * @since 2023-07-14
 */
@RestController
@RequestMapping("/share")
@ResponseResult
@LoginValidator
@Validated
public class ShareController {
    private final FileShareService fileShareService;

    public ShareController(FileShareService fileShareService) {
        this.fileShareService = fileShareService;
    }


    // 根据category，加载所有数据
    @GetMapping("/loadShareList")
    public IPage<FileShareVo> loadShareList(HttpSession session,
                                            @RequestParam(required = false, defaultValue = "1") Integer page,
                                            @RequestParam(required = false, defaultValue = "10") Integer limit) {

        Page<FileShare> pageParam = new Page<>(page, limit);
        String userId = ((SessionWebUserVO) session.getAttribute(Constants.SESSION_KEY)).getId();
        return fileShareService.pageInfo(pageParam, userId);
    }

    @PostMapping("/shareFile")
    public FileShare shareFile(HttpSession session, @RequestBody ShareDTO shareDTO) {
        String userId = ((SessionWebUserVO) session.getAttribute(Constants.SESSION_KEY)).getId();
        FileShare fileShare = new FileShare();
        fileShare.setUserId(userId);
        BeanUtils.copyProperties(shareDTO, fileShare);
        return fileShareService.saveShare(fileShare);
    }

    @DeleteMapping("/cancelShare/{shareIds}")
    public void cancelShare(HttpSession session, @PathVariable("shareIds") @NotEmpty String shareIds) {
        String userId = ((SessionWebUserVO) session.getAttribute(Constants.SESSION_KEY)).getId();
        fileShareService.deleteShareBatch(shareIds, userId);
    }
}
