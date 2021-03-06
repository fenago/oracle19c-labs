#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=fenagodb
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/MULTI
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_PDB_1.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_PDB_2.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_PDB_1_FROM_FIRST_SNAP.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_PDB_1_FROM_SECOND_SNAP.sql
rm -rf /u02/app/oracle/oradata/ORCL/pdb_1
rm -rf /u02/app/oracle/oradata/ORCL/pdb_2
rm -rf /u02/app/oracle/oradata/ORCL/pdb_1_from_first_snap
rm -rf /u02/app/oracle/oradata/ORCL/pdb_1_from_second_snap

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/MULTI/reset_snapshot.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/SEC/shutdown.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/SEC/startup.sql
