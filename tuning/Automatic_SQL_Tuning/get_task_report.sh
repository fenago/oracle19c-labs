#!/bin/bash

cd /home/oracle/solutions/Automatic_SQL_Tuning

sqlplus / as sysdba <<FIN!

set echo on
set long 1000000000
set longchunksize 1000

--
-- Check the execution names
--
alter session set nls_date_format = 'MM/DD/YYYY HH24:MI:SS';

select execution_name, status, execution_start
from   dba_advisor_executions
where  task_name = 'SYS_AUTO_SQL_TUNING_TASK'
order by execution_start;

variable last_exec varchar2(30);

begin
  select max(execution_name) keep (dense_rank last order by execution_start)
  into   :last_exec
  from   dba_advisor_executions
  where  task_name = 'SYS_AUTO_SQL_TUNING_TASK';
end;
/

print :last_exec

--
-- Find the object ID for query AST with sql_id by9m5m597zh19
--

variable obj_id number;

begin
  select object_id
  into   :obj_id
  from   dba_advisor_objects
  where  task_name = 'SYS_AUTO_SQL_TUNING_TASK' and
         execution_name = :last_exec and
         type = 'SQL' and
         attr1 = 'by9m5m597zh19';
end;
/

print :obj_id

--
-- Get a text report to drill down on this one query
--
set pagesize 0
select dbms_sqltune.report_auto_tuning_task(
  :last_exec, :last_exec, 'TEXT', 'TYPICAL', 'ALL', :obj_id)
from dual;

FIN!

