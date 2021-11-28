SELECT last_name, job_id, salary, department_name
FROM employees, departments
WHERE departments.department_id = employees.department_id 
and not exists
(select * from jobs where employees.salary between min_salary and max_salary);
