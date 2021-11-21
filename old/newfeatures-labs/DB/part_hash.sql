set echo on

DROP USER sh CASCADE;
CREATE USER sh IDENTIFIED BY Welcome_1;
DROP USER hr CASCADE;
CREATE USER hr IDENTIFIED BY Welcome_1;

GRANT dba TO sh, hr;

create or replace directory dp_pdb_orcl as '/home/oracle/labs/DB';
grant read , write on directory dp_pdb_orcl to sh, hr;

exit
