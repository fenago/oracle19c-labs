DECLARE
countr  number(3) := 0;
v_id    staff.id%TYPE;
v_dept  staff.dept%TYPE;
v_salary  staff.salary%TYPE;
v_comm    staff.comm%TYPE;
v_gross_pay  number(9,2) :=0;
v_total_pay  number(11,2) :=0;
cursor pay_cursor is
     select id,salary + nvl(comm,0)
     from staff
     where dept = v_dept;
BEGIN
  v_dept := &p_dept;
   OPEN pay_cursor;
     fetch pay_cursor into v_id,v_gross_pay;
      while  pay_cursor %FOUND LOOP
     v_total_pay := v_total_pay + v_gross_pay;
     INSERT INTO TEMPPAY (deptno,dept_pay)
             values(v_dept,v_total_pay);
	fetch pay_cursor into v_id,v_gross_pay;
END LOOP;
CLOSE pay_cursor;
COMMIT work;
END;
/
