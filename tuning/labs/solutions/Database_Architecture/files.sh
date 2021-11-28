#!/bin/bash

cd /home/oracle/labs/solutions/Database_Architecture


sqlplus / as sysdba @files.sql

ls -l $ORACLE_HOME/dbs/*orcl*

ls /u01/app/oracle/diag/rdbms/orcl/orcl

ls -l /u01/app/oracle/diag/rdbms/orcl/orcl/trace/alert*
