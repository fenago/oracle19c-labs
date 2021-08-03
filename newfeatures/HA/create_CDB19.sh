#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=CDB19
PATH=$ORACLE_HOME/bin:$PATH; export PATH

$ORACLE_HOME/bin/dbca -silent -deleteDatabase -sourceDB CDB19 -sid CDB19 -sysPassword Welcome_1
$ORACLE_HOME/bin/dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbname CDB19 -sid CDB19 -createAsContainerDatabase true -numberOfPDBs 1 -pdbName pdb19  -useLocalUndoForPDBs true -responseFile NO_VALUE -characterSet AL32UTF8 -totalMemory 1800 -sysPassword Welcome_1 -systemPassword Welcome_1 -pdbAdminPassword Welcome_1 -dbsnmpPassword Welcome_1 -enableArchive true -recoveryAreaDestination /u03/app/oracle/fast_recovery_area -recoveryAreaSize 15000 -datafileDestination /u02/app/oracle/oradata
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/admin/profile.sql

exit
