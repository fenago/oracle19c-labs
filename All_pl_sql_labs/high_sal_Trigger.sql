drop table high_sal;
drop table low_sal;

create table high_sal
(employee_id number,
last_name varchar2(30),
new_sal number,
old_sal number,
create_date timestamp,
create_by varchar2(30));

create table low_sal
(employee_id number,
last_name varchar2(30),
new_sal number,
old_sal number,
create_date timestamp,
create_by varchar2(30));

insert into high_sal
select employee_id,last_name,8000,'',sysdate,user
from employees;

commit;

drop trigger update_high_sal;
drop trigger delete_high_sal;

create or replace TRIGGER update_high_sal after
update on HR.employees
 for each row
 begin
  insert into low_sal
  values
  (:new.employee_id,:new.last_name,:new.salary,:old.salary,sysdate,user);
  end;
/

select * from user_errors;
  
create or replace TRIGGER delete_high_sal after
delete  on hr.employees
 for each row
 begin
  insert into high_sal
  values (:old.employee_id,:old.last_name,:old.salary,:old.salary,sysdate,user);
  end;
/
 
 delete from high_sal;
 
 update employees
 set  salary = 30000;
 
 delete from employees
 where employee_id = 100;
 
 commit;
 
 roll;
 
 truncate table low_sal;
 
 select * from employees;
 
 select * from low_sal;
 
 select * from high_sal;
 
 select * from user_recyclebin; 
 
 flashback table low_sal to before drop;