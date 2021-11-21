set echo on
ALTER SYSTEM SET wallet_root = '/u01/app/oracle/admin/ORCL/tde_keystore' SCOPE=SPFILE;
ALTER SYSTEM RESET tde_configuration SCOPE=BOTH;

exit
