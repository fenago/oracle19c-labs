DECLARE
v_id    staff.id%TYPE;
v_dept  staff.dept%TYPE := p_dept_no;
v_salary  staff.salary%TYPE;
v_comm    staff.comm%TYPE;
v_gross_pay  number(9,2) :=0;
v_total_pay  number(11,2) :=0;
cursor pay_cursor is
     select id,salary+comm
     from staff
     where dept = v_dept;
BEGIN
   OPEN pay_cursor;
   LOOP
      FETCH pay_cursor into v_id,v_gross_pay;
      EXIT WHEN pay_cursor %NOTFOUND;
      v_total_pay := v_total_pay + v_gross_pay;
INSERT INTO TEMPPAY (dept,dept_pay)
             values(v_dept,v_total_pay);
END LOOP;
CLOSE pay_cursor;
COMMIT work;
END;
/
