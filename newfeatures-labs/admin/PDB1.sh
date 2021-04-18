#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=fenagodb
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

mkdir -p /u02/app/oracle/oradata/ORCL/pdb1

cd $HOME/labs/admin
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @create_PDB1.sql
