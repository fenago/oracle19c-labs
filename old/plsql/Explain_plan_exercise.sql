explain plan set statement_id = 'Test2qry'
for
select department_name,city,state_province
from departments d, locations l
 where d.location_id = l.location_id
/
