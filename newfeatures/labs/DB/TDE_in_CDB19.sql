set echo on
ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE CONTAINER = ALL;
ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE IDENTIFIED BY Welcome_1 CONTAINER = ALL;

ALTER SYSTEM RESET wallet_root SCOPE=SPFILE;
ALTER SYSTEM RESET tde_configuration SCOPE=BOTH;
ALTER SYSTEM set encrypt_new_tablespaces='DDL' scope=both;

shutdown immediate

host rm -rf  /u02/app/oracle/admin/CDB19/tde_wallet
host rm -rf  /u02/app/oracle/admin/CDB19/tde_keystore
host rm -rf /u01/app/oracle/admin/CDB19/tde_keystore
host mkdir -p  /u02/app/oracle/admin/CDB19/tde_wallet

startup
ADMINISTER KEY MANAGEMENT CREATE KEYSTORE '/u02/app/oracle/admin/CDB19/tde_wallet' IDENTIFIED BY Welcome_1;
ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY Welcome_1 CONTAINER = ALL;
ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY Welcome_1 WITH BACKUP CONTAINER = ALL;

exit
