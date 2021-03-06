SET ECHO ON
ALTER PLUGGABLE DATABASE hr_root CLOSE;
DROP PLUGGABLE DATABASE sales INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE operations INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE hr_root INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE devt INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE administration INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE research INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE accounting INCLUDING DATAFILES;

ALTER SESSION SET db_create_file_dest='/u02/app/oracle/oradata/ORCL/hr_root';
CREATE PLUGGABLE DATABASE hr_root AS APPLICATION CONTAINER
  ADMIN USER admin IDENTIFIED BY Welcome_1  ROLES=(CONNECT)
        CREATE_FILE_DEST='/u02/app/oracle/oradata/ORCL/hr_root';
alter PLUGGABLE DATABASE hr_root open;
exit
