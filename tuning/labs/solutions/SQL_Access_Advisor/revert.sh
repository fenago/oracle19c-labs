#!/bin/bash

cd /home/oracle/labs/solutions/SQL_Access_Advisor/sh

cp * $ORACLE_HOME/demo/schema/sales_history

sqlplus / as sysdba <<FIN!

SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 8000
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET LONG 1000

CONNECT / AS SYSDBA

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

alter system flush shared_pool;

drop table tempjfv purge;

drop table customersjfv purge;


execute dbms_advisor.delete_task('%');
execute dbms_advisor.delete_sqlwkld('%');

execute dbms_sqltune.drop_sqlset('SQLSET_MY_SQLACCESS_WORKLOAD');


EXECUTE DBMS_STATS.UNLOCK_SCHEMA_STATS('SH');



DROP MATERIALIZED VIEW LOG ON "SH"."CUSTOMERS";

DROP MATERIALIZED VIEW LOG ON "SH"."CHANNELS";

DROP MATERIALIZED VIEW LOG ON "SH"."TIMES";

DROP MATERIALIZED VIEW LOG ON "SH"."SALES";

DROP MATERIALIZED VIEW "SH"."MV_01DF0000";

DROP INDEX "SH"."CUSTOMERS_IDX_01DF0002";

DROP TABLE "SH"."CUSTOMERS" PURGE;

DROP TABLE "SH"."CUSTOMERS11" CASCADE CONSTRAINTS PURGE;

connect / as sysdba

@sh_main sh example temp oracle_4U /u01/app/oracle/product/11.2.0/dbhome_1/demo/schema/sales_history/ /home/oracle/ v3

exit;

FIN!

