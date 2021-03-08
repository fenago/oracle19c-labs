set echo on

connect trace/trace

update sales set amount_sold=amount_sold+1;

exec dbms_lock.sleep(60);

rollback;

-- Run_tracep6 Finished
exit;

