

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