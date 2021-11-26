#!/bin/bash

cd /home/oracle/labs/solutions/Automatic_SQL_Tuning

sqlplus / as sysdba <<FIN!

set echo on

exec dbms_workload_repository.create_snapshot;

FIN!

