DECLARE
type EMP_TYPE is table of staff.id%type
     index by binary_integer;
EMP_TAB  EMP_TYPE;
EMP_ID   STAFF.ID%TYPE;
lastid   staff.id%TYPE;
i  binary_integer := 1;
j  binary_integer :=1;
emp_name   staff.name%TYPE :='J Richard';
emp_dept   staff.dept%TYPE := &p_dept_no;
emp_job    staff.job%TYPE := 'PROG';
emp_years  staff.years%TYPE := 14;
emp_salary  staff.salary%TYPE := 50000;
emp_comm    staff.comm%TYPE := 5000;
BEGIN
select max(id)  into EMP_id from staff
FOR j IN 1..10 LOOP
emp_tab(j) := emp_id + J ;
i := i + 1;
END LOOP;
i := 1;
FOR J IN 1..10 LOOP
EMP_ID := EMP_TAB(i);
insert into staff (id,name,dept,job,years,salary,comm)
values(EMP_ID,emp_name,emp_dept,emp_job,emp_years,emp_salary,emp_comm);
i := i + 1;
:last_empid := emp_id;
end loop;
commit work;
END;
/
