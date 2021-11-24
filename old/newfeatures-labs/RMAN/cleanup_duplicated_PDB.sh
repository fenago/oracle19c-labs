#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=fenagodb
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/RMAN
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_PDB1_DUP.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @close_keystore.sql
