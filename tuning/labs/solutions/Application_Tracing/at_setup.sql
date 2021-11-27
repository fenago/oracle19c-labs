set echo on

drop user trace cascade;

create user trace identified by trace default tablespace users temporary tablespace temp;

grant connect, resource, dba to trace;

alter session set container = orclpdb;

drop tablespace tracetbs including contents and datafiles;

drop tablespace tracetbs3 including contents and datafiles;

create tablespace tracetbs 
datafile '/u01/app/oracle/oradata/ORCL/tracetbs.dbf' size 100m
extent management local uniform size 40k;

create tablespace tracetbs3
datafile '/u01/app/oracle/oradata/ORCL/tracetbs3.dbf' size 100m
extent management local uniform size 10m;


connect trace/trace@orclpdb

drop table sales purge;

create table sales as select * from sh.sales;


drop table sales2 purge;

create table sales2 tablespace tracetbs as select * from sh.sales where 1=2;

drop table sales3 purge;

create table sales3 tablespace tracetbs3 as select * from sh.sales where 1=2;

exit;

