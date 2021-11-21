#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=fenagodb
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH


mkdir -p /u02/app/oracle/oradata/ORCL/pdb1

cd $HOME/labs/SEC
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @delete_rat.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @set_CDB_wallet_root.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @shutdown.sql

rm -rf /u01/app/oracle/admin/ORCL/tde_keystore/tde/*

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @startup.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @set_tde_config.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @create_CDB_keystore.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @create_PDB1.sql
$ORACLE_HOME/bin/sqlplus "sys/fenago@PDB1 as sysdba" @open_PDB1_keystore.sql
$ORACLE_HOME/bin/sqlplus "sys/fenago@PDB1 as sysdba" @set_PDB1_key.sql

cd $HOME/labs/DB

$ORACLE_HOME/bin/sqlplus "sys/fenago@pdb1 AS SYSDBA" @part_hash.sql
