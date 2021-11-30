#!/bin/bash

cd /home/oracle/labs/solutions/SQL_Tuning_Advisor

sqlplus -s /NOLOG <<EOF

set echo on 

connect / as sysdba
alter session set container = orclpdb;

exec DBMS_WORKLOAD_REPOSITORY.CREATE_SNAPSHOT();

grant dba to SH;

-- event to allow setting very short Flushing interval

alter session set events '13508 trace name context forever, level 1';


-- change INTERVAL setting to 2 minutes
-- change RETENTION setting to 6 hours (total of 180 snapshots)
execute dbms_workload_repository.modify_snapshot_settings(interval => 2,retention => 360);


-- play with ADDM sensitiveness
exec dbms_advisor.set_default_task_parameter('ADDM','DB_ACTIVITY_MIN',30);


alter user sh account unlock;
alter user sh identified by sh;

connect sh/sh@orclpdb

drop index sales_time_bix;
drop index sales_time_idx;
create index sales_time_idx on sales(time_id) compute statistics;


EOF

