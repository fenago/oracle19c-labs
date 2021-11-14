#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=CDB19
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/DB
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @alter_CDB19.sql


