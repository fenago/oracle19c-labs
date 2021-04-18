#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
# 

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

mkdir -p /u02/app/oracle/oradata/ORCL/hr_root
mkdir -p /u02/app/oracle/oradata/ORCL/hr_root/operations
mkdir -p /u02/app/oracle/oradata/ORCL/hr_root/sales

cd $HOME/labs/MULTI
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/admin/create_PDB1.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @create_HR_ROOT.sql
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@hr_root AS SYSDBA" @create_HR_APP.sql
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@hr_root AS SYSDBA" @create_OPERATIONS.sql
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@hr_root AS SYSDBA" @create_SALES.sql
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@hr_root AS SYSDBA" @sync.sql
