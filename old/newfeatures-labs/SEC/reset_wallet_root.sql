set echo on
ALTER SYSTEM SET wallet_root = '' SCOPE=SPFILE;
ALTER SYSTEM RESET tde_configuration SCOPE=BOTH;

EXIT