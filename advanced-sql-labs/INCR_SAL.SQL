CREATE PROCEDURE incr_sal(emp_id integer,incr real)
is curr_sal real;
    sal_missing exception;
begin select salary into curr_sal
         from staff
         where  id = emp_id;
     dbms_output.put_line('This is employee '||to_char(emp_id)||' '||to_char(curr_sal));
      IF curr_sal is null then
        raise sal_missing;
     else
        UPDATE staff
        set salary = curr_sal + incr WHERE ID = EMP_ID;
        dbms_output.put_line('New salary is '||to_char(curr_sal);
     end if;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
      INSERT INTO exception_table(message)
                        values(to_char(emp_id)||'NONE');
  WHEN sal_missing THEN
       INSERT INTO exception_table(message)
                        values(to_char(emp_id)||'SALARY IS NULL');
end incr_sal;
/
