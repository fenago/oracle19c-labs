set serveroutput on 
declare
 cursor v_employees is
   select e.first_name,e.last_name,e.salary,d.department_name
   from employees e 
     join departments d
      on (e.department_id = d.department_id);
 begin
  for v_emp_rec in v_employees loop
  if v_emp_rec.department_name like 'E%' then
   dbms_output.put_line('The employee name is the manager' ||v_emp_rec.last_name);
   else
    dbms_output.put_line('The employee is not the manager '||v_emp_rec.last_name);
  end if;
  end loop;
  end;
  
  
 create table counter
  (counter number);
  
  begin
   for i in 1..100 loop
    if mod(i,3) = 0 then
     dbms_output.put_line('The value is divisble by 3 and the value is '||i);
     end if;
     if mod(i,5) = 0 then
      dbms_output.put_line('The value is divisble by 5 and the value is '||i);
      end if;
      if mod(i,5) = 0 and mod(i,3) = 0 then
       dbms_output.put_line ('The value is divisble by 3 and 5 and the value is '||i);
      end if;
    end loop;
    end;