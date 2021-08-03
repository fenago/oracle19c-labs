#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH
cd $HOME/labs/DB
$ORACLE_HOME/bin/sqlplus "system/Welcome_1@pdb1" @create_CITIES.sql
$ORACLE_HOME/bin/sqlldr hr/Welcome_1@pdb1  control=/home/oracle/labs/DB/control_cities.ctl

