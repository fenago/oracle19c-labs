set echo on
ALTER SYSTEM SET tde_configuration = 
                     'KEYSTORE_CONFIGURATION=FILE' 
                      SCOPE=BOTH;
ADMINISTER KEY MANAGEMENT CREATE KEYSTORE IDENTIFIED BY Welcome_1;
ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY Welcome_1 container=all;
ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY Welcome_1 WITH BACKUP container=all;
exit
