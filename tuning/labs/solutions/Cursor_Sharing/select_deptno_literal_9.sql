set echo on

select /*CS*/ count(*), max(empno) from emp where deptno = 9;

