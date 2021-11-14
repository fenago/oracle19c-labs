SET ECHO ON
!mkdir -p /u02/app/oracle/oradata/ORCL/pdb2
ALTER SESSION SET db_create_file_dest='/u02/app/oracle/oradata/ORCL/pdb2';
CREATE PLUGGABLE DATABASE pdb2
    ADMIN USER pdb_admin IDENTIFIED BY Welcome_1 ROLES=(CONNECT)
    CREATE_FILE_DEST='/u02/app/oracle/oradata/ORCL/pdb2';
ALTER PLUGGABLE DATABASE pdb2 OPEN;