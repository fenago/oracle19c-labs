SELECT employee_id, first_name, last_name, salary,
                substr(b.dept_id, instr(b.dept_id,'-')+1) dept_name
FROM  hr.emp a, hr.dept b
WHERE  a.department_id = substr(b.dept_id,1, instr(b.dept_id,'-')-1)
AND salary >= 1000
/