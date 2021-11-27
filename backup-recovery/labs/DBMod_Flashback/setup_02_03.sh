#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
# Run as oracle OS user
# This script creates the BAR user, and  the bartbs tablespace
# and barcopy table. The table is populated, a backup is taken and the 
# the table is updated to prepare for this practice.

sqlplus -S /nolog > /home/oracle/labs/DBMod_Flashback/setup.log 2>&1 <<EOF
connect sys/cloud_4U@orclpdb1 as sysdba

-- CLEANUP from previous run
DROP USER bar CASCADE;
DROP TABLESPACE bartbs INCLUDING CONTENTS AND DATAFILES;

-- Create tablespace
CREATE TABLESPACE bartbs 
DATAFILE '/u01/app/oracle/oradata/ORCLCDB/orclpdb1/bartbs.dbf' SIZE 10M REUSE
SEGMENT SPACE MANAGEMENT MANUAL;

-- Create user
CREATE USER BAR IDENTIFIED BY cloud_4U 
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

-- Create an table with a FK relationship

CREATE TABLE BAR.BARDEPT
TABLESPACE BARTBS
AS SELECT * from HR.DEPARTMENTS;

ALTER TABLE BAR.BARDEPT 
ADD CONSTRAINT PK_BARDEPT PRIMARY KEY (DEPARTMENT_ID);

ALTER TABLE BAR.BARCOPY 
ADD CONSTRAINT dept_id_FK FOREIGN KEY (department_id)
 REFERENCES BAR.BARDEPT;
EOF

#-- Create backup of the bartbs tablespace

rman target sys/cloud_4U@orclpdb1 >> /home/oracle/labs/DBMod_Flashback/setup.log 2>&1 <<EOF
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
BACKUP AS COPY TABLESPACE bartbs;
ALTER DATABASE OPEN;
EOF

#-- update the table
sqlplus -S /nolog >> /home/oracle/labs/DBMod_Flashback/setup.log 2>&1 <<EOF
connect sys/cloud_4U@orclpdb1 as sysdba

UPDATE BAR.BARCOPY SET salary = salary+1;
COMMIT;

EOF
echo "Setup done." >> /home/oracle/labs/DBMod_Flashback/setup.log