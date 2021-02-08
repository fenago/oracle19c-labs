#!/bin/bash

cd /home/oracle/solutions/Automatic_SQL_Tuning

sqlplus / as sysdba <<FIN!

set echo on

alter system flush shared_pool;

--
-- Turn off AUTOTASK
--

alter system set "_enable_automatic_maintenance"=0;

--
-- Clear out old executions of auto-sqltune
--

exec dbms_sqltune.reset_tuning_task('SYS_AUTO_SQL_TUNING_TASK');

--
-- Drop any profiles on AST queries
--

declare
  cursor prof_names is
    select name from dba_sql_profiles where sql_text like '%AST%';
begin
  for prof_rec in prof_names loop
    dbms_sqltune.drop_sql_profile(prof_rec.name);
  end loop;
end;
/

-- Set AST to automatically implement profiles

exec DBMS_SQLTUNE.SET_AUTO_TUNING_TASK_PARAMETER('ACCEPT_SQL_PROFILES','TRUE');

FIN!

