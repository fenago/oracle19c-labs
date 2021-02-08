set echo on

alter system flush shared_pool;

alter system flush buffer_cache;

set echo off
set term off

select count(*) from test t1, test t2 where t1.c=t2.c and t1.c=1;

exit;

