create or replace procedure exception_proc
(p_high_salary number,p_low_salary number)
as
 cursor emp_dept_cur is 
   select first_name,last_name,employee_id,department_name,salary,
    department_id
    from employees join departments using (department_id);
    v_salary number;
    bad_salary exception;
begin
  for emp_dept_rec in emp_dept_cur loop
   begin
     if emp_dept_rec.salary > p_high_salary then
       v_salary := emp_dept_rec.salary/0;
     elsif emp_dept_rec.salary > p_low_salary then
       raise bad_salary;
      else
        dbms_output.put_line('The employee with a good salary is '||emp_dept_rec.last_name);
     end if;
    exception
    when zero_divide then
     dbms_output.put_line('Employee '||emp_dept_rec.employee_id||' cannot be divided by zero');
    when bad_salary then
     dbms_output.put_line('Employee '||emp_dept_rec.employee_id||' salary is '||emp_dept_rec.salary); 
    end;
   end loop;
  end;
/

set serveroutput on

exec exception_proc(6000,2000);
