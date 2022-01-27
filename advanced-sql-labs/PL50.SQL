create or replace procedure change_sal
(v_emp_id IN staff.id%TYPE,
v_new_salary IN staff.salary%TYPE)
is
BEGIN
   update staff
set salary = v_new_salary
    where id = v_emp_id;
commit work;
end change_sal;
/
