/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : 127.0.0.1:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 24/09/2019 16:27:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for kapp_acct
-- ----------------------------
DROP TABLE IF EXISTS `kapp_acct`;
CREATE TABLE `kapp_acct` (
  `acctno` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Account number',
  `cardno` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Card number',
  `acctam` decimal(20,2) DEFAULT NULL COMMENT 'Account Balance',
  `acctst` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Account Status(0-normal,1-logout) ',
  `custno` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Customer number',
  PRIMARY KEY (`acctno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of kapp_acct
-- ----------------------------
BEGIN;
INSERT INTO `kapp_acct` VALUES ('account number: 1569312876', 'card number: 1569312876', 100.00, '0', 'Customer Nunber:1569312876');
INSERT INTO `kapp_acct` VALUES ('account number: 1569312920', 'card number: 1569312920', 100.00, '0', 'Customer Nunber:1569312920');
COMMIT;

-- ----------------------------
-- Table structure for kapp_cust
-- ----------------------------
DROP TABLE IF EXISTS `kapp_cust`;
CREATE TABLE `kapp_cust` (
  `custno` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Customer number',
  `custna` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Customer name',
  `teleno` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Telephone number',
  PRIMARY KEY (`custno`),
  KEY `kapp_acct_db2` (`custna`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of kapp_cust
-- ----------------------------
BEGIN;
INSERT INTO `kapp_cust` VALUES ('Customer Nunber:1569312876', 'ganhang', '18973079348');
INSERT INTO `kapp_cust` VALUES ('Customer Nunber:1569312920', 'ganhang', '18973079348');
COMMIT;

-- ----------------------------
-- Table structure for tsp_param_version_info
-- ----------------------------
DROP TABLE IF EXISTS `tsp_param_version_info`;
CREATE TABLE `tsp_param_version_info` (
  `param_code` varchar(60) NOT NULL COMMENT '参数代码',
  `param_version` bigint(16) NOT NULL DEFAULT '0' COMMENT '参数版本',
  `tmtamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '时间戳',
  `system_code` varchar(20) NOT NULL DEFAULT '''' COMMENT '系统标识号',
  `corporate_code` varchar(20) NOT NULL DEFAULT '''' COMMENT '法人代码',
  `data_create_time` timestamp NOT NULL DEFAULT '1970-01-01 08:00:01' COMMENT '创建时间',
  `data_update_time` timestamp NOT NULL DEFAULT '1970-01-01 08:00:01' COMMENT '更新时间',
  PRIMARY KEY (`param_code`,`system_code`,`corporate_code`),
  UNIQUE KEY `tsp_param_version_info_idx1` (`param_code`,`system_code`,`corporate_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tsp_service_control
-- ----------------------------
DROP TABLE IF EXISTS `tsp_service_control`;
CREATE TABLE `tsp_service_control` (
  `system_code` varchar(20) NOT NULL COMMENT '系统编号',
  `sub_system_code` varchar(20) NOT NULL COMMENT '子系统编号',
  `service_invoke_id` varchar(50) NOT NULL COMMENT '业务服务调用标识',
  `inner_service_code` varchar(100) NOT NULL COMMENT '内部服务码',
  `inner_service_impl_code` varchar(100) DEFAULT NULL COMMENT '内部服务实现标识',
  `description` varchar(200) DEFAULT NULL COMMENT '描述信息',
  `route_keys` varchar(100) DEFAULT NULL COMMENT '路由关键字',
  `cancel_service` varchar(50) DEFAULT NULL COMMENT '冲正服务标识',
  `confirm_service` varchar(50) DEFAULT NULL COMMENT '二次提交服务标识',
  `service_transaction_mode` varchar(20) NOT NULL COMMENT '服务事务模式(NotSupported-不启事务,Supports-支持事务,Required-支持事务，并且执行二次提交) ',
  `service_type` varchar(10) NOT NULL COMMENT '业务服务类型(check-检查类业务服务,try-一次提交业务服务,notify-通知类业务服务,cancel-冲正类业务服务,confirm-二次提交类业务服务) ',
  `regist_call_log` int(1) DEFAULT NULL COMMENT '是否登记通讯接出日志(1-是,0-否) ',
  `service_executor_type` char(1) DEFAULT NULL COMMENT '服务执行类型(L-本地执行,R-远程执行,A-异步执行,F-流程执行) ',
  PRIMARY KEY (`system_code`,`sub_system_code`,`service_invoke_id`,`inner_service_code`),
  KEY `tsp_service_control_idx1` (`system_code`,`sub_system_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tsp_service_in
-- ----------------------------
DROP TABLE IF EXISTS `tsp_service_in`;
CREATE TABLE `tsp_service_in` (
  `system_code` varchar(20) NOT NULL,
  `sub_system_code` varchar(20) NOT NULL,
  `out_service_code` varchar(50) NOT NULL,
  `inner_service_code` varchar(100) NOT NULL,
  `inner_service_impl_code` varchar(100) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `service_category` char(1) NOT NULL DEFAULT 'T',
  `route_keys` varchar(100) DEFAULT NULL,
  `service_type` varchar(10) DEFAULT NULL,
  `protocol_id` varchar(25) NOT NULL,
  `is_enable` int(1) NOT NULL DEFAULT '1',
  `transaction_mode` char(1) NOT NULL DEFAULT 'A',
  `log_level` varchar(10) DEFAULT NULL,
  `timeout` int(8) DEFAULT NULL,
  `alias_mapping` int(1) DEFAULT '0',
  `force_unused_odb_cache` int(1) DEFAULT '0',
  `register_mode` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`system_code`,`sub_system_code`,`out_service_code`),
  KEY `tsp_service_in_idx1` (`system_code`,`sub_system_code`,`is_enable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tsp_service_in
-- ----------------------------
BEGIN;
INSERT INTO `tsp_service_in` VALUES ('core', 'demo', 'ap001', 'ap001', 'ap001', '', 'T', NULL, NULL, 'rpc', 1, 'A', NULL, NULL, 0, 0, '0');
COMMIT;

-- ----------------------------
-- Table structure for tsp_service_in_log
-- ----------------------------
DROP TABLE IF EXISTS `tsp_service_in_log`;
CREATE TABLE `tsp_service_in_log` (
  `busi_seq_num` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `call_seq_num` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `orig_call_seq_num` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `out_service_app` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `out_service_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `out_service_group` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `out_service_version` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `inner_service_code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `inner_service_impl_code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `begin_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_time` timestamp NOT NULL DEFAULT '1970-01-01 08:00:01',
  `use_time` bigint(19) DEFAULT NULL,
  `resp_code` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resp_text` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process_status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_inst_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `server_inst_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `system_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `input_msg` text COLLATE utf8mb4_unicode_ci,
  `output_msg` text COLLATE utf8mb4_unicode_ci,
  `error_text` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`call_seq_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for tsp_service_out
-- ----------------------------
DROP TABLE IF EXISTS `tsp_service_out`;
CREATE TABLE `tsp_service_out` (
  `system_code` varchar(20) NOT NULL,
  `sub_system_code` varchar(20) NOT NULL,
  `service_invoke_id` varchar(50) NOT NULL,
  `inner_service_code` varchar(100) NOT NULL,
  `out_service_app` varchar(25) DEFAULT NULL,
  `out_service_code` varchar(50) NOT NULL,
  `out_service_group` varchar(25) NOT NULL,
  `out_service_version` varchar(25) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `protocol_id` varchar(25) NOT NULL,
  `timeout` int(8) DEFAULT NULL,
  `timeout_redo_counts` int(8) DEFAULT '0',
  `timeout_confirm` int(1) DEFAULT '0',
  `alias_mapping` int(1) DEFAULT '0',
  `regist_call_log` int(1) DEFAULT '0',
  PRIMARY KEY (`system_code`,`sub_system_code`,`service_invoke_id`,`inner_service_code`),
  KEY `tsp_service_out_idx1` (`system_code`,`sub_system_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tsp_service_out_log
-- ----------------------------
DROP TABLE IF EXISTS `tsp_service_out_log`;
CREATE TABLE `tsp_service_out_log` (
  `busi_seq_num` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `call_seq_num` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_call_seq_num` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_invoke_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `inner_service_code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `out_service_app` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `out_service_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `out_service_group` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `out_service_version` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `out_service_dcnno` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `begin_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_time` timestamp NOT NULL DEFAULT '1970-01-01 08:00:01',
  `use_time` bigint(19) DEFAULT NULL,
  `resp_code` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resp_text` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `system_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `process_status` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `retry_count` int(3) NOT NULL,
  `service_mode` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `initator_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `processor_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `input_msg` text COLLATE utf8mb4_unicode_ci,
  `output_msg` text COLLATE utf8mb4_unicode_ci,
  `error_text` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`call_seq_num`,`service_call_seq_num`),
  KEY `tsp_service_out_log_idx1` (`processor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for tsp_table_control
-- ----------------------------
DROP TABLE IF EXISTS `tsp_table_control`;
CREATE TABLE `tsp_table_control` (
  `table_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '表名',
  `table_comment` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表中文名称',
  `cache_level` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '缓存级别',
  `remote_mode` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '远程模式，默认为db',
  `is_executed_preprocess` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '执行前处理标志',
  `is_registered_changed_log` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登记变更日志标志',
  `is_check_param` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '检查参数标志',
  `is_process_param` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '处理参数标志',
  `process_result` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '处理结果标志',
  `sql_timeout` bigint(16) DEFAULT NULL COMMENT 'sql超时时间',
  `lock_wait_time` bigint(16) DEFAULT NULL COMMENT '锁等待时间',
  `sql_retry_freq` bigint(16) DEFAULT NULL COMMENT 'sql重试次数',
  `sql_retry_interval` bigint(16) DEFAULT NULL COMMENT 'sql重试间隔',
  `is_param_table` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否参数表',
  `data_create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `data_update_time` timestamp NOT NULL DEFAULT '1970-01-01 08:00:01' COMMENT '更新时间',
  PRIMARY KEY (`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
