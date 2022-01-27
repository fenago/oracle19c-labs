--Task:  Retrieve all employees id's, names, & salaries, who have a salary
-- more than 100000.  Store the qualified rows in a PL/SQL table.
DECLARE
        TYPE id_table_type is TABLE OF NUMBER(3) INDEX BY BINARY_INTEGER;        
        TYPE name_table_type is TABLE OF varchar2(9) INDEX BY BINARY_INTEGER;
        TYPE salary_table_type is TABLE OF NUMBER(11,2)
        INDEX BY BINARY_INTEGER;
        I                 BINARY_INTEGER :=0;
        v_id              staff.id%TYPE;
        v_dept    staff.dept%TYPE;
        v_salary          staff.salary%TYPE;
        v_comm    staff.comm%TYPE;
        id_table          id_table_type;
        salary_table   salary_table_type;
        name_table    name_table_type;
        CURSOR staff_cursor IS
                select id,dept,salary
                from staff
                where salary > 10000;
BEGIN
        FOR staff_record IN  staff_cursor LOOP
                I := I + 1;
                id_table(i) := staff_record.id;
                salary_table(i) := staff_record.salary;
        END LOOP;
        COMMIT WORK;
END;
/
