set echo on

select deptno, count(*) cnt_per_deptno, (count(*)*100)/nr deptno_percent
from emp, (select max(empno) nr
          from emp)
group by deptno, nr
order by deptno;

