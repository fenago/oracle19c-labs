SELECT /*+ FIRST_ROWS(10) */ employee_id, department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id;