select id,name,salary,comm
  from staff
  where  (comm + 100 > 350 or
 salary * 1.15 > 20000) and
  id < 110
/
