DECLARE
countr  number(3) := 0;
v_id    staff.id%TYPE;
v_dept  staff.dept%TYPE := &dept;
tdept   staff.dept%type;
v_salary  staff.salary%TYPE;
v_comm    staff.comm%TYPE;
new_comm  staff.comm%TYPE;
v_gross_pay  number(9,2) :=0;
totcount    number(4) :=0;
v_total_pay  number(11,2) :=0;
cursor pay_cursor is
     select dept,salary,nvl(comm,0) COMM
     from staff
     where dept = v_dept
     for update of salary;
BEGIN
select distinct dept into tdept
from staff
where dept = v_dept; 
   FOR pay_record IN pay_cursor LOOP
                 v_gross_pay := (pay_record.salary
				+pay_record.comm);
		  dbms_output.put_line(to_char(v_gross_pay));
             if v_gross_pay < 10000.01 then
                     v_salary := pay_record.salary;
	     elsif
	        v_gross_pay between 10000.01 and 20000.00 then
		     v_salary := pay_record.salary * 1.02;
	     else
		v_salary := pay_record.salary * 1.04;
	     end if;
		UPDATE STAFF
		SET SALARY = v_salary
                where current of pay_cursor;
         v_total_pay := v_total_pay + v_gross_pay;
   END LOOP;
COMMIT work;
:grand_total := v_total_pay;        
    
EXCEPTION
  WHEN NO_DATA_FOUND then
    rollback work;
    insert into exception_table(message)
    values('Incorrect Department number'||' '||to_char(v_dept));
  WHEN OTHERS THEN
    rollback work;
    insert into exception_table(message)
    values('Other error occurred.');
commit work;
END;
/
