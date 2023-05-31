-- As SQL Developer orclpdb1_system

create profile userprofile limit
failed_login_attempts 4
password_lock_time 2
password_life_time 180;

alter profile default limit
failed_login_attempts 4;

drop user jessica;

create user jessica identified by oracle_1;
grant connect to jessica;

drop user tom;

create user tom identified by "Qax7UnP!123*";
grant connect to tom;

drop user steve;

create user steve identified by test1 profile userprofile;
grant connect to steve;

drop user john;

create user john identified by password1
password expire;
grant connect to john;

-- attempt to create a connection string to john and notice what happens to the 
-- password

/* Connection must be performed vi sqlplus
sqlplus system/fenago@orclpdb1 */

password jessica;

-- $ sqlplus tom/"Qax7UnP!123*"
-- sql>password

select dbms_metadata.get_ddl('USER', 'JESSICA') from
dual;

alter user steve account lock;

select username,account_status
from dba_users
where username like 'ST%';

alter user steve account unlock;

-- Test account status

create user appserver identified by oracle_1;

grant create session to appserver;

alter user steve grant connect through appserver;

connect appserver[steve]/oracle_1;

alter user steve revoke connect through appserver;

-- Create Roles

create role usr_role;

grant create session to usr_role;

grant select, insert on hr.employees to usr_role;

create role mgr_role;

grant usr_role to mgr_role;

grant create table to mgr_role;

grant update, delete on hr.employees to mgr_role;

grant usr_role to steve;

grant mgr_role to tom;

-- Connect to user steve to test select insert privs on employees
-- Connect to user tom to test privs on employees;


-- Common Users/Roles/Profiles
-- SQL Developer orclcdb_sys

drop user c##maja;

create user c##maja identified by oracle1;

create role c##role1;

create role c##role2;

create role c##role3;

grant create session to c##maja container=all;

grant select any table to c##role1 container=all;

grant c##role1 to c##role2 container=all;

grant c##role2 to c##maja container=all;

select * from cdb_role_privs
where grantee like 'C##%';

select * from cdb_sys_privs
where grantee like 'C##%';

-- Granting privileges and roles locally

-- SQL Developer orclpdb1_system

create role local_role1;

grant create synonym to c##maja;

grant create view to steve;

grant create table to c##role1;

grant c##role2 to c##role3;

grant c##role3 to local_role1;

grant c##role3 to c##maja;
 
 




