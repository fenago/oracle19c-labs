#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=fenagodb
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/MULTI
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_PDB_REFRESHED.sql

rm -rf /u02/app/oracle/oradata/ORCL/pdb_refreshed 
