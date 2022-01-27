declare
    emp_id     staff.id%TYPE;
    incr       staff.salary%TYPE;
    sal_missing   exception;
begin select salary into curr_sal
         from staff
         where  id = emp_id;
     IF curr_sal is null then
        raise sal_missing;
     else
        UPDATE staff
        set salary = salary + incr;
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
