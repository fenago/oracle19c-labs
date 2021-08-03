#!/bin/sh
# use bash shell
#
# Written by:  Dominique Jeunot
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH

$ORACLE_HOME/bin/sqlplus "system/Welcome_1@PDB1" @/home/oracle/labs/DIAG/table.sql
