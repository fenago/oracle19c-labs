#!/bin/bash

cd /home/oracle/solutions/Application_Tracing

rm /u01/app/oracle/diag/rdbms/orcl/orcl/trace/*mytrace*.*

rm mytrace.trc

rm myreport.txt

rm myreport2.txt

rm $ORACLE_HOME/network/admin/tnsnames.ora

mv $ORACLE_HOME/network/admin/tnsnames.ora.bak1 $ORACLE_HOME/network/admin/tnsnames.ora

sqlplus / as sysdba @at_cleanup.sql

