create or replace TRIGGER update_high_sal after
update on "HR"."HIGH_SAL"
 for each row
 begin
  insert into low_sal
  values (:new.employee_id,:new.last_name,:new.salary,:old.salary,sysdate,user);
  end;
  
create or replace TRIGGER delete_high_sal after
delete  on "HR"."HIGH_SAL"
 for each row
 begin
  insert into low_sal
  values (:old.employee_id,:old.last_name,:old.salary,:old.salary,sysdate,user);
  end;
 
 delete from high_sal;
 
 update high_sal
 set salary = 30000;
 
 commit;
 
 truncate table low_sal;
 
 select * from low_sal;
 
 select * from user_recyclebin; 
 
 flashback table low_sal to before drop;