#!/bin/bash

cd /home/oracle/solutions/Pending_Optimizer_Stats

sqlplus / as sysdba <<FIN!

set echo on

drop user stats cascade;

create user stats identified by stats;

grant dba to stats;

connect stats/stats

drop table tabjfv purge;

-- Create a table with many columns
create table tabjfv (c1 number, c2 number, c3 number, c4 number, c5 number,
                 c6 number, c7 number, c8 number, c9 number);

-- Insert some data. The table has 5 values each repeating 100 times (uniform).
-- All columns have same value.
begin
  for i in 1..5 loop
    for j in 1..100 loop
      insert into tabjfv values (i,i,i,i,i,i,i,i,i);
    end loop;
  end loop;
end;
/
commit;

FIN!

