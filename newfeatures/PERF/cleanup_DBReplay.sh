#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
# 

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/PERF
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@PDB1 as sysdba" @delete_replay.sql
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@PDB19 as sysdba" @delete_replay.sql

rm -rf /home/oracle/PDB1/replay

