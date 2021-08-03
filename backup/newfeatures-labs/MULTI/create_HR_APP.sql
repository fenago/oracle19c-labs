set echo on
ALTER PLUGGABLE DATABASE APPLICATION hr_app begin install '1.0';
create user hr_mgr identified by Welcome_1 container=all;
grant create session, dba to hr_mgr container=all;
DROP USER hr_lock_mgr CASCADE;
CREATE USER hr_lock_mgr IDENTIFIED BY Welcome_1 CONTAINER=ALL;
GRANT create session, alter system, select any dictionary, 
      create any table, drop any table,
      create lockdown profile, alter lockdown profile, drop lockdown profile
	  TO hr_lock_mgr CONTAINER=ALL;

ALTER PLUGGABLE DATABASE APPLICATION hr_app end install '1.0';
exit
