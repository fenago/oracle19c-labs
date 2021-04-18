#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=fenagodb
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/DB

$ORACLE_HOME/bin/sqlplus "system/fenago@pdb1" @$HOME/labs/admin/create_PDB1.sql
$ORACLE_HOME/bin/sqlplus "system/fenago@pdb1" @create_SCOTT.sql
$ORACLE_HOME/bin/sqlplus "system/fenago@pdb1" @DDL.sql


