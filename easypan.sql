SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for email_code
-- ----------------------------
DROP TABLE IF EXISTS `email_code`;
CREATE TABLE `email_code` (
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `code` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '验证码',
  `status` tinyint(1) DEFAULT NULL COMMENT '0:未使用 1:已使用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`email`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for file_info
-- ----------------------------
DROP TABLE IF EXISTS `file_info`;
CREATE TABLE `file_info` (
  `id` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件ID',
  `user_id` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户ID',
  `file_md5` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件MD5值',
  `file_pid` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件父ID',
  `file_size` bigint DEFAULT NULL COMMENT '文件大小',
  `filename` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件名',
  `file_cover` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件封面',
  `file_path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件路径',
  `folder_type` tinyint(1) DEFAULT NULL COMMENT '0文件 1目录',
  `file_category` tinyint(1) DEFAULT NULL COMMENT '文件分类 1:视频 2:音频 3:图片 4:文档 5:其他',
  `file_type` tinyint(1) DEFAULT NULL COMMENT '文件分类 1:视频 2:音频 3:图片 4:pdf 5:doc 6:excel 7:txt 8:代码 9:压缩包 10:其他',
  `status` tinyint(1) DEFAULT NULL COMMENT '0:转码中 1:转码失败 2:转码成功',
  `recovery_time` datetime DEFAULT NULL COMMENT '进入回收站时间',
  `version` int DEFAULT '1' COMMENT '乐观锁',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0:正常 1:回收站 2:删除',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`user_id`),
  KEY `idx_create_time` (`create_time`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_md5` (`file_md5`),
  KEY `idx_file_pid` (`file_pid`),
  KEY `idx_deleted` (`deleted`),
  KEY `idx_revover_time` (`recovery_time`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='文件信息表';

-- ----------------------------
-- Table structure for file_share
-- ----------------------------
DROP TABLE IF EXISTS `file_share`;
CREATE TABLE `file_share` (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '分享ID',
  `file_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件ID',
  `user_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户ID',
  `valid_type` tinyint(1) DEFAULT NULL COMMENT '有效期类型 0:1天 1:7天 2:30天 3:永久有效',
  `code` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '提取码',
  `browse_count` int DEFAULT '0' COMMENT '浏览次数',
  `save_count` int DEFAULT '0' COMMENT '保存次数',
  `download_count` int DEFAULT '0' COMMENT '下载次数',
  `deleted` tinyint DEFAULT '0' COMMENT '逻辑删除',
  `version` int DEFAULT '1' COMMENT '乐观锁',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '昵称',
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `qq_open_id` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'QQ openID',
  `qq_avatar` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'QQ头像',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后一次登陆时间',
  `use_space` bigint DEFAULT NULL COMMENT '使用空间 单位 byte',
  `total_space` bigint DEFAULT NULL COMMENT '总空间',
  `status` tinyint(1) DEFAULT '1' COMMENT '用户状态，0:禁用 1:启用',
  `version` int DEFAULT '1' COMMENT '乐观锁',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '逻辑删除 0:正常 1:删除',
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_email` (`email`) USING BTREE,
  UNIQUE KEY `qq_open_id` (`qq_open_id`) USING BTREE,
  UNIQUE KEY `key_nickname` (`nickname`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户信息';

SET FOREIGN_KEY_CHECKS = 1;
