create or replace trigger set_cursor_sharing 
after logon 
on database
declare
begin
      if user  = 'SH' then execute immediate 'alter session set cursor_sharing=<value>';
      end if;
exception
     when others then 
             null;
end;
/
