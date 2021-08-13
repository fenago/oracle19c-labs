export ORACLE_HOME=/u01/app/oracle/product/19.1.0/dbhome_1
$ORACLE_HOME/bin/dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbname CDB19 -sid CDB19 -createAsContainerDatabase true -numberOfPDBs 0 -useLocalUndoForPDBs true -responseFile NO_VALUE -characterSet AL32UTF8 -totalMemory 1800 -sysPassword password -systemPassword password -pdbAdminPassword password -enableArchive true -recoveryAreaDestination /u03/app/oracle/fast_recovery_area -recoveryAreaSize 15000 -datafileDestination /u02/app/oracle/oradata