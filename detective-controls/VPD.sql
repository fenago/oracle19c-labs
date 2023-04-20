select object_name,object_type,owner
from dba_objects
where owner like 'JOHN%';

-- As orclpdb1_sys
create user sking identified by fenago;
grant connect to sking;
grant select any table to sking;

-- drop function no_access;

create or replace function no_access
 (schema_var varchar2,
  table_var varchar2)
  return varchar2
is
 return_value varchar2(300);
begin
  if(sys_context('userenv','session_user')) = 'OE'
    then return_value := '1=2';
else
  return_value := '1=1';
end if;
 return return_value;
end;
/

-- grant execute on no_access to public;

-- grant select any table to john;

-- drop context hremp_ctx;

create context hremp_ctx using hremp_ctx_pkg;


-- drop package system.hremp_ctx_pkg;

create or replace package hremp_ctx_pkg
 is
  procedure set_emp_id;
end;

create or replace package body hremp_ctx_pkg
 is
  procedure set_emp_id
   is
    v_emp_id number;
  begin
   select employee_id 
    into v_emp_id
     from hr.employees
      where upper(email) = (sys_context('userenv','session_user'))
      and rownum = 1;
      dbms_session.set_context('hremp_ctx','employee_id',v_emp_id);
      exception
      when no_data_found then
       dbms_session.set_context('hremp_ctx','employee_id',0);
       end;
       end;
    /
  grant execute on hremp_ctx_pkg to public;
    
    drop trigger system.hremp_ctx_logon;
    -- Create as SYS
    
    create or replace trigger hremp_ctx_logon
     after logon on database
      begin
       hremp_ctx_pkg.set_emp_id();
       end;
       /
       
       desc system.hremp_ctx_pkg;
    
    drop function emp_access;
    
    create or replace function emp_access
    (schema_name varchar2,
     table_name varchar2)
     return varchar2
     is
      return_value varchar2(3000);
      begin
       return_value := 
       '(employee_id = sys_context(''hremp_ctx'',''employee_id''))';
    return return_value;
        end;
        /
    revoke execute on emp_access from public;
    
    create role hremp_test;
    
    grant hremp_test to sking;
        
    drop function role_access;
    
    create or replace function role_access
    (schema_name varchar2,
     table_name varchar2)
     return varchar2
     is
      return_value varchar2(3000);
      begin
        if (sys_context('SYS_SESSION_ROLES','HREMP_TEST')) = 'TRUE' then
         return_value := '1=1';
        else
        return_value := '1=2';
        end if;
        return return_value;
        end;
        /
 grant hremp_test to system;
 grant select any table to hremp_test;
 grant execute on role_access to public;
 
exec dbms_rls.drop_policy('HR','EMPLOYEES','TEST_COL');        
exec dbms_rls.add_policy('HR','REGIONS','TEST_POL2','SYS','NO_ACCESS','SELECT');

-- Validate OE has select any table privileges

grant select any table to oe;
--connect to orclpdb1_oe
select * from hr.employees;
-- Nothing should be returned


exec dbms_rls.add_policy('HR','EMPLOYEES','TEST_ROLE','SYS','ROLE_ACCESS','SELECT,DELETE');

grant hremp_test to sking;
grant select any table to hremp_test;
grant select any table to sking;
drop user sking;
select employee_id 
     from hr.employees
      where upper(email) = 'SKING'
      and rownum = 1;
 
 begin
  dbms_rls.add_policy
  (object_schema => 'HR',
   object_name => 'employees',
   policy_name => 'test_col',
   function_schema => 'SYS',
   statement_types => 'SELECT',
   sec_relevant_cols => 'SALARY',
   policy_function => 'ROLE_ACCESS',
   sec_relevant_cols_opt => dbms_rls.all_rows);
end;
/
  
  
select object_name,object_type,owner
from dba_objects
where owner = 'SYSTEM'
order by last_ddl_time desc;


drop function sys.emp_access;
drop package sys.emp_ctx_pkg;
drop context hremp_ctx;
drop function sys.no_access;
drop package hremp_ctx_pkg;


  grant hremp_test to jack;    
