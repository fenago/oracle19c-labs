Task 1: a first cursorThe code below is designed to print out the salaries over 30000 for all personnel.  You can type this code in directly if you wish or copy and paste it.  What we want you to do is look at the output you get and be able to describe what each line of code is doing.DECLARE	CURSOR high_salaries IS SELECT employee_id, last_name,salary FROM employees where salary > 4000;v_empid		emplpoyees.employee_id%TYPE;v_lastname		employees.last_name%TYPE;v_salary		employees.salary%TYPE;BEGIN	OPEN high_salaries;	  LOOP		FETCH high_salaries INTO v_empid,v_lastname,v_salary;		  EXIT when high_salaries%NOTFOUND;		  DBMS_OUTPUT.PUT_LINE(v_empid ||' '||v_lastname||' '|| v_salary);	  END LOOP;	CLOSE high_salaries;END;Task 2:

Create a PL/SQL program that inserts 100 values into a counting table, also determine if the value is divisible by 3 display the value.  If it is divisible by 5 also display the value;

1)Create a counting Table
   Create table counting
   (counter number);

2) Create an anonymous Block
   Begin
     For i into 1..100 loop
      If mod(I,3) = 0 then
        Dbms_output.put_line(‘The value is ‘||i);
      End if;
      If mod(I,5) = 0 then
        Dbms_output.put_line(‘The value is ‘||i);
      End if;
        Insert into counting (i);
        Commit;
     End loop;
End;
