set echo on

select /*ACS_L10*/ count(*), max(empno)
from emp
where deptno = 10;

