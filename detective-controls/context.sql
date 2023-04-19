Use SQL Developer
orclpdb1_sys

create context sh_client using sh_ctx_pkg;

create or replace package sh_ctx_pkg is
 procedure set_cust_id;
 end;
 /
create or replace package body sh_ctx_pkg is
 procedure set_cust_id 
  is 
   v_cust_id number;
begin
   select cust_id into v_cust_id from sh.customers
    where upper(cust_email) = (sys_context('userenv','session_user') || '@COMPANY.EXAMPLE.COM')
    and rownum = 1;
    dbms_session.set_context('sh_client','cust_id',v_cust_id);
    exception
     when no_data_found then
       dbms_session.set_context('sh_client','cust_id',0);
end;
end;
/



create or replace trigger sh_ctx_logon
 after logon on database
  begin
    sh_ctx_pkg.set_cust_id();
end;
/

create user ruddy identified by fenago;
grant connect to ruddy;
grant select any table to ruddy;

Create a SQL Developer Connection string
name=orcldpb1_ruddy
username=ruddy
password=fenago
service_name = orclpdb1

Connect using SQLDeveloper
orcldpb1_ruddy

select count(*) from sh.customers;

select count(*) from sh.customers
where cust_id = sys_context('sh_client','cust_id');
