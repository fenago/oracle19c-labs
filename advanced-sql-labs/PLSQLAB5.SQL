DECLARE
commission  staff.comm%TYPE;
emp_id      staff.id%TYPE := &emp_id;
EMP_SALARY   staff.SALARY%TYPE;
BEGIN
select comm,SALARY  into commission,EMP_SALARY from staff
where  id = emp_id;
IF EMP_SALARY <= 10000.00
   then EMP_SALARY := EMP_SALARY * 1.10;
elsif (EMP_SALARY > 10000.00 and EMP_SALARY < 15000.01 )
   then EMP_SALARY := 1.07 * EMP_SALARY;
ELSE
   EMP_SALARY := 1.05 * EMP_SALARY;
end if;
UPDATE staff 
set SALARY = EMP_SALARY
where  id = emp_id;
COMMIT;
END;
/
