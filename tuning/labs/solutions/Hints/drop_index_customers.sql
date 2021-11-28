REM    drop all indexes on CUSTOMERS table
REM    does not touch indexes associated with constraints
REM    ==================================================

set    termout off
store  set sqlplus_settings replace
save   buffer.sql replace
set    heading off verify off autotrace off feedback off

spool  dait.sql

SELECT 'drop index '||i.index_name||';'
FROM   user_indexes i
WHERE  i.table_name = 'CUSTOMERS'
AND    NOT EXISTS
      (SELECT 'x'
       FROM   user_constraints c
       WHERE  c.index_name = i.index_name
       AND    c.table_name = i.table_name
       AND    c.status = 'ENABLED');

spool  off

get    buffer.sql nolist
@sqlplus_settings
set    termout on

set echo on

@dait


