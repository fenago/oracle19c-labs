SELECT count(*)
FROM   job_history jh, employees e
WHERE  substr(to_char(e.employee_id),1) = substr(to_char(jh.employee_id),1);

