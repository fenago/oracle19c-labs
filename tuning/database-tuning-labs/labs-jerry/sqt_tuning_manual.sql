-- Manual tuning set
DECLARE
  v_sql_text               VARCHAR2(1000);
  v_sql_tune_task_id       VARCHAR2(100);
BEGIN
  v_sql_text := 'SELECT b1.bigno, b1.bname,b2.bcomments '||
        ' FROM big b1 join bigpart '||
        ' using(bigno)'||
        ' WHERE b1.bigno between 1000000 and 15000000 AND b2.comments like '%TEST%'';
  v_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
                          sql_text    => v_sql_text,
                          bind_list   => sql_binds(anydata.ConvertNumber(100)),
                          user_name   => 'HR',
                          scope       => DBMS_SQLTUNE.scope_comprehensive,
                          time_limit  => 1000,
                          task_name   => 'test_tuning_task',
                          description => 'Tuning task for a problematic query...');
  DBMS_OUTPUT.put_line('v_sql_tune_task_id: ' || v_sql_tune_task_id);
END; 
-- execute the tuning task
SQL> EXECUTE DBMS_SQLTUNE.execute_tuning_task(task_name => 'test_tuning_task'); 
-- Monitor tuning task
SQL> SELECT TASK_NAME, STATUS FROM DBA_ADVISOR_LOG WHERE UPPER(TASK_NAME)='TEST_TUNING_TASK'
-- Get the report
SQL> SET LONG 1000
SQL> SET LONGCHUNKSIZE 1000
SQL> SET LINESIZE 100
SQL> SELECT DBMS_SQLTUNE.REPORT_TUNING_TASK( 'test_tuning_task' ) FROM DUAL;
/
