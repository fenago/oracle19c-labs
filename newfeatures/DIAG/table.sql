Set echo on
alter system flsuh shared_pool;

drop user diag cascade;
create user diag identified by Welcome_1 ;
grant dba to diag;

create table diag.tab1 (id number(10), num number(10), txt varchar2(1000));

begin
  for i in 1..100000
  loop
  insert into diag.tab1 values (i,i,'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
  end loop;
end;
/

commit;
create index diag.tab1_i on diag.tab1 (id);
exec dbms_stats.gather_table_Stats('diag','tab1')

DECLARE
  l_plans_dropped    PLS_INTEGER;
  BEGIn
  FOR REC IN (SELECT DISTINCT SQL_HANDLE FROM DBA_SQL_PLAN_BASELINES)
  LOOP
  L_PLANS_DROPPED := DBMS_SPM.DROP_SQL_PLAN_BASELINE (
  sql_handle => rec.sql_handle,
 PLAN_NAME    => NULL);
 END LOOP;
END;
/

BEGIN
   FOR REC IN (SELECT DISTINCT name FROM DBA_SQL_PROFILES)
   LOOP
      DBMS_SQLTUNE.DROP_SQL_PROFILE ( name => rec.name);
 END LOOP;
END;
/

begin
    for rec in (select incident_id from v$diag_incident)
    loop
         dbms_sqldiag_internal.i_remove_incident(rec.incident_id);
     end loop;
end;
/
 
exit
