var res number;
exec :res := dbms_spm.load_plans_from_cursor_cache(sql_id=> <<'Please enter the &hinted_SQL_ID value'>>, plan_hash_value=> <<' Please enter the &hinted_PLAN_HASH_VALUE value'>> , sql_handle=> <<'Please enter the SQL_HANDLE_for_orginal value'>>);
