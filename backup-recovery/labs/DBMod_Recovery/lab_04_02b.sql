-- DISCLAIMER:
-- This script is provided for educational purposes only. It is 
-- NOT supported by Oracle World Wide Technical Support.
-- The script has been tested and appears to work as intended.
-- You should always run new scripts on a test instance initially

-- Create an additional test table 
-- First drop it, so that this script can be executed repeatedly.

set echo on
connect sys/cloud_4U@orclpdb1 as sysdba
DROP TABLE BAR.test_table;

CREATE TABLE BAR.test_table
(NUM number(8),
NAME varchar2(25),
NOW  date
)
/
INSERT INTO BAR.test_table VALUES (1,'First test row',sysdate);
INSERT INTO BAR.test_table VALUES (2,'Second test row',sysdate);
INSERT INTO BAR.test_table VALUES (3,'Third test row',NULL);
commit;

connect sys/cloud_4U@ORCLCDB as sysdba
ALTER SYSTEM SWITCH logfile;
connect sys/cloud_4U@orclpdb1 as sysdba
ALTER SYSTEM checkpoint;

-- **** Note the SCN!
SELECT NAME, CURRENT_SCN FROM V$DATABASE;

