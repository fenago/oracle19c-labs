declare
  vrun   number;
BEGIN
   vrun := SYS.DBMS_PROFILER.start_profiler('FIRSTRUN');
    dbms_output.put_line ('START PROFILER STATUS ' || vrun);
    call_big;   -- call the procedure
    vrun := SYS.DBMS_PROFILER.stop_profiler;
    DBMS_OUTPUT.put_line ('STOP PROFILER STATUS ' || vrun);
    DBMS_OUTPUT.put_line ('0   successful ');
    DBMS_OUTPUT.put_line ('1   incorrect parameterl ');
    DBMS_OUTPUT.put_line ('2   data flush operation failed ');
    DBMS_OUTPUT.put_line ('-1   version mismatch between package and tables ');
END;
/
