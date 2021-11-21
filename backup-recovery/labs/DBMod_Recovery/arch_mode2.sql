 set FEEDBACK OFF
 set pagesize 0
spool /tmp/archivelogtest.log
 select log_mode from V$DATABASE;
spool off
exit
