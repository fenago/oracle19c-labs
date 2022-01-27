DECLARE
v_id    staff.id%TYPE;
v_dept  staff.dept%TYPE;
t_dept  staff.dept%type;
v_salary  staff.salary%TYPE;
v_error  number;
v_comm    staff.comm%TYPE;
v_gross_pay  number(9,2) :=0;
v_total_pay  number(11,2) :=0;
cursor pay_cursor is
     select id,salary+NVL(comm,0)
     from staff
     where dept = v_dept;
BEGIN
  v_dept := &p_dept;
   OPEN pay_cursor;
   LOOP
   --   select distinct dept into t_dept from staff
   --   where dept=v_dept;
      FETCH pay_cursor into v_id,v_gross_pay;
      dbms_output.put_line('The Sqlcode '||sqlcode);
      EXIT WHEN pay_cursor %NOTFOUND;
      v_total_pay := v_total_pay + v_gross_pay;
      INSERT INTO TEMPPAY (deptno,dept_pay)
             values(v_dept,v_total_pay);
   END LOOP;
   CLOSE pay_cursor;
   COMMIT;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
  v_error := sqlcode;
  INSERT INTO EXCEPTION_TABLE
  VALUES('+100 ERROR'||v_error);
END;
/
