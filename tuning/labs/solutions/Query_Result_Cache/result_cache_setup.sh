#!/bin/bash

cd /home/oracle/labs/solutions/Query_Result_Cache

sqlplus / as sysdba <<FIN!

set echo on
alter session set container = orclpdb; 

drop user qrc cascade;

create user qrc identified by qrc
default tablespace users
temporary tablespace temp;

grant connect, resource, dba to qrc;

connect qrc/qrc@orclpdb

exec dbms_result_cache.flush;

drop table cachejfv purge;

create table cachejfv(c varchar2(500)) tablespace users;

insert into cachejfv values('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;
insert into cachejfv select * from cachejfv;

insert into cachejfv values('b');

commit;

alter system flush buffer_cache;

FIN!

