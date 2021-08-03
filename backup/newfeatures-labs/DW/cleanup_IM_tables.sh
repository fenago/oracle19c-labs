#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=fenagodb
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/DW
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/admin/create_PDB1.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @disable_inmemory_size.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @shutdown.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @startup.sql






