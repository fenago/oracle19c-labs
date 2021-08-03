set echo on

-- This example generates a workaround for a crash. This bug has already
-- been fixed but we toggle the bug fix using an underscore parameter 
-- which uses the (internal) feature called bug fix control.
-- This script will pause periodically to allow you to read the comments
-- and see the output of the previous command on the screen. Just press
-- return to make the demo resume.

pause

-- To begin the demo we will create the user diag and grant 
-- advisor privileges to him.

pause

grant connect, resource, dba, query rewrite, unlimited tablespace to diag identified by Welcome_1;

alter user diag account unlock;

-- Next we need to create and populate the table used by the demo. 
-- We will also create an index on the table;

pause
connect diag/Welcome_1@PDB1;

drop table simple_table;

create table simple_table(a varchar(40), b number, c varchar(240), d varchar(240));

create index tc on simple_table(b, d, a);

insert into simple_table values('a', 1, 'b', 'c');
insert into simple_table values('a', 1, 'x', 'c');
insert into simple_table values('e', 2, 'f', 'g');

-- In order to crash the system we need to switch off the code line that 
-- normal protects against this type of crash. We can switch off the code
-- using the (internal) feature called bug fix control. 

pause

-- switch the code
alter system set "_fix_control"="5868490:OFF";
-- alter session set optimizer_dynamic_sampling = 0;

-- Now that the code line has been switched off lets get the execution
-- plan for a simple delete statement.

pause

--- explain the plan
explain plan for delete
  /*+
      USE_HASH_AGGREGATION(@"SEL$80F8B8C6")
      USE_HASH(@"SEL$80F8B8C6" "T1"@"DEL$1")
      LEADING(@"SEL$80F8B8C6" "T2"@"SEL$1" "T1"@"DEL$1")
      FULL(@"SEL$80F8B8C6" "T1"@"DEL$1")
      FULL(@"SEL$80F8B8C6" "T2"@"SEL$1")
      OUTLINE(@"DEL$1")
      OUTLINE(@"SEL$1")
      OUTLINE(@"SEL$AD0B6B07")
      OUTLINE(@"SEL$7D4DB4AA")
      UNNEST(@"SEL$1")
      OUTLINE(@"SEL$75B5BFA2")
      MERGE(@"SEL$7D4DB4AA")
      OUTLINE_LEAF(@"SEL$80F8B8C6")
      ALL_ROWS
      OPT_PARAM('_optimizer_cost_model' 'fixed')
      DB_VERSION('11.1.0.7')
      OPTIMIZER_FEATURES_ENABLE('11.1.0.7')
      NO_INDEX(@"SEL$1" "T2"@"SEL$1")
  */
from simple_table t1 where t1.a = 'a' and rowid <> (select max(rowid) from simple_table t2 where t1.a= t2.a and t1.b = t2.b and t1.d=t2.d);

--- display the plan
select plan_table_output from table(dbms_xplan.display('plan_table',null));

-- The plan shows that we we will do a full table scan oun r.  
-- If we execut this simple system it will crash the system.

Pause
--- This statement caused the system to crash. 
delete /*+ USE_HASH_AGGREGATION(@"SEL$80F8B8C6") USE_HASH(@"SEL$80F8B8C6" "T1"@"DEL$1") LEADING(@"SEL$80F8B8C6" "T2"@"SEL$1" "T1"@"DEL$1") FULL(@"SEL$80F8B8C6" "T1"@"DEL$1") FULL(@"SEL$80F8B8C6" "T2"@"SEL$1") OUTLINE(@"DEL$1") OUTLINE(@"SEL$1") OUTLINE(@"SEL$AD0B6B07") OUTLINE(@"SEL$7D4DB4AA") UNNEST(@"SEL$1") OUTLINE(@"SEL$75B5BFA2") MERGE(@"SEL$7D4DB4AA") OUTLINE_LEAF(@"SEL$80F8B8C6") ALL_ROWS OPT_PARAM('_optimizer_cost_model' 'fixed') DB_VERSION('11.1.0.7') OPTIMIZER_FEATURES_ENABLE('11.1.0.7') NO_INDEX(@"SEL$1" "T2"@"SEL$1") */ from simple_table t1 where t1.a = 'a' and rowid <> (select max(rowid) from simple_table t2 where t1.a= t2.a and t1.b = t2.b and t1.d=t2.d);
