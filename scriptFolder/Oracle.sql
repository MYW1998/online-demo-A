-- Customer information form
-- begin execute immediate 'drop table kapp_cust'; exception when others then null; end;
-- drop table kapp_cust;

create table kapp_cust (
  custno varchar2(100) ,--Customer number               
  custna varchar2(100) ,--Customer name               
  teleno varchar2(100) --Telephone number               
);

alter table kapp_cust add constraint kapp_acct_db1 primary key (custno)
using index ;	
-- drop index kapp_acct_db2;
create index kapp_acct_db2 on kapp_cust (custna) ;	
comment on table kapp_cust is 'Customer information form'; 
comment on column kapp_cust.custno is 'Customer number';
comment on column kapp_cust.custna is 'Customer name';
comment on column kapp_cust.teleno is 'Telephone number';
-- Account information form
-- begin execute immediate 'drop table kapp_acct'; exception when others then null; end;
-- drop table kapp_acct;

create table kapp_acct (
  acctno varchar2(100) ,--Account number               
  cardno varchar2(100) ,--Card number               
  acctam number(20,2) ,--Account Balance               
  acctst varchar2(1) ,--Account Status               
  custno varchar2(100) --Customer number               
);

alter table kapp_acct add constraint acctno_index primary key (acctno)
using index ;	
comment on table kapp_acct is 'Account information form'; 
comment on column kapp_acct.acctno is 'Account number';
comment on column kapp_acct.cardno is 'Card number';
comment on column kapp_acct.acctam is 'Account Balance';
comment on column kapp_acct.acctst is 'Account Status(0-normal,1-logout)';
comment on column kapp_acct.custno is 'Customer number';

-- 服务调用控制表
-- begin execute immediate 'drop table tsp_service_control'; exception when others then null; end;
-- drop table tsp_service_control;

create table tsp_service_control (
  system_code varchar2(20) not null ,--系统编号 配置该业务服务所属的系统编号               
  sub_system_code varchar2(20) not null ,--子系统编号 配置该业务服务所属的子系统编号               
  service_invoke_id varchar2(50) not null ,--业务服务调用标识 配置该业务服务在调用时的标识，如果该业务服务为通用的，则该调用标识可配置为*               
  inner_service_code varchar2(100) not null ,--内部服务码               
  inner_service_impl_code varchar2(100) ,--内部服务实现标识               
  description varchar2(200) ,--描述信息               
  route_keys varchar2(100) ,--路由关键字 配置服务的路由关键字，通常用于分布式场景               
  cancel_service varchar2(50) ,--冲正服务标识 配置业务服务对应的冲正业务服务的标识               
  confirm_service varchar2(50) ,--二次提交服务标识 配置业务服务对应的二次提交业务服务标识               
  service_transaction_mode varchar2(20) not null ,--服务事务模式               
  service_type varchar2(10) not null ,--业务服务类型               
  regist_call_log char(1) ,--是否登记通讯接出日志 配置是否登记服务的调用日志，0-不登记，1-登记，默认为0               
  service_executor_type char(1) --服务执行类型 配置该服务的执行器类型，L-本地执行，R-远程执行，A-异步执行               
);

alter table tsp_service_control add constraint tsp_service_control_pk1 primary key (system_code,sub_system_code,service_invoke_id,inner_service_code)
using index ; 
-- drop index tsp_service_control_idx1;
create index tsp_service_control_idx1 on tsp_service_control (system_code,sub_system_code) ;  
comment on table tsp_service_control is '服务调用控制表'; 
comment on column tsp_service_control.system_code is '系统编号';
comment on column tsp_service_control.sub_system_code is '子系统编号';
comment on column tsp_service_control.service_invoke_id is '业务服务调用标识';
comment on column tsp_service_control.inner_service_code is '内部服务码';
comment on column tsp_service_control.inner_service_impl_code is '内部服务实现标识';
comment on column tsp_service_control.description is '描述信息';
comment on column tsp_service_control.route_keys is '路由关键字';
comment on column tsp_service_control.cancel_service is '冲正服务标识';
comment on column tsp_service_control.confirm_service is '二次提交服务标识';
comment on column tsp_service_control.service_transaction_mode is '服务事务模式(NotSupported-不启事务,Supports-支持事务,Required-支持事务，并且执行二次提交)';
comment on column tsp_service_control.service_type is '业务服务类型(check-检查类业务服务,try-一次提交业务服务,notify-通知类业务服务,cancel-冲正类业务服务,confirm-二次提交类业务服务)';
comment on column tsp_service_control.regist_call_log is '是否登记通讯接出日志(1-是,0-否)';
comment on column tsp_service_control.service_executor_type is '服务执行类型(L-本地执行,R-远程执行,A-异步执行,F-流程执行)';


