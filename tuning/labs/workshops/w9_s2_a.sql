select sql_id, plan_hash_value, sql_text 
from v$sqlarea 
where sql_text like 'SELECT /*+ INDEX_COMBINE(cust cust_gender_bix, cust_yob_bix)%';


