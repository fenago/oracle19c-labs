set echo on
ALTER SYSTEM SET inmemory_automatic_level = OFF;
ALTER SYSTEM SET INMEMORY_SIZE = 450M SCOPE=SPFILE;
exit