-- 表控制表
-- begin execute immediate 'drop table tsp_table_control'; exception when others then null; end;
-- drop table tsp_table_control;

create table tsp_table_control (
  table_name varchar2(30) not null ,--表名 待缓存的数据库表名               
  table_comment varchar2(200) ,--表中文名称 需待缓存的数据库表的中文名               
  cache_level varchar2(10) ,--缓存级别 定义表的缓存级别。级别包括：none-不缓存，tran-交易级缓存，global-全局缓存。为了性能考虑，尽量所有的表都配置为tran(交易级缓存)。               
  remote_mode varchar2(15) ,--远程模式，默认为db 定义该表对应的远程数据模式。包括：db, redis, db+redis,dataService等模式，默认为db               
  is_executed_preprocess varchar2(1) ,--执行前处理标志 可配置为0-否，1-是；定义是否在执行insert/update/deletelect操作前回调前处理（beforeDaoProcess）方法，beforeDaoProcess方法是用于对公共字段（法人代码、时间戳、记录状态、维护机构、维护柜员）的赋值；建议配置了继承公共字段表的所有表都将该处值配置为1。               
  is_registered_changed_log varchar2(1) ,--登记变更日志标志 可配置为0-否，1-是；定义是否在执行该表的delete/insert/update操作时登记业务日志表，建议配置了继承公共字段表的所有表都将该处值配置为1。               
  is_check_param varchar2(1) ,--检查参数标志 可配置为0-否，1-是；定义是否在执行update/delete操作前检查参数的合法性，例如检查时间戳是否一致，保证在操作过程中没有其他事务操作该记录;建议配置了继承公共字段表的所有表都将该处值配置为1。               
  is_process_param varchar2(1) ,--处理参数标志 可配置为0-否，1-是；定义是否在执行update/delete操作前对参数进行处理，例如修改时间戳为当前时间戳、敏感字段加密、防篡改字段赋值等操作；建议配置了继承公共字段表的所有表都将该处值配置为1。               
  process_result varchar2(1) ,--处理结果标志 标记处理结果，1-标记，0不标记。               
  sql_timeout number(16) ,--sql超时时间 定义表的SQL语句执行超时时间，单位：毫秒。               
  lock_wait_time number(16) ,--锁等待时间 即：SQL中的for update wait 1s,单位：秒，-1表示无wait语句，0表示nowait，大于0表示等待秒数               
  sql_retry_freq number(16) ,--sql重试次数 小于等于0表示不重试               
  sql_retry_interval number(16) ,--sql重试间隔 单位：毫秒               
  is_param_table varchar2(1) ,--是否参数表 可配置为0-否，1-是               
  data_create_time timestamp ,--创建时间 数据入库时间               
  data_update_time timestamp --更新时间 数据更新时间               
);

-- drop index tsp_table_control_indx1;
create unique index tsp_table_control_indx1 on tsp_table_control (table_name) ;	
comment on table tsp_table_control is '表控制表'; 
comment on column tsp_table_control.table_name is '表名';
comment on column tsp_table_control.table_comment is '表中文名称';
comment on column tsp_table_control.cache_level is '缓存级别';
comment on column tsp_table_control.remote_mode is '远程模式，默认为db';
comment on column tsp_table_control.is_executed_preprocess is '执行前处理标志';
comment on column tsp_table_control.is_registered_changed_log is '登记变更日志标志';
comment on column tsp_table_control.is_check_param is '检查参数标志';
comment on column tsp_table_control.is_process_param is '处理参数标志';
comment on column tsp_table_control.process_result is '处理结果标志';
comment on column tsp_table_control.sql_timeout is 'sql超时时间';
comment on column tsp_table_control.lock_wait_time is '锁等待时间';
comment on column tsp_table_control.sql_retry_freq is 'sql重试次数';
comment on column tsp_table_control.sql_retry_interval is 'sql重试间隔';
comment on column tsp_table_control.is_param_table is '是否参数表';
comment on column tsp_table_control.data_create_time is '创建时间';
comment on column tsp_table_control.data_update_time is '更新时间';
-- 参数的版本信息
-- begin execute immediate 'drop table tsp_param_version_info'; exception when others then null; end;
-- drop table tsp_param_version_info;

