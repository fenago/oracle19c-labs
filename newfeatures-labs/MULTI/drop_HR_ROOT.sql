SET ECHO ON
ALTER PLUGGABLE DATABASE hr_root CLOSE;
DROP PLUGGABLE DATABASE sales INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE operations INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE hr_root INCLUDING DATAFILES;

exit