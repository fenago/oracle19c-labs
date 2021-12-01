set    termout off
store  set sqlplus_settings replace
save   buffer.sql replace
set    timing off heading off verify off autotrace off feedback off

spool alter_cust_idx.sql

SELECT 'ALTER index '||i.index_name||' INVISIBLE;'
FROM   user_indexes i
WHERE  i.table_name = 'CUSTOMERS'
AND    NOT EXISTS
      (SELECT 'x'
       FROM   user_constraints c
       WHERE  c.index_name = i.index_name
       AND    c.table_name = i.table_name
       AND    c.status = 'ENABLED');

spool off

@alter_cust_idx.sql

get    buffer.sql nolist
@sqlplus_settings
set    termout on

