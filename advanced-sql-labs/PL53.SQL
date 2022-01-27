create or replace function get_sal
(v_emp_id  NUMBER)
RETURN NUMBER
is
v_salary  staff.salary%TYPE;
begin
    select salary
         into v_salary
      from staff
      where id = v_emp_id;
    RETURN v_salary;
end get_sal;
/
