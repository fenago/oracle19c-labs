set echo on

drop table mysales purge;

create table mysales as select * from sh.sales;

insert into mysales select * from mysales;
commit;


insert into mysales select * from mysales;
commit;

insert into mysales select * from mysales;
commit;

insert into mysales select * from mysales;
commit;

insert into mysales select * from mysales;
commit;

insert into mysales values (0,0,sysdate,0,0,0,0);
commit;

exec dbms_stats.gather_schema_stats('SH');

