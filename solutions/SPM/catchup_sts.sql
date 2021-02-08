set echo on

exec sys.dbms_sqltune.create_sqlset(-
sqlset_name  => 'SPM_STS', sqlset_owner => 'SPM');

DECLARE
   stscur   dbms_sqltune.sqlset_cursor;
BEGIN
   OPEN stscur FOR
     SELECT VALUE(P)
     FROM   TABLE(dbms_sqltune.select_cursor_cache(
            'sql_text like ''select /*LOAD_STS*/%''',
            null, null, null, null, null, null, 'ALL')) P;

   -- populate the sqlset
   dbms_sqltune.load_sqlset(sqlset_name      => 'SPM_STS',
                            populate_cursor  => stscur,
                            sqlset_owner     => 'SPM');
END;
/

