#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH
rm -rf /u02/app/oracle/admin/ORCL/tde_wallet
mkdir -p /u02/app/oracle/admin/ORCL/tde_wallet
cp $HOME/labs/admin/sqlnet.ora $ORACLE_HOME/network/admin/sqlnet.ora
lsnrctl stop
lsnrctl start

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/DB/drop_PDBs.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/DB/TDE_in_ORCL.sql

export ORACLE_SID=CDB19
PATH=$ORACLE_HOME/bin:$PATH; export PATH
rm -rf /u02/app/oracle/admin/CDB19/tde_wallet
mkdir -p /u02/app/oracle/admin/CDB19/tde_wallet
lsnrctl stop
lsnrctl start

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/DB/TDE_in_CDB19.sql

