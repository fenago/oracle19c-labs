#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/admin/alter_pass.sql
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@pdb1 as sysdba" @/home/oracle/labs/admin/hr_main.sql Welcome_1 users temp /tmp
exit
