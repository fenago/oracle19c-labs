#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/HA
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@PDB1 as SYSDBA" @DML.sql
