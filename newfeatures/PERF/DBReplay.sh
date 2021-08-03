#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
# 

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

mkdir -p /u02/app/oracle/oradata/ORCL/pdb1

cd /home/oracle/labs/PERF
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/PERF/delete_replay.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/admin/create_PDB1.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/admin/create_PDB19.sql

rm -rf /home/oracle/PDB1/replay


