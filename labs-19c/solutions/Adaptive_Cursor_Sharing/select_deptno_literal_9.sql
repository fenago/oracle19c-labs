set echo on

select /*ACS_L9*/ count(*), max(empno)
from emp
where deptno = 9;