create table tsp_param_version_info (
  param_code varchar2(60) not null ,--参数代码 配置：表文件名加上表名（如：KSysOnlTable.ksys_csbbxx）或“*”，“*”表示所有配置的全局缓存表               
  param_version number(16) default '0' not null ,--参数版本 参数代码表示的表中有值发生变化，则版本号就要加一（由用户自己去加一）               
  tmtamp timestamp ,--时间戳 更新参数版本号的时间戳               
  system_code varchar2(20) default ''not null ,--系统标识号               
  corporate_code varchar2(20) default ''not null ,--法人代码 法人代码               
  data_create_time timestamp ,--创建时间 数据入库时间               
  data_update_time timestamp --更新时间 数据更新时间               
);

-- drop index tsp_param_version_info_idx1;
create unique index tsp_param_version_info_idx1 on tsp_param_version_info (param_code,system_code,corporate_code) ;	
-- drop index tsp_param_version_info_idx2;
create index tsp_param_version_info_idx2 on tsp_param_version_info (system_code) ;	
comment on table tsp_param_version_info is '参数的版本信息'; 
comment on column tsp_param_version_info.param_code is '参数代码';
comment on column tsp_param_version_info.param_version is '参数版本';
comment on column tsp_param_version_info.tmtamp is '时间戳';
comment on column tsp_param_version_info.system_code is '系统标识号';
comment on column tsp_param_version_info.corporate_code is '法人代码';
comment on column tsp_param_version_info.data_create_time is '创建时间';
comment on column tsp_param_version_info.data_update_time is '更新时间';

-- 服务接入信息表
-- begin execute immediate 'drop table tsp_service_in'; exception when others then null; end;
-- drop table tsp_service_in;

create table tsp_service_in (
  system_code varchar2(20) not null ,--系统编号 配置该服务记录所属的系统编号               
  sub_system_code varchar2(20) not null ,--子系统编号 配置该服务记录所属的子系统编号               
  out_service_code varchar2(100) not null ,--外部服务码 配置接入的服务码               
  inner_service_code varchar2(100) not null ,--内部服务码 配置内部的服务码，如果是交易，则对应的是flowid；如果是业务服务，则对应的是service的fullid               
  inner_service_impl_code varchar2(100) ,--内部服务实现标识 配置服务实现的标识，如果是交易，则不需要配置，如果是业务服务，则配置对应的服务实现的id               
  description varchar2(200) ,--描述信息               
  service_category char(1) default 'T' not null ,--服务类别               
  route_keys varchar2(100) ,--路由关键字               
  service_type varchar2(10) ,--业务服务类型               
  protocol_id varchar2(25) not null ,--通讯协议标识               
  is_enable char(1) default '1' not null ,--是否启用               
  transaction_mode char(1) default 'A' not null ,--事务模式               
  log_level varchar2(10) ,--日志级别 配置服务执行的日志级别               
  timeout number(8) ,--超时时间 配置服务执行的超时时间，单位为毫秒（ms）               
  alias_mapping char(1) default '0' ,--是否别名映射 配置服务接入是否执行接口字段的名称映射，0-表示不执行别名映射，1-表示执行别名映射               
  force_unused_odb_cache char(1) default '0' ,--是否强制不使用ODB缓存 是否强制不使用odb缓存，默认为0-不控制，即随具体表的配置控制，1为强制不使用odb缓存               
  register_mode char(1) default '0' not null ,--登记通讯日志模式               
  service_group varchar2(100) --服务分组信息               
);

alter table tsp_service_in add constraint tsp_service_in_pk1 primary key (system_code,sub_system_code,out_service_code)
using index ;	
-- drop index tsp_service_in_idx1;
create index tsp_service_in_idx1 on tsp_service_in (system_code,sub_system_code,is_enable) ;	
comment on table tsp_service_in is '服务接入信息表'; 
comment on column tsp_service_in.system_code is '系统编号';
comment on column tsp_service_in.sub_system_code is '子系统编号';
comment on column tsp_service_in.out_service_code is '外部服务码';
comment on column tsp_service_in.inner_service_code is '内部服务码';
comment on column tsp_service_in.inner_service_impl_code is '内部服务实现标识';
comment on column tsp_service_in.description is '描述信息';
comment on column tsp_service_in.service_category is '服务类别(T-流程交易,S-业务服务,F-流程编排)';
comment on column tsp_service_in.route_keys is '路由关键字';
comment on column tsp_service_in.service_type is '业务服务类型(check-检查类业务服务,try-一次提交业务服务,notify-通知类业务服务,cancel-冲正类业务服务,confirm-二次提交类业务服务)';
comment on column tsp_service_in.protocol_id is '通讯协议标识';
comment on column tsp_service_in.is_enable is '是否启用(1-是,0-否)';
comment on column tsp_service_in.transaction_mode is '事务模式(R-只读事务模式,A-原子事务模式,C-事务块模式,D-分布式事务模式)';
comment on column tsp_service_in.log_level is '日志级别';
comment on column tsp_service_in.timeout is '超时时间';
comment on column tsp_service_in.alias_mapping is '是否别名映射(1-是,0-否)';
comment on column tsp_service_in.force_unused_odb_cache is '是否强制不使用ODB缓存(1-是,0-否)';
comment on column tsp_service_in.register_mode is '登记通讯日志模式(0-不登记,1-登记不检查,2-登记并防重处理,3-登记并幂等处理)';
comment on column tsp_service_in.service_group is '服务分组信息';
-- 服务接入日志表
-- begin execute immediate 'drop table tsp_service_in_log'; exception when others then null; end;
-- drop table tsp_service_in_log;

