#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=DUPORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH

$ORACLE_HOME/bin/dbca -silent -deleteDatabase -sourceDB DUPORCL -sid DUPORCL -sysPassword Welcome_1

rm -rf /u01/app/oracle/diag/rdbms/DUPORCL
rm -rf /u03/app/oracle/fast_recovery_area/DUPORCL
