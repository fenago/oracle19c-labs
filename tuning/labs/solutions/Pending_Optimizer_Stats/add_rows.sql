-- Insert some more rows. Now the table has 5 values each repeating 200 
-- times (uniform). All columns have same value.
begin
  for i in 1..5 loop
    for j in 1..100 loop
      insert into tabjfv(c1,c2,c3,c4,c5,c6,c7,c8,c9) values (i,i,i,i,i,i,i,i,i);
    end loop;
  end loop;
end;
/
commit;


-- Insert 200 null rows
begin
  for j in 1..200 loop
      insert into tabjfv(c1) values (null);
  end loop;
end;
/
commit;

