$ORACLE_HOME/bin/dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbname CDBTEST -sid CDBTEST -createAsContainerDatabase true -numberOfPDBs 0 -useLocalUndoForPDBs true -responseFile NO_VALUE -totalMemory 1800 -sysPassword password   -systemPassword password   -pdbAdminPassword password   -emConfiguration DBEXPRESS -dbsnmpPassword password   -emExpressPort 5502 -enableArchive true -recoveryAreaDestination /u01/app/oracle/fast_recovery_area -recoveryAreaSize 15000 -datafileDestination /u01/app/oracle/oradata
