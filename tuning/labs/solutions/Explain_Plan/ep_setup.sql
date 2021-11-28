set echo on

drop user ep cascade;

create user ep identified by ep default tablespace users temporary tablespace temp;

grant connect, resource, dba to ep;

connect ep/ep@orclpdb

drop table test purge;

create table test(c number, d varchar2(500));

begin
for i in 1..20000 loop
insert into test values(1,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
end loop;
commit;
end;
/

create index test_c_indx on test(c);

exec dbms_stats.gather_schema_stats('EP');

set echo off
set term off

exit;

