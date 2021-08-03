set echo off
set termout off
set feedback off
ALTER SYSTEM SET "_system_trig_enabled"=TRUE SCOPE=BOTH;

DROP TRIGGER trig_after_logon;
CREATE TRIGGER trig_after_logon AFTER STARTUP ON DATABASE
BEGIN
EXECUTE IMMEDIATE 'LOCK TABLE audsys.aud$unified IN EXCLUSIVE MODE';
END;
/
exit


