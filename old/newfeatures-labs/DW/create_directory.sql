set echo on
CREATE OR REPLACE DIRECTORY dp_dir as '/home/oracle/labs/DB';
GRANT read, write ON DIRECTORY dp_dir TO scott;
exit
