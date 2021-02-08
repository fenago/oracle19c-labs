set echo on

select /*ACS_1*/ count(*), max(empno)
from emp
where deptno = :deptno;

