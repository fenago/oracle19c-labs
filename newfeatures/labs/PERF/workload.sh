#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
# 

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd /home/oracle/labs/PERF
$ORACLE_HOME/bin/sqlplus "system/Welcome_1@PDB1" @/home/oracle/labs/PERF/workload.sql
