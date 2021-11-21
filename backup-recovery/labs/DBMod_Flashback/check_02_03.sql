-- DISCLAIMER:
-- This script is provided for educational purposes only. It is 
-- NOT supported by Oracle World Wide Technical Support.
-- The script has been tested and appears to work as intended.
-- You should always run new scripts on a test instance initially

select e.department_id, department_name, COUNT(*)
from bar.barcopy E, bar.bardept D
where e.department_id = D.department_id 
group by e.department_id, department_name
/
