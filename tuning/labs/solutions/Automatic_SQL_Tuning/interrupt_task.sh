#!/bin/bash

cd /home/oracle/solutions/Automatic_SQL_Tuning

sqlplus / as sysdba <<FIN!

connect / as sysdba

set echo on

--
-- Interrupt the task
--

exec dbms_sqltune.interrupt_tuning_task('SYS_AUTO_SQL_TUNING_TASK');

FIN!

