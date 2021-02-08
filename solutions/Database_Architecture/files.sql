col name format a45

select name from v$controlfile;


col member format a45

select group#,member from v$logfile;


col tablespace_name format a20
col file_name format a45

select tablespace_name, file_name from dba_data_files;

select tablespace_name, file_name from dba_temp_files;

exit;
