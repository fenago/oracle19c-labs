-- DISCLAIMER:
-- This script is provided for educational purposes only. It is 
-- NOT supported by Oracle World Wide Technical Support.
-- The script has been tested and appears to work as intended.
-- You should always run new scripts on a test instance initially

set echo on
update hr.employees
set department_id = 90
where job_id = 'IT_PROG'
/
update hr.employees e
set salary = least(e.salary,
(select (min_salary + max_salary)/2 * 1.10
from hr.jobs j
where j.job_id = e.job_id))
where job_id not like 'AD_%'
/
