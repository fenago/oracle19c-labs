variable empid number
exec :empid := 190

SELECT * FROM hr.emp WHERE emp_id = :empid
/

select sql_id, plan_hash_value,sql_text
from v$sqlarea
where sql_text='SELECT * FROM hr.emp WHERE emp_id = :empid';
