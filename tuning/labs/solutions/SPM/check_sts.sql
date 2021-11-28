set echo on

select sql_text from dba_sqlset_statements 
where sqlset_name='SPM_STS';

