grant dba to sh;

alter user sh identified by sh account unlock;

connect sh/sh

set serveroutput on size 32768;
set echo on;
variable norecs number;


Rem Clean up


declare
    name varchar2(30);
    cursor name_cur1 is
      select task_name from user_advisor_templates
        where task_name like '%SQLACCESS%';
  begin
    ---------------------------------------------------------------------------
    --  Get rid of templates, tasks and workloads.
    ---------------------------------------------------------------------------

    open name_cur1;

    loop
      fetch name_cur1 into name;
      exit when name_cur1%NOTFOUND;

      dbms_advisor.update_task_attributes(name,null,null,'FALSE','FALSE');
      dbms_advisor.delete_task(name);
    end loop;

    close name_cur1;

  end;
/


Rem make a temp table


DROP TABLE temp_table purge;
CREATE TABLE temp_table AS SELECT * FROM SYS.WRI$_ADV_SQLW_STMTS WHERE NULL IS NOT NULL;



Rem create a large number of pseudo-random (repeatable) queries in the temporary table


alter system flush shared_pool;
execute dbms_sqltune.drop_sqlset('SQLSET_MY_SQLACCESS_WORKLOAD');

drop table tempjfv purge;

create table tempjfv (c number, d varchar2(1000));


begin
for i in 1..20000 loop
  insert into tempjfv values(-i,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
end loop;
commit;
end;
/

drop table customersjfv purge;
create table customersjfv as select * from customers;


DECLARE
   sql_stmt   varchar2(2000);
   sqlsetname  VARCHAR2(30);
   sqlsetcur   dbms_sqltune.sqlset_cursor;
   refid    NUMBER;
 k NUMBER := 0;
 num_queries NUMBER := 500;
BEGIN

sql_stmt := 'SELECT /* QueryJFV 2 */ ch.channel_class, c.cust_city, t.calendar_quarter_desc, SUM(s.amount_sold) sales_amount FROM sh.sales s, sh.times t, sh.customers c, sh.channels ch WHERE s.time_id = t.time_id AND s.cust_id = c.cust_id AND s.channel_id = ch.channel_id AND c.cust_state_province = ''CA'' AND ch.channel_desc in (''Internet'',''Catalog'') AND t.calendar_quarter_desc IN (''1999-01'',''1999-02'') GROUP BY ch.channel_class, c.cust_city, t.calendar_quarter_desc';

insert into temp_table values(1,1,NULL,0,'SH','Access Advisor','Workload',0,0,0,0,1,100,2,to_date('02-FEB-2007'),3,0,sql_stmt,1);

sql_stmt := 'SELECT /* QueryJFV 3 */ ch.channel_class, c.cust_city, t.calendar_quarter_desc, SUM(s.amount_sold) sales_amount FROM sh.sales s, sh.times t, sh.customers c, sh.channels ch WHERE s.time_id = t.time_id AND s.cust_id = c.cust_id AND s.channel_id = ch.channel_id AND c.cust_state_province = ''CA'' AND ch.channel_desc in (''Internet'',''Catalog'') AND t.calendar_quarter_desc IN (''1999-03'',''1999-04'') GROUP BY ch.channel_class, c.cust_city, t.calendar_quarter_desc';

insert into temp_table values(1,1,NULL,0,'SH','Access Advisor','Workload',0,0,0,0,1,100,2,to_date('02-FEB-2007'),3,0,sql_stmt,1);

sql_stmt := 'SELECT /* QueryJFV 4 */ c.country_id, c.cust_city, c.cust_last_name FROM sh.customers c WHERE c.country_id in (52790, 52798) ORDER BY c.country_id, c.cust_city, c.cust_last_name';

insert into temp_table values(1,1,NULL,0,'SH','Access Advisor','Workload',0,0,0,0,1,100,2,to_date('02-FEB-2007'),3,0,sql_stmt,1);


sql_stmt := 'select /* func_indx */ count(*) from tempjfv where abs(c)=5';

insert into temp_table values(1,1,NULL,0,'SH','Access Advisor','Workload',0,0,0,0,1,100,2,to_date('02-FEB-2007'),3,0,sql_stmt,1);

sql_stmt := 'SELECT /* QueryJFV 5 */ * FROM sh.customersjfv WHERE cust_state_province = ''CA''';

insert into temp_table values(1,1,NULL,0,'SH','Access Advisor','Workload',0,0,0,0,1,100,2,to_date('02-FEB-2007'),3,0,sql_stmt,1);


sqlsetname := 'SQLSET_MY_SQLACCESS_WORKLOAD';

  dbms_sqltune.create_sqlset(sqlsetname, 'Generated STS');

   OPEN sqlsetcur FOR
     SELECT
          SQLSET_ROW(null,null, sql_text, null, null, username, module,
                     action, elapsed_time, cpu_time, buffer_gets, disk_reads,
                     0,rows_processed, 0, executions, 0, optimizer_cost, null,
                     priority, command_type,
                     to_char(last_execution_date,'yyyy-mm-dd/hh24:mi:ss'),
                     0,0,NULL,0,NULL,NULL
                     )
    FROM temp_table;

   dbms_sqltune.load_sqlset(sqlsetname, sqlsetcur);
END;
/


SELECT COUNT(*) FROM TABLE(DBMS_SQLTUNE.SELECT_SQLSET('SQLSET_MY_SQLACCESS_WORKLOAD'));




Rem Cleanup anything left behind


execute dbms_advisor.delete_task('%');
execute dbms_advisor.delete_sqlwkld('%');

EXECUTE DBMS_STATS.UNLOCK_SCHEMA_STATS('SH');

execute dbms_stats.gather_schema_stats(ownname => 'SH', estimate_percent=> DBMS_STATS.AUTO_SAMPLE_SIZE, method_opt => 'FOR ALL COLUMNS SIZE  AUTO', degree => 4 );

select distinct last_analyzed from dba_tab_statistics where owner='SH';

REM EXECUTE DBMS_STATS.LOCK_SCHEMA_STATS('SH');
