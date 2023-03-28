select /*+ full (employees) */ * from hr.employees
 where employee_id > 110;
 
 drop table query_test;
 
 create table query_test
 (test_name varchar2(30),
  test_id number);
  
  create index query_test_idx
   on query_test(test_id);
 
  
  create index query_test_name_idx
   on query_test(test_name);
  

 drop index query_test_idx;
 
   select * from query_test
   where test_id = 1;
   
   begin
    for i in 1..500000 loop
      insert into query_test
       values ('Test',i);
       commit;
      end loop;
    end;
    /
      
      commit;
      
      select * from query_test
       where test_name = 'Test';
      
      select * from query_test
       where test_id = 2132;