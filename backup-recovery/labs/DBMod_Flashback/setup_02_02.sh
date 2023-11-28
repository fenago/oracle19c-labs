#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
sqlplus -S /nolog > /home/oracle/labs/DBMod_Flashback/setup.log 2>&1 <<EOF
connect sys/fenago@orclpdb1 as sysdba

-- CLEANUP from previous run
DROP USER bar CASCADE;
DROP TABLESPACE bartbs INCLUDING CONTENTS AND DATAFILES;

-- Create tablespace
CREATE TABLESPACE bartbs
DATAFILE '/u01/app/oracle/oradata/ORCLCDB/orclpdb1/bartbs.dbf' SIZE 10M REUSE
SEGMENT SPACE MANAGEMENT MANUAL;

-- Create user
CREATE USER BAR IDENTIFIED BY fenago 
DEFAULT TABLESPACE bartbs
QUOTA UNLIMITED ON bartbs;

GRANT CREATE SESSION TO BAR;

-- create table and populate 
-- be sure table is at least 2 blocks long
CREATE TABLE BAR.barcopy
TABLESPACE bartbs
AS SELECT * FROM HR.EMPLOYEES;

INSERT INTO BAR.BARCOPY
SELECT * FROM BAR.BARCOPY;

INSERT INTO BAR.BARCOPY
SELECT * FROM BAR.BARCOPY;
EOF

#-- Create backup of the bartbs tablespace

rman target sys/fenago@orclpdb1 >> /home/oracle/labs/DBMod_Flashback/setup.log 2>&1 <<EOF
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
BACKUP AS COPY TABLESPACE bartbs;
ALTER DATABASE OPEN;
EOF

#-- update the table
sqlplus -S /nolog >> /home/oracle/labs/DBMod_Flashback/setup.log 2>&1 <<EOF
connect sys/fenago@orclpdb1 as sysdba
UPDATE BAR.BARCOPY SET salary = salary+1;
COMMIT;

EOF
echo "Setup done." >> /home/oracle/labs/DBMod_Flashback/setup.log
