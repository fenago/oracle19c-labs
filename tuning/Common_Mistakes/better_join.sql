SELECT count(*)
FROM   job_history jh, employees e
WHERE  e.employee_id = jh.employee_id;

