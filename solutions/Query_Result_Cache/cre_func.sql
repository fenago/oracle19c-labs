create or replace function CACHEJFV_COUNT(v varchar2)
return number
result_cache relies_on (cachejfv)
is
 cnt number;
begin
 select count(*) into cnt
 from cachejfv c1,cachejfv c2,cachejfv c3,cachejfv c4,cachejfv c5,cachejfv c6, cachejfv c7
 where c1.c=v and c2.c=v and c3.c=v and c4.c=v and c5.c=v and c6.c=v and c7.c=v;
 return cnt;
end;
/

