set echo on
CREATE USER test IDENTIFIED BY Welcome_1;
GRANT dba TO test;

CREATE OR REPLACE DIRECTORY ext_dir AS '/home/oracle/labs/DW';
GRANT read, write ON DIRECTORY ext_dir TO test;
exit
