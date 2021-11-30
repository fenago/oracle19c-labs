-- run with sqlplus /nolog @shc_setup.sql
connect / as sysdba
alter session set container = orclpdb;

drop user shc cascade;

create user shc identified by shc;
Grant DBA to SHC;
GRANT select_catalog_role to SHC;
GRANT select any dictionary to SHC;

connect shc/shc@orclpdb

set echo on

set linesize 200

drop cluster bigemp_cluster including tables;

CREATE CLUSTER bigemp_cluster
(deptno number, sal number sort) 
HASHKEYS 10000
single table HASH IS deptno SIZE 50
tablespace users;

create table bigemp_fact (
empno number primary key, sal number sort, job varchar2(12) not null,
deptno number not null, hiredate date not null)
CLUSTER bigemp_cluster (deptno, sal);


begin
for i in 1..1400000 loop
 insert into bigemp_fact values(i,i,'J1',10,sysdate); 
end loop;
commit;
end;
/

begin
for i in 1..1400000 loop
 insert into bigemp_fact values(1400000+i,i,'J1',20,sysdate); 
end loop;
commit;
end;
/


exec dbms_stats.gather_schema_stats('SHC');

exit
