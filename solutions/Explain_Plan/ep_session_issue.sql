set echo off
set termout off

alter session set optimizer_mode=rule;

set termout on
set echo on

set timing on

select count(*) from test t1, test t2 where t1.c=t2.c and t1.c=1;

exit;

