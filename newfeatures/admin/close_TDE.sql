set echo on

ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE CONTAINER = ALL;
ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE IDENTIFIED BY Welcome_1 CONTAINER = ALL;
ALTER SYSTEM SET wallet_root = ''  SCOPE=SPFILE;
ALTER SYSTEM RESET tde_configuration SCOPE=BOTH;
shutdown abort
startup
exit
