#!/bin/bash

cd /home/oracle/labs/solutions/Application_Tracing

yes | rm -f /u01/app/oracle/diag/rdbms/orcl/orcl/trace/*mytrace*.*

rm -f mytrace.trc

rm -f myreport.txt

rm -f myreport2.txt

# rm $ORACLE_HOME/network/admin/tnsnames.ora

# mv $ORACLE_HOME/network/admin/tnsnames.ora.bak1 $ORACLE_HOME/network/admin/tnsnames.ora

# sqlplus / as sysdba @at_cleanup.sql

