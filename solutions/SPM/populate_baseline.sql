set echo on

variable cnt number;

exec :cnt := dbms_spm.load_plans_from_sqlset( -
              sqlset_name  => 'SPM_STS', -
              basic_filter => 'sql_text like ''select /*LOAD_STS*/%''');

