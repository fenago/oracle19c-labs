#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=fenagodb
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/DB
$ORACLE_HOME/bin/sqlplus "sys/fenago@pdb1 AS SYSDBA" @drop_part_list.sql