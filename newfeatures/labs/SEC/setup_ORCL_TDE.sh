#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH
export ORACLE_SID=ORCL
rm -rf /u02/app/oracle/admin/ORCL/tde_wallet
mkdir -p /u02/app/oracle/admin/ORCL/tde_wallet
lsnrctl stop
lsnrctl start

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/SEC/TDE_in_ORCL.sql
