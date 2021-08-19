set echo on

set timing on
set autotrace traceonly
set linesize 200

alter session set workarea_size_policy=manual;
alter session set sort_area_size=50000;
alter session set hash_area_size=5000;


select * from emp,dept where emp.deptno=dept.deptno and emp.deptno > 800;

set autotrace off
set timing off;

