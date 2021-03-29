create table high_sal
(employee_id number,
last_name varchar2(50),
 salary number);
 
 create table low_sal
(employee_id number,
last_name varchar2(50),
 salary number);
 
 create or replace procedure test_high_sal
 as
  cursor cur_emp_rec is
   select salary,employee_id,last_name from hr.employees;
     high_sal exception;
  begin
   for v_emp_rec in cur_emp_rec loop
  if v_emp_rec.salary < 8000 then
     insert into low_sal
      values (v_emp_rec.employee_id,v_emp_rec.last_name,v_emp_rec.salary);
      commit;
    end if;
    end loop;
    exception
     when high_sal then
      insert into high_sal
            values (v_emp_rec.employee_id,v_emp_rec.last_name,v_emp_rec.salary);
    end;
    sho errors