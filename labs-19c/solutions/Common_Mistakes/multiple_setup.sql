--Execute as CM
set echo on

create table myemp as select * from hr.employees;


insert into myemp select * from myemp;
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
/
/
/
/
/
commit;

insert into myemp select * from myemp;
commit;

