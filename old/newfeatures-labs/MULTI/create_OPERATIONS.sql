set echo on
ALTER SESSION SET db_create_file_dest='/u02/app/oracle/oradata/ORCL/hr_root/operations';
CREATE PLUGGABLE DATABASE operations ADMIN USER admin IDENTIFIED BY Welcome_1  ROLES=(CONNECT)
    CREATE_FILE_DEST='/u02/app/oracle/oradata/ORCL/hr_root/operations';
alter pluggable database operations open;
exit
