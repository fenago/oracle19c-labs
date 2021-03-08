declare
 c number;
begin
 for i in 1..500 loop
   select count(*) into c from dba_users;
 end loop;
end;
/
exit;
