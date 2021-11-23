#!/bin/bash

cd /home/oracle/solutions/Trace_Event

sqlplus / as sysdba @te_setup.sql

ls /u01/app/oracle/diag/rdbms/orcl/orcl/trace | grep MYOPTIMIZER

cp /u01/app/oracle/diag/rdbms/orcl/orcl/trace/*MYOPTIMIZER.trc myoptimizer.trc