create table tsp_service_in_log (
  busi_seq_num varchar2(64) not null ,--业务流水号 标识一笔业务，每笔接入的服务都会传递该值               
  call_seq_num varchar2(64) not null ,--系统调用流水号 标识一笔交易，每笔接入的服务都会传递该值。注意：如果交易有外调则会生成一个新的交易流水传递给下一个JVM               
  orig_call_seq_num varchar2(64) ,--发起方系统调用流水               
  out_service_app varchar2(25) ,--外部服务应用标识               
  out_service_code varchar2(100) not null ,--外部服务码 被访问的外部服务码               
  out_service_group varchar2(25) not null ,--外部服务分组号 被访问的外部服务分组号               
  out_service_version varchar2(25) not null ,--外部服务版本号 被访问的外部服务版本号               
  inner_service_code varchar2(100) not null ,--内部服务码               
  inner_service_impl_code varchar2(100) not null ,--内部服务实现标识               
  begin_time timestamp ,--开始时间 服务接入时间               
  end_time timestamp ,--结束时间 服务响应时间               
  use_time number(19) ,--耗时（毫秒）               
  resp_code varchar2(25) ,--响应码               
  resp_text varchar2(400) ,--响应信息               
  process_status char(1) ,--执行状态               
  client_inst_id varchar2(50) ,--客户端标识               
  server_inst_id varchar2(50) ,--服务端标识               
  system_code varchar2(20) not null ,--系统编号               
  input_msg clob,--请求数据               
  output_msg clob,--响应数据               
  error_text varchar2(4000) --异常堆栈               
);

alter table tsp_service_in_log add constraint tsp_service_in_log_pk1 primary key (call_seq_num)
using index ;	
comment on table tsp_service_in_log is '服务接入日志表'; 
comment on column tsp_service_in_log.busi_seq_num is '业务流水号';
comment on column tsp_service_in_log.call_seq_num is '系统调用流水号';
comment on column tsp_service_in_log.orig_call_seq_num is '发起方系统调用流水';
comment on column tsp_service_in_log.out_service_app is '外部服务应用标识';
comment on column tsp_service_in_log.out_service_code is '外部服务码';
comment on column tsp_service_in_log.out_service_group is '外部服务分组号';
comment on column tsp_service_in_log.out_service_version is '外部服务版本号';
comment on column tsp_service_in_log.inner_service_code is '内部服务码';
comment on column tsp_service_in_log.inner_service_impl_code is '内部服务实现标识';
comment on column tsp_service_in_log.begin_time is '开始时间';
comment on column tsp_service_in_log.end_time is '结束时间';
comment on column tsp_service_in_log.use_time is '耗时（毫秒）';
comment on column tsp_service_in_log.resp_code is '响应码';
comment on column tsp_service_in_log.resp_text is '响应信息';
comment on column tsp_service_in_log.process_status is '执行状态(W-待处理,P-处理中,S-处理成功,F-处理失败)';
comment on column tsp_service_in_log.client_inst_id is '客户端标识';
comment on column tsp_service_in_log.server_inst_id is '服务端标识';
comment on column tsp_service_in_log.system_code is '系统编号';
comment on column tsp_service_in_log.input_msg is '请求数据';
comment on column tsp_service_in_log.output_msg is '响应数据';
comment on column tsp_service_in_log.error_text is '异常堆栈';

-- 服务接出信息表
-- begin execute immediate 'drop table tsp_service_out'; exception when others then null; end;
-- drop table tsp_service_out;

