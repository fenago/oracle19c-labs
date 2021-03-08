Set SERVEROUTPUT ON
DECLARE
 WINDOW VARCHAR2 (20);
BEGIN

 DBMS_WORKLOAD_REPOSITORY.CREATE_SNAPSHOT;
 
 SELECT UPPER(TO_CHAR(SYSDATE,'fmday'))||'_WINDOW' INTO WINDOW FROM DUAL;
 DBMS_OUTPUT.PUT_LINE('Window is: '|| WINDOW);
--
-- Open the corresponding maintenance window, but with other clients disabled
--
 EXECUTE IMMEDIATE 'alter system set "_enable_automatic_maintenance"=1';
 
 dbms_auto_task_admin.disable('auto space advisor', null, window);
 dbms_auto_task_admin.disable('sql tuning advisor', null, window);

 dbms_scheduler.open_window(window, null, true);
--
-- Close the maintenance window when auto optimizer stats collection is done
--
 DBMS_LOCK.SLEEP(120);
 
 dbms_scheduler.close_window(window);

 EXECUTE IMMEDIATE 'alter system set "_enable_automatic_maintenance"=0';
--
-- Re-enable the other guys so they look like they are enabled in EM.
-- Still they will be disabled because we have set the underscore.   
--
 dbms_auto_task_admin.enable('auto space advisor', null, window);
 dbms_auto_task_admin.enable('sql tuning advisor', null, window);

end;