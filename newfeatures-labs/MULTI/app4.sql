SET ECHO ON
CONNECT sys/fenago@PDB_1 AS SYSDBA
ALTER PLUGGABLE DATABASE pdb_1 SNAPSHOT pdb1_third_snap;
DROP USER hr CASCADE;
ALTER PLUGGABLE DATABASE pdb_1 SNAPSHOT pdb1_forth_snap;
CONNECT / AS SYSDBA
