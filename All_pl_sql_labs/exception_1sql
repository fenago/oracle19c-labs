create or replace procedure test_sal_proc
is
 cursor v_employees is
   select e.first_name,e.last_name,e.salary,e.employee_id
   from employees e; 
      high_sal exception;
      v_emp_rec v_employees%rowtype;
 begin
  for v_emp_rec in v_employees loop
 begin 
  if v_emp_rec.salary > 8000  then
   RAISE HIGH_SAL;
  else
    dbms_output.put_line('The employee is not the manager '||v_emp_rec.last_name);
  end if;
 -- end loop;
  exception
    WHEN HIGH_SAL THEN
    insert into high_sal
     values (v_emp_rec.employee_id,v_emp_rec.last_name,v_emp_rec.salary);
     commit;
  end;
  end loop;
  end;
  
  truncate table high_sal;
  exec test_sal_proc
  
  select * from high_sal;
  select * from employees
  where salary > 8000