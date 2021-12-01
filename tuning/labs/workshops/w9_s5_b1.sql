SELECT /*+ INDEX_COMBINE(cust cust_gender_bix, cust_yob_bix) */ *
FROM sh.cust
WHERE cust_year_of_birth < 70
AND cust_gender = 'M'
/

select sql_id, sql_plan_baseline from v$sqlarea where sql_text like 'SELECT /*+ INDEX_COMBINE(cust%';
