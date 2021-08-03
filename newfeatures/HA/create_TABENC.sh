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

cd $HOME/labs/DB
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @TDE_in_ORCL.sql
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@PDB1 as SYSDBA" @open_set_key.sql
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@PDB1 as sysdba" @/home/oracle/labs/DB/create_TABENC.sql

export ORACLE_SID=DUPORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH
rm -rf /u02/app/oracle/admin/DUPORCL/tde_wallet
mkdir -p /u02/app/oracle/admin/DUPORCL/tde_wallet
lsnrctl stop
lsnrctl start

cd $HOME/labs/DB
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @TDE_in_DUPORCL.sql
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@PDB19_IN_DUPORCL as SYSDBA" @open_set_key.sql