create table tsp_service_out (
  system_code varchar2(20) not null ,--系统编号 配置该服务记录所属的系统编号               
  sub_system_code varchar2(20) not null ,--子系统编号 配置该服务记录所属的子系统编号               
  service_invoke_id varchar2(50) not null ,--业务服务调用标识 配置该业务服务在调用时的标识，如果该业务服务为通用的，则该调用标识可配置为*               
  inner_service_code varchar2(100) not null ,--内部服务码               
  out_service_app varchar2(25) ,--外部服务应用标识               
  out_service_code varchar2(100) not null ,--外部服务码 配置接出的服务码               
  out_service_group varchar2(25) not null ,--外部服务分组号 配置接出的服务分组号               
  out_service_version varchar2(25) ,--外部服务版本号 配置接出的服务版本号               
  description varchar2(200) ,--描述信息               
  protocol_id varchar2(25) not null ,--通讯协议标识               
  timeout number(8) ,--超时时间 配置业务服务接出的超时时间，单位为毫秒（ms）               
  timeout_redo_counts number(8) default '0' ,--超时重试次数 配置业务服务接出超时后的重试次数               
  timeout_confirm char(1) default '0' ,--超时确认标志 配置业务服务接出超时后是否需要发起确认服务的标志，0-不需要进行超时确认，1-需要进行超时确认               
  alias_mapping char(1) default '0' ,--是否别名映射 配置服务接出是否执行接口字段的名称映射，0-表示不执行别名映射，1-表示执行别名映射               
  regist_call_log char(1) default '0' --是否登记通讯接出日志 配置是否登记服务通讯接出的日志，0-表示不登记通讯接出日志，1-表示登记通讯接出日志               
);

alter table tsp_service_out add constraint tsp_service_out_pk1 primary key (system_code,sub_system_code,service_invoke_id,inner_service_code)
using index ;	
-- drop index tsp_service_out_idx1;
create index tsp_service_out_idx1 on tsp_service_out (system_code,sub_system_code) ;	
comment on table tsp_service_out is '服务接出信息表'; 
comment on column tsp_service_out.system_code is '系统编号';
comment on column tsp_service_out.sub_system_code is '子系统编号';
comment on column tsp_service_out.service_invoke_id is '业务服务调用标识';
comment on column tsp_service_out.inner_service_code is '内部服务码';
comment on column tsp_service_out.out_service_app is '外部服务应用标识';
comment on column tsp_service_out.out_service_code is '外部服务码';
comment on column tsp_service_out.out_service_group is '外部服务分组号';
comment on column tsp_service_out.out_service_version is '外部服务版本号';
comment on column tsp_service_out.description is '描述信息';
comment on column tsp_service_out.protocol_id is '通讯协议标识';
comment on column tsp_service_out.timeout is '超时时间';
comment on column tsp_service_out.timeout_redo_counts is '超时重试次数';
comment on column tsp_service_out.timeout_confirm is '超时确认标志(1-是,0-否)';
comment on column tsp_service_out.alias_mapping is '是否别名映射(1-是,0-否)';
comment on column tsp_service_out.regist_call_log is '是否登记通讯接出日志(1-是,0-否)';
-- 服务接出日志表
-- begin execute immediate 'drop table tsp_service_out_log'; exception when others then null; end;
-- drop table tsp_service_out_log;

create table tsp_service_out_log (
  busi_seq_num varchar2(64) not null ,--业务流水号 标识一笔业务，每笔接入的服务都会传递该值               
  call_seq_num varchar2(64) not null ,--系统调用流水号 标识一笔交易，每笔接入的服务都会传递该值。注意：如果交易有外调则会生成一个新的交易流水传递给下一个JVM               
  service_call_seq_num varchar2(64) not null ,--服务调用流水号               
  service_invoke_id varchar2(50) not null ,--业务服务调用标识 该业务服务在调用时的标识，如果该业务服务为通用的，则该调用标识可配置为*               
  service_type varchar2(10) not null ,--业务服务类型               
  inner_service_code varchar2(100) not null ,--内部服务码               
  out_service_app varchar2(25) ,--外部服务应用标识               
  out_service_code varchar2(100) not null ,--外部服务码 被访问的外部服务码               
  out_service_group varchar2(25) not null ,--外部服务分组号 被访问的外部服务分组号               
  out_service_version varchar2(25) ,--外部服务版本号 被访问的外部服务版本号               
  out_service_dcnno varchar2(10) ,--外部服务节点编号               
  begin_time timestamp not null ,--开始时间 开始时间               
  end_time timestamp ,--结束时间 服务响应时间               
  use_time number(19) ,--耗时（毫秒）               
  resp_code varchar2(25) ,--响应码               
  resp_text varchar2(400) ,--响应信息               
  system_code varchar2(20) not null ,--系统编号               
  process_status char(1) not null ,--执行状态               
  retry_count number(3) not null ,--重试次数               
  service_mode char(1) not null ,--服务模式 同步标识：S；异步标识：A               
  initator_id varchar2(50) not null ,--发起方标识 异步处理时：处理异步消息的JVM标识；异步处理时：登记异步消息的JVM标识               
  processor_id varchar2(50) not null ,--处理方标识 同步处理时：服务端标识；异步处理时：处理异步消息的JVM标识               
  input_msg clob,--请求数据               
  output_msg clob,--响应数据               
  error_text varchar2(4000) --异常堆栈               
);

