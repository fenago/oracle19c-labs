select dbms_crypto.hash(utl_raw.cast_to_raw(last_name),3)
from hr.employees
/
select dbms_crypto.hash(utl_raw.cast_to_number(salary),3)
from hr.employees
/
