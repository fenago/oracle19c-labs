set echo on

set linesize 200 pagesize 1000

SELECT PLAN_TABLE_OUTPUT 
FROM 
TABLE (DBMS_XPLAN.DISPLAY_AWR('dkz7v96ym42c6')); 

SELECT PLAN_TABLE_OUTPUT 
FROM 
TABLE (DBMS_XPLAN.DISPLAY_AWR('8w580dd6ncgqw',null,null,'TYPICAL ALLSTATS LAST')); 
