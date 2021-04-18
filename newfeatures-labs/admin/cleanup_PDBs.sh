#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/admin/cleanup_PDBs.sql

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/SEC/delete_rat.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/SEC/close_keystore2.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/SEC/reset_wallet_root.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/MULTI/reset_snapshot.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/SEC/shutdown.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/SEC/startup.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/admin/create_PDB1.sql

rm -rf /u01/app/oracle/admin/ORCL/tde_keystore
rm -rf /home/oracle/replay
