DECLARE
countr  number(3) := 0;
v_id    staff.id%TYPE;
v_name  staff.name%TYPE;
v_dept  staff.dept%TYPE :=&P_DEPT_NO;
v_salary  staff.salary%TYPE;
v_comm    staff.comm%TYPE;
new_comm  staff.comm%TYPE;
v_gross_pay  number(9,2) :=0;
totcount    number(4) :=0;
v_total_pay  number(11,2) :=0;
cursor pay_cursor(P_DEPT_NO number) is
     select id,name,salary,comm
     from staff
     where dept = P_DEPT_NO;
BEGIN
    select count(*) into totcount from staff where dept in(10,20,84);
    OPEN pay_cursor(&p_dept_no);
    LOOP
       FETCH pay_cursor into v_id,v_name,v_salary,v_comm;
             EXIT WHEN pay_cursor%NOTFOUND;
             v_total_pay := v_total_pay + (v_salary + v_comm);
             insert into temppay(dept,dept_pay)
                         values(v_dept,v_total_pay);
             countr := countr +1;
             exit when countr > 25;
END LOOP;
COMMIT work;
END;
/
