#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH
$ORACLE_HOME/bin/dbca -silent -deleteDatabase -sourceDB ORCL -sid ORCL -sysPassword Welcome_1

$ORACLE_HOME/bin/dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbname ORCL -sid ORCL -createAsContainerDatabase true -numberOfPDBs 1 -pdbName PDB1 -useLocalUndoForPDBs true -responseFile NO_VALUE -characterSet AL32UTF8 -totalMemory 1800 -sysPassword Welcome_1 -systemPassword Welcome_1 -pdbAdminPassword Welcome_1 -dbsnmpPassword Welcome_1 -enableArchive true -recoveryAreaDestination /u03/app/oracle/fast_recovery_area -recoveryAreaSize 15000 -datafileDestination /u02/app/oracle/oradata
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/admin/profile.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/admin/flashback.sql
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@pdb1 as sysdba" @/home/oracle/labs/admin/profile.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/SEC/TDE_in_ORCL.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/SEC/close_keystore.sql
