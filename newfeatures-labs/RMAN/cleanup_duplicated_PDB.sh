#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
# 

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/RMAN
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_PDB1_DUP.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @close_keystore.sql
