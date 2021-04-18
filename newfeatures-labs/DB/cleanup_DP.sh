#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/DB

$ORACLE_HOME/bin/sqlplus "system/Welcome_1@pdb1" @drop_SCOTT.sql
rm EXP.LOG import.log