alter table tsp_service_out_log add constraint tsp_service_out_log_pk1 primary key (call_seq_num,service_call_seq_num)
using index ;	
-- drop index tsp_service_out_log_idx1;
create index tsp_service_out_log_idx1 on tsp_service_out_log (processor_id) ;	
comment on table tsp_service_out_log is '服务接出日志表'; 
comment on column tsp_service_out_log.busi_seq_num is '业务流水号';
comment on column tsp_service_out_log.call_seq_num is '系统调用流水号';
comment on column tsp_service_out_log.service_call_seq_num is '服务调用流水号';
comment on column tsp_service_out_log.service_invoke_id is '业务服务调用标识';
comment on column tsp_service_out_log.service_type is '业务服务类型(check-检查类业务服务,try-一次提交业务服务,notify-通知类业务服务,cancel-冲正类业务服务,confirm-二次提交类业务服务)';
comment on column tsp_service_out_log.inner_service_code is '内部服务码';
comment on column tsp_service_out_log.out_service_app is '外部服务应用标识';
comment on column tsp_service_out_log.out_service_code is '外部服务码';
comment on column tsp_service_out_log.out_service_group is '外部服务分组号';
comment on column tsp_service_out_log.out_service_version is '外部服务版本号';
comment on column tsp_service_out_log.out_service_dcnno is '外部服务节点编号';
comment on column tsp_service_out_log.begin_time is '开始时间';
comment on column tsp_service_out_log.end_time is '结束时间';
comment on column tsp_service_out_log.use_time is '耗时（毫秒）';
comment on column tsp_service_out_log.resp_code is '响应码';
comment on column tsp_service_out_log.resp_text is '响应信息';
comment on column tsp_service_out_log.system_code is '系统编号';
comment on column tsp_service_out_log.process_status is '执行状态(W-待处理,P-处理中,S-处理成功,F-处理失败)';
comment on column tsp_service_out_log.retry_count is '重试次数';
comment on column tsp_service_out_log.service_mode is '服务模式(S-同步,A-异步)';
comment on column tsp_service_out_log.initator_id is '发起方标识';
comment on column tsp_service_out_log.processor_id is '处理方标识';
comment on column tsp_service_out_log.input_msg is '请求数据';
comment on column tsp_service_out_log.output_msg is '响应数据';
comment on column tsp_service_out_log.error_text is '异常堆栈';

INSERT INTO ADP_TEST.TSP_SERVICE_CONTROL (SYSTEM_CODE, SUB_SYSTEM_CODE, SERVICE_INVOKE_ID, INNER_SERVICE_CODE, INNER_SERVICE_IMPL_CODE, DESCRIPTION, ROUTE_KEYS, CANCEL_SERVICE, CONFIRM_SERVICE, SERVICE_TRANSACTION_MODE, SERVICE_TYPE, REGIST_CALL_LOG, SERVICE_EXECUTOR_TYPE) VALUES('online-demo-A', 'demoA', '*', 'hello.getMeassageByName', NULL, NULL, NULL, NULL, NULL, 'NotSupported', 'try', NULL, 'R');
INSERT INTO ADP_TEST.TSP_SERVICE_CONTROL (SYSTEM_CODE, SUB_SYSTEM_CODE, SERVICE_INVOKE_ID, INNER_SERVICE_CODE, INNER_SERVICE_IMPL_CODE, DESCRIPTION, ROUTE_KEYS, CANCEL_SERVICE, CONFIRM_SERVICE, SERVICE_TRANSACTION_MODE, SERVICE_TYPE, REGIST_CALL_LOG, SERVICE_EXECUTOR_TYPE) VALUES('online-demo-A', 'demoA', '*', 'resource2.odevityInvoke', NULL, NULL, NULL, NULL, NULL, 'NotSupported', 'try', NULL, 'R');

