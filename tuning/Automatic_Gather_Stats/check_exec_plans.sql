set echo on

set linesize 200 pagesize 1000

set autotrace on

select count(*), max(empno) from emp where deptno = 9;

select count(*), max(empno) from emp where deptno = 10;

set autotrace off

