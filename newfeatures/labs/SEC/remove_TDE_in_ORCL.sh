#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/SEC/open_keystore.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/SEC/decrypt_TBS.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/SEC/close_keystore.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/admin/create_PDB1.sql

rm -rf  /u02/app/oracle/admin/ORCL/tde_wallet
rm -rf  /u01/app/oracle/admin/ORCL/tde_wallet
rm -rf  /u02/app/oracle/admin/ORCL/tde_keystore
rm -rf  /u01/app/oracle/admin/ORCL/tde_keystore
