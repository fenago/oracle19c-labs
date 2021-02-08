set echo on

exec dbms_workload_repository.create_snapshot;

variable window varchar2(20);

begin
 select upper(to_char(sysdate,'fmday'))||'_WINDOW' into :window from dual;
end;
/

print window;

--
-- Open the corresponding maintenance window, but with other clients disabled
--

alter system set "_enable_automatic_maintenance"=1
/

exec dbms_auto_task_admin.disable( -
  'auto space advisor', null, :window);

exec dbms_auto_task_admin.disable( -
  'sql tuning advisor', null, :window);


exec dbms_scheduler.open_window(:window, null, true);

--
-- Close the maintenance window when auto optimizer stats collection is done
--


exec dbms_lock.sleep(120);

exec dbms_scheduler.close_window(:window);


alter system set "_enable_automatic_maintenance"=0
/

--
-- Re-enable the other guys so they look like they are enabled in EM.
-- Still they will be disabled because we have set the underscore.
--

exec dbms_auto_task_admin.enable( -
  'auto space advisor', null, :window);

exec dbms_auto_task_admin.enable( -
  'sql tuning advisor', null, :window);

exit;

