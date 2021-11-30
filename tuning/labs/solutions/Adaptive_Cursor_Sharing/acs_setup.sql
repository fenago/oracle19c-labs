set echo on
alter session set container = orclpdb; 
drop user acs cascade;

create user acs identified by acs default tablespace users temporary tablespace temp;

grant dba, connect to acs;

connect acs/acs@orclpdb

drop table emp purge;

create table emp
(
 empno   number,
 ename   varchar2(20),
 phone   varchar2(20),
 deptno  number
);


insert into emp
  with tdata as
       (select rownum empno
         from all_objects
         where rownum <= 1000)
  select rownum,
         dbms_random.string ('u', 20),
         dbms_random.string ('u', 20),
         case
                when rownum/100000 <= 0.001 then mod(rownum, 10)
                else 10
         end
    from tdata a, tdata b
   where rownum <= 100000;

create index emp_i1 on emp(deptno);

exec dbms_stats.gather_table_stats(null, 'EMP', METHOD_OPT => 'FOR COLUMNS DEPTNO SIZE 10', CASCADE => TRUE);

alter system flush shared_pool;

exit;

