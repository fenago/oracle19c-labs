set echo on

/*== Drop test tablespace and user ==*/

DROP USER moni CASCADE;

DROP TABLESPACE moni_tbs INCLUDING CONTENTS AND DATAFILES;
EXIT
