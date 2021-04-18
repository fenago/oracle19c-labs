#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
# 

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/MULTI
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @cleanup_HR_ROOT.sql

rm -rf /u02/app/oracle/oradata/ORCL/hr_root
