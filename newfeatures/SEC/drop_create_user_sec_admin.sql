set echo on
drop user c##sec_admin cascade;
create user c##sec_admin identified by Welcome_1 container=ALL;
grant create session, set container, restricted session, DV_OWNER to c##sec_admin container=ALL;
drop user c##accts_admin cascade;
create user c##accts_admin identified by Welcome_1 container=ALL;
grant create session, set container, DV_ACCTMGR to c##accts_admin container=ALL;
grant select on sys.dba_dv_status to c##accts_admin container=ALL;
exit
