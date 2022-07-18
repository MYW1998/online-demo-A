sqlplus /nolog

connect / as sysdba

create tablespace adp_test datafile '/opt/oracle/product/11.2.0.4/dbhome_1/adp_test.dbf' size 1500M autoextend on next 50m maxsize unlimited;
create temporary tablespace adp_test_tmp tempfile '/opt/oracle/product/11.2.0.4/dbhome_1/adp_test_tmp.dbf' size 1500M autoextend on next 50m maxsize unlimited;
create user adp_test identified by 123456 default tablespace adp_test temporary tablespace adp_test_tmp;
--赋予create session的权限  
grant create session to adp_test;
--分配创建表，视图，触发器，序列，过程 权限  
grant create table,create view,create trigger, create sequence,create procedure to adp_test;
--授权使用表空间
grant unlimited tablespace to adp_test;