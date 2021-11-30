set echo on

connect / as sysdba;
alter session set container = orclpdb; 

drop user jfv cascade;

create user jfv identified by jfv default tablespace users temporary tablespace temp;

grant connect, resource, dba to jfv;


connect jfv/jfv@orclpdb

drop table t purge;

drop table z purge;

create table t(c number);

insert into t values (1);

commit;

insert into t select * from t;

/
/
/
/
/
/
/
/
/
/

commit;

insert into t select * from t;

/
/
/
/
/
/
/

commit;

create table z(d number);

begin
 for i in 1..100 loop
    insert into z values (i);
 end loop;
 commit;
end;
/

create unique index iz on z(d);

execute dbms_stats.gather_table_stats('JFV','T',cascade=>true);

execute dbms_stats.gather_table_stats('JFV','Z',cascade=>true);

exit;

