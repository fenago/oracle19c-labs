var res number ;
exec :res := dbms_spm.load_plans_from_cursor_cache(sql_id => <<'Please enter the SQL_ID value'>>, plan_hash_value=> <<'Please enter the PLAN_HASH_VALUE value here'>>)
/


