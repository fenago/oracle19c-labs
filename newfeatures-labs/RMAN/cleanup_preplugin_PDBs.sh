#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/RMAN
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_PDB1.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_ORCL_PDB1.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @close_keystore.sql
