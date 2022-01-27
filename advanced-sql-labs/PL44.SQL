DECLARE
countr  number(3) := 0;
v_id    staff.id%TYPE;
v_salary  staff.salary%TYPE;
v_comm    staff.comm%TYPE;
v_gross_pay  number(9,2) :=0;
v_dept  staff.dept%TYPE;
totcount    number(4) :=0;
v_total_pay  number(11,2) :=0;
cursor pay_cursor is
     select id,salary,NVL(comm,0) COMM
     from staff
     where dept = v_dept;
BEGIN
  v_dept := &p_dept;
FOR pay_record IN pay_cursor LOOP
      v_total_pay := v_total_pay + (pay_record.salary
                                 +  pay_record.comm);
             INSERT INTO TEMPPAY (deptno,dept_pay)
             values(v_dept,v_total_pay);
     END LOOP;
COMMIT work;
END;
/
