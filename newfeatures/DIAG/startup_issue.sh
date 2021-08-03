#!/bin/sh
# use bash shell
#
# Written by:  Dominique Jeunot
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/DIAG/lock.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/DIAG/shutdown.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/DIAG/startup.sql

