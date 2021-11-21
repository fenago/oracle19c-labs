#!/bin/sh
# use bash shell
#
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/admin/alter_pass.sql
$ORACLE_HOME/bin/sqlplus "sys/fenago@pdb1 as sysdba" @/home/oracle/labs/admin/hr_main.sql Welcome_1 users temp /tmp
exit
