--Task:  Retrieve all employees id's, names, AND salaries, who have a salary
-- more than 10000.  Store the qualified rows in a PL/SQL table.
DECLARE
        TYPE id_table_type is TABLE OF NUMBER(4) INDEX BY BINARY_INTEGER;        
        TYPE salary_table_type is TABLE OF NUMBER(11,2)
        INDEX BY BINARY_INTEGER;
        I                 BINARY_INTEGER :=0;
        v_id              staff.id%TYPE;
        v_dept    staff.dept%TYPE;
        v_salary          staff.salary%TYPE;
        v_comm    staff.comm%TYPE;
        id_table          id_table_type;
        salary_table   salary_table_type;
	max_sal   number(11,2);
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
	select max(salary) into max_sal from staff;
	FOR J IN 1..I    LOOP
	   IF salary_table(j) = max_sal
	      then insert into exception_table(message)
	      values(to_char(max_sal)||'MAX SALARY FOR'||to_char(id_table(j)));
	  END IF;
	END LOOP;

        COMMIT WORK;
END;
/
