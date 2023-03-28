create or replace procedure left_join_proc
as
 cursor emp_dept_cur is 
   select first_name,last_name,employee_id,department_name,salary,
    department_id
    from employees left join departments using (department_id);
    v_salary number;
    bad_salary exception;
begin
  for emp_dept_rec in emp_dept_cur loop
   if emp_dept_rec.department_id is null then
    dbms_output.put_line('Employee '||emp_dept_rec.last_name||' does not have a department');
   end if;
   end loop;
  end;
/

set serveroutput on

exec left_join_proc;