INSERT INTO ADP_TEST.TSP_SERVICE_IN (SYSTEM_CODE, SUB_SYSTEM_CODE, OUT_SERVICE_CODE, INNER_SERVICE_CODE, INNER_SERVICE_IMPL_CODE, DESCRIPTION, SERVICE_CATEGORY, ROUTE_KEYS, SERVICE_TYPE, PROTOCOL_ID, IS_ENABLE, TRANSACTION_MODE, LOG_LEVEL, TIMEOUT, ALIAS_MAPPING, FORCE_UNUSED_ODB_CACHE, REGISTER_MODE, SERVICE_GROUP) VALUES('online-demo-A', 'demoA', '/getMessageByName', 'getMessageByName', NULL, NULL, 'T', NULL, NULL, 'rest', '1', 'A', NULL, NULL, '0', '0', '0', NULL);
INSERT INTO ADP_TEST.TSP_SERVICE_IN (SYSTEM_CODE, SUB_SYSTEM_CODE, OUT_SERVICE_CODE, INNER_SERVICE_CODE, INNER_SERVICE_IMPL_CODE, DESCRIPTION, SERVICE_CATEGORY, ROUTE_KEYS, SERVICE_TYPE, PROTOCOL_ID, IS_ENABLE, TRANSACTION_MODE, LOG_LEVEL, TIMEOUT, ALIAS_MAPPING, FORCE_UNUSED_ODB_CACHE, REGISTER_MODE, SERVICE_GROUP) VALUES('online-demo-A', 'demoA', '/resource1/selfInvokeGetOne', 'resource1.selfInvokeGetOne', 'resource1Impl', NULL, 'S', NULL, NULL, 'rest', '1', 'A', NULL, NULL, '0', '0', '0', NULL);
INSERT INTO ADP_TEST.TSP_SERVICE_IN (SYSTEM_CODE, SUB_SYSTEM_CODE, OUT_SERVICE_CODE, INNER_SERVICE_CODE, INNER_SERVICE_IMPL_CODE, DESCRIPTION, SERVICE_CATEGORY, ROUTE_KEYS, SERVICE_TYPE, PROTOCOL_ID, IS_ENABLE, TRANSACTION_MODE, LOG_LEVEL, TIMEOUT, ALIAS_MAPPING, FORCE_UNUSED_ODB_CACHE, REGISTER_MODE, SERVICE_GROUP) VALUES('online-demo-A', 'demoA', '/tranResource2', 'tranResource2', NULL, NULL, 'T', NULL, NULL, 'rest', '1', 'A', NULL, NULL, '0', '0', '0', NULL);
INSERT INTO ADP_TEST.TSP_SERVICE_IN (SYSTEM_CODE, SUB_SYSTEM_CODE, OUT_SERVICE_CODE, INNER_SERVICE_CODE, INNER_SERVICE_IMPL_CODE, DESCRIPTION, SERVICE_CATEGORY, ROUTE_KEYS, SERVICE_TYPE, PROTOCOL_ID, IS_ENABLE, TRANSACTION_MODE, LOG_LEVEL, TIMEOUT, ALIAS_MAPPING, FORCE_UNUSED_ODB_CACHE, REGISTER_MODE, SERVICE_GROUP) VALUES('online-demo-B', 'demoB', '/hello/getMeassageByName', 'hello.getMeassageByName', 'helloImpl', NULL, 'S', NULL, NULL, 'rest', '1', 'A', NULL, NULL, '0', '0', '0', NULL);
INSERT INTO ADP_TEST.TSP_SERVICE_IN (SYSTEM_CODE, SUB_SYSTEM_CODE, OUT_SERVICE_CODE, INNER_SERVICE_CODE, INNER_SERVICE_IMPL_CODE, DESCRIPTION, SERVICE_CATEGORY, ROUTE_KEYS, SERVICE_TYPE, PROTOCOL_ID, IS_ENABLE, TRANSACTION_MODE, LOG_LEVEL, TIMEOUT, ALIAS_MAPPING, FORCE_UNUSED_ODB_CACHE, REGISTER_MODE, SERVICE_GROUP) VALUES('online-demo-B', 'demoB', '/resource2/odevityInvoke', 'resource2.odevityInvoke', 'resource2Impl', NULL, 'S', NULL, NULL, 'rest', '1', 'A', NULL, NULL, '0', '0', '0', NULL);
INSERT INTO ADP_TEST.TSP_SERVICE_IN (SYSTEM_CODE, SUB_SYSTEM_CODE, OUT_SERVICE_CODE, INNER_SERVICE_CODE, INNER_SERVICE_IMPL_CODE, DESCRIPTION, SERVICE_CATEGORY, ROUTE_KEYS, SERVICE_TYPE, PROTOCOL_ID, IS_ENABLE, TRANSACTION_MODE, LOG_LEVEL, TIMEOUT, ALIAS_MAPPING, FORCE_UNUSED_ODB_CACHE, REGISTER_MODE, SERVICE_GROUP) VALUES('online-demo-B', 'demoB', '/resource3/noRuleInvoke', 'resource3.noRuleInvoke', 'resource3Impl', NULL, 'S', NULL, NULL, 'rest', '1', 'A', NULL, NULL, '0', '0', '0', NULL);
INSERT INTO ADP_TEST.TSP_SERVICE_IN (SYSTEM_CODE, SUB_SYSTEM_CODE, OUT_SERVICE_CODE, INNER_SERVICE_CODE, INNER_SERVICE_IMPL_CODE, DESCRIPTION, SERVICE_CATEGORY, ROUTE_KEYS, SERVICE_TYPE, PROTOCOL_ID, IS_ENABLE, TRANSACTION_MODE, LOG_LEVEL, TIMEOUT, ALIAS_MAPPING, FORCE_UNUSED_ODB_CACHE, REGISTER_MODE, SERVICE_GROUP) VALUES('online-demo-B', 'demoB', '/resource3/odevityInvoke', 'resource3.odevityInvoke', 'resource3Impl', NULL, 'S', NULL, NULL, 'rest', '1', 'A', NULL, NULL, '0', '0', '0', NULL);
INSERT INTO ADP_TEST.TSP_SERVICE_IN (SYSTEM_CODE, SUB_SYSTEM_CODE, OUT_SERVICE_CODE, INNER_SERVICE_CODE, INNER_SERVICE_IMPL_CODE, DESCRIPTION, SERVICE_CATEGORY, ROUTE_KEYS, SERVICE_TYPE, PROTOCOL_ID, IS_ENABLE, TRANSACTION_MODE, LOG_LEVEL, TIMEOUT, ALIAS_MAPPING, FORCE_UNUSED_ODB_CACHE, REGISTER_MODE, SERVICE_GROUP) VALUES('online-demo-A', 'demoA', '/custInfo/createCust', 'CustInfo.createCust', 'CustInfoImpl', NULL, 'S', NULL, NULL, 'rest', '1', 'A', NULL, NULL, '0', '0', '0', NULL);
INSERT INTO ADP_TEST.TSP_SERVICE_IN (SYSTEM_CODE, SUB_SYSTEM_CODE, OUT_SERVICE_CODE, INNER_SERVICE_CODE, INNER_SERVICE_IMPL_CODE, DESCRIPTION, SERVICE_CATEGORY, ROUTE_KEYS, SERVICE_TYPE, PROTOCOL_ID, IS_ENABLE, TRANSACTION_MODE, LOG_LEVEL, TIMEOUT, ALIAS_MAPPING, FORCE_UNUSED_ODB_CACHE, REGISTER_MODE, SERVICE_GROUP) VALUES('online-demo-B', 'demoB', '/custInfo/createCust', 'CustInfo.createCust', 'CustInfoImpl', NULL, 'S', NULL, NULL, 'rest', '1', 'A', NULL, NULL, '0', '0', '0', NULL);


