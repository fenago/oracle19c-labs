SELECT empno, deptno, hiredate,
ROW_NUMBER( ) OVER (PARTITION BY
deptno ORDER BY hiredate
NULLS LAST) SRLNO
FROM emp
WHERE deptno IN (10, 20)
ORDER BY deptno, SRLNO
/
