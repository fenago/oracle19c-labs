SELECT ename,  job,  sal,  dname
FROM emp,  dept
WHERE dept.deptno = emp.deptno
and not exists 
(select * from salgrade where emp.sal between losal and hisal);
