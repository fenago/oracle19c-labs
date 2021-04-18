set echo on
ALTER SYSTEM SET tde_configuration = 'KEYSTORE_CONFIGURATION=FILE';
ADMINISTER KEY MANAGEMENT CREATE KEYSTORE IDENTIFIED BY Welcome_1;
ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY Welcome_1 container=all;
ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY Welcome_1 WITH BACKUP container=all;
CONNECT sys/fenago@PDB1 as sysdba
ALTER SYSTEM SET tde_configuration = 'KEYSTORE_CONFIGURATION=FILE';
ADMINISTER KEY MANAGEMENT CREATE KEYSTORE IDENTIFIED BY Welcome_1;
ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY Welcome_1 WITH BACKUP;
CONNECT / AS SYSDBA
ADMINISTER KEY MANAGEMENT DELETE SECRET FOR CLIENT 'oracle.rat.database_replay.encryption'
        IDENTIFIED BY Welcome_1 with backup;
exit
