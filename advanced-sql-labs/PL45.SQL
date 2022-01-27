DECLARE
countr  number(3) := 0;
v_id    staff.id%TYPE;
v_dept  staff.dept%TYPE;
v_salary  staff.salary%TYPE;
v_comm    staff.comm%TYPE;
new_comm  staff.comm%TYPE;
v_gross_pay  number(9,2) :=0;
totcount    number(4) :=0;
v_total_pay  number(11,2) :=0;
cursor pay_cursor is
     select dept,id,name,salary,comm
     from staff
     where dept in(10,20,84) and salary > 10000
     for update of comm,salary,dept;
BEGIN
  select count(*) into totcount from staff where dept in(10,20,84);
     FOR pay_record IN pay_cursor LOOP
             new_comm := (pay_record.salary+pay_record.comm) * .10;
             if pay_record.comm > new_comm then
                delete from staff
                where current of pay_cursor;
             end if;
             countr := countr +1;
             exit when countr > 25;
      exit when (pay_cursor%ROWCOUNT >= 15) or (pay_cursor%NOTFOUND);
END LOOP;
COMMIT work;
END;
/
