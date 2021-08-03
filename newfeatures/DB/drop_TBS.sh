#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=DUPORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH
cd $HOME/labs/DB
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@pdb19_in_orcl as sysdba" @/home/oracle/labs/DB/drop_TBS.sql
