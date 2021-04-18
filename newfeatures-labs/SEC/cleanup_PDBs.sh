#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/SEC
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@PDB1 as sysdba" @close_PDB1_wallet.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_PDB1.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_PDB2.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_PDB_ISOLATED.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_NEW_PDB1.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @close_keystore2.sql

rm -rf /u01/app/oracle/admin/ORCL/tde_keystore/tde



