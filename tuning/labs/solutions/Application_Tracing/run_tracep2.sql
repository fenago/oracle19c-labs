set echo on

connect trace/trace@orclpdb

alter session set tracefile_identifier='mytraceP2';

set timing on

declare
   c      number := dbms_sql.open_cursor;
   oname  varchar2(50);
   ignore integer;
begin
  for i in 1 .. 5000 loop
    dbms_sql.parse(c,'select object_name from dba_objects where object_id = '||i , dbms_sql.native);  -- use literal
    dbms_sql.define_column(c, 1, oname, 50);
    ignore := dbms_sql.execute(c);
    if dbms_sql.fetch_rows(c)>0 then 
      dbms_sql.column_value(c, 1, oname);
    end if;
  end loop;
  dbms_sql.close_cursor(c);
end;
/



connect trace/trace@orclpdb

alter session set tracefile_identifier='mytraceS2';

declare
   c number := dbms_sql.open_cursor;
   oname  varchar2(50);
   ignore integer;
begin
   dbms_sql.parse(c,'select object_name from dba_objects where object_id = :y' , dbms_sql.native); -- use bind var
   for i in 1 .. 5000 loop
     dbms_sql.bind_variable(c,':y',i);
     dbms_sql.define_column(c, 1, oname, 50);
     ignore := dbms_sql.execute(c);
     if dbms_sql.fetch_rows(c)>0 then 
       dbms_sql.column_value(c, 1, oname);
    end if;
   end loop;
   dbms_sql.close_cursor(c);
end;
/

exit;

