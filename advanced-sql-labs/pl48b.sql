DECLARE
countr  number(3) := 0;
v_id    staff.id%TYPE;
v_name  staff.name%TYPE;
v_dept  staff.dept%TYPE := &deptno;
v_salary  staff.salary%TYPE;
v_comm    staff.comm%TYPE;
new_comm  staff.comm%TYPE;
v_gross_pay  number(9,2) :=0;
totcount    number(4) :=0;
v_total_pay  number(11,2) :=0;
cursor pay_cursor(P_DEPT_NO number) is
     select id,salary,comm
     from staff
     where dept = P_DEPT_NO;
BEGIN
     OPEN pay_cursor(v_dept);
       LOOP
       FETCH pay_cursor into v_id,v_salary,v_comm;
             EXIT WHEN pay_cursor%NOTFOUND;
             v_total_pay := v_total_pay + (v_salary + v_comm);
             insert into temppay(deptno,dept_pay)
                         values(v_dept,v_total_pay);
             countr := countr +1;
             exit when countr > 25;
END LOOP;
COMMIT work;
END;
/
