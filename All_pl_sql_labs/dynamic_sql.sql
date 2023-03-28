create or replace procedure disable_prim_key
as
 cursor get_prim_info
  is
   select table_name
    from user_tables
     where table_name in (select table_name
      from user_constraints
      where constraint_type = 'P')
     and table_name not like 'BIN%'
     and iot_type is null;
     v_sql_stmt varchar2(250);
 begin
   for con_rec in get_prim_info loop
    v_sql_stmt := 'alter table '||con_rec.table_name||' disable primary key cascade';
    dbms_output.put_line(v_sql_stmt);
    execute immediate v_sql_stmt;
   end loop;
end;
/

set serveroutput on;

select table_name,constraint_name,constraint_type,status
    from user_constraints
     where constraint_type = 'P';
     
exec disable_prim_key;

create or replace procedure enable_prim_key
as
 cursor get_prim_info
  is
   select table_name,status
    from user_constraints
     where constraint_type = 'P'
     and status <> 'ENABLED';
     v_sql_stmt varchar2(250);
 begin
   for con_rec in get_prim_info loop
    v_sql_stmt := 'alter table '||con_rec.table_name||' enable primary key';
    dbms_output.put_line(v_sql_stmt);
    execute immediate v_sql_stmt;
   end loop;
end;
/

exec enable_prim_key;

select table_name,constraint_name,constraint_type,status
    from user_constraints
     where constraint_type = 'P';
     