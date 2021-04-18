#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/SEC
rm -rf  /u01/app/oracle/admin/ORCL/tde_keystore/*

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @close_keystore.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @shutdown.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @startup.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @open_keystore.sql
