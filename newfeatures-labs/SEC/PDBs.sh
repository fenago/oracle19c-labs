#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

mkdir -p /u02/app/oracle/oradata/ORCL/pdb1
mkdir -p /u02/app/oracle/oradata/ORCL/pdb2

cd $HOME/labs/SEC

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @set_CDB_wallet_root.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @shutdown.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @startup.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @set_tde_config.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @create_CDB_keystore.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @create_PDB1.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @create_PDB2.sql



