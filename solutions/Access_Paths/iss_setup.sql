set echo on

create table t(c number, d number);

begin
 for i in 1..10000 loop
   insert into t values(1,i);
 end loop;
end;
/

create index it on t(c,d);

