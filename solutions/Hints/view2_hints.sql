SELECT /*+ NO_MERGE(v2) INDEX(v2.v1.employees emp_emp_id_pk) 
          FULL(v2.departments) */ *
FROM   v2
WHERE  department_id = 30;

