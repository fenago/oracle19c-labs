SELECT /*+INDEX(cust cust_yob_bix) */ *
FROM sh.cust
WHERE cust_year_of_birth < 70
AND cust_gender = 'M'
/
select sql_id, plan_hash_value, sql_text 
from v$sqlarea 
where sql_text like 'SELECT /*+INDEX(cust cust_yob_bix)%';