INSERT INTO ADP_TEST.TSP_SERVICE_OUT (SYSTEM_CODE, SUB_SYSTEM_CODE, SERVICE_INVOKE_ID, INNER_SERVICE_CODE, OUT_SERVICE_APP, OUT_SERVICE_CODE, OUT_SERVICE_GROUP, OUT_SERVICE_VERSION, DESCRIPTION, PROTOCOL_ID, TIMEOUT, TIMEOUT_REDO_COUNTS, TIMEOUT_CONFIRM, ALIAS_MAPPING, REGIST_CALL_LOG) VALUES('online-demo-A', 'demoA', '*', 'resource2.odevityInvoke', 'online-demo-B', '/resource2/odevityInvoke', 'post', NULL, NULL, 'remote_rest', 0, 0, '0', '0', '0');
INSERT INTO ADP_TEST.TSP_SERVICE_OUT (SYSTEM_CODE, SUB_SYSTEM_CODE, SERVICE_INVOKE_ID, INNER_SERVICE_CODE, OUT_SERVICE_APP, OUT_SERVICE_CODE, OUT_SERVICE_GROUP, OUT_SERVICE_VERSION, DESCRIPTION, PROTOCOL_ID, TIMEOUT, TIMEOUT_REDO_COUNTS, TIMEOUT_CONFIRM, ALIAS_MAPPING, REGIST_CALL_LOG) VALUES('online-demo-A', 'demoA', '*', 'hello.getMeassageByName', 'online-demo-B', '/hello/getMessageByName', 'post', NULL, NULL, 'remote_rest', 0, 0, '0', '0', '0');

