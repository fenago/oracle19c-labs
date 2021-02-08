set echo on

set long 10000

select dbms_sqltune.report_tuning_task(:spmtune,'TEXT')
 from dual;

