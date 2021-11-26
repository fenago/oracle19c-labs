#!/bin/bash

cd /home/oracle/labs/solutions/Automatic_SQL_Tuning

sqlplus / as sysdba <<FIN!

connect / as sysdba

set echo on

--
-- Configure the task to run for at most 30 minutes.  The value of the
-- TIME_LIMIT parameter determines the total time allowed for a task execution.
--

select parameter_value
from   dba_advisor_parameters
where  task_name = 'SYS_AUTO_SQL_TUNING_TASK' and
       parameter_name = 'TIME_LIMIT';

exec dbms_sqltune.set_tuning_task_parameter( -
  'SYS_AUTO_SQL_TUNING_TASK', 'TIME_LIMIT', 1800);

select parameter_value
from   dba_advisor_parameters
where  task_name = 'SYS_AUTO_SQL_TUNING_TASK' and
       parameter_name = 'TIME_LIMIT';

--
-- Run the task immediately
--

exec dbms_sqltune.execute_tuning_task('SYS_AUTO_SQL_TUNING_TASK');

FIN!

