set echo on
ALTER DATABASE MOUNT;
ALTER DATABASE OPEN;
set echo off
set termout off
set feedback off
LOCK TABLE audsys.aud$unified IN EXCLUSIVE MODE;
host  sleep  1800
exit