SELECT last_name, job_id, salary, department_name FROM employees, departments
WHERE departments.department_id = employees.department_id;
