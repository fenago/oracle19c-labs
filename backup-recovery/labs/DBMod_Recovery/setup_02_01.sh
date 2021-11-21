#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is NOT
#  -- supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
# Run as oracle OS user
# This script creates the BAR9 user the BAR9TBS tablespace
# and BARCOPY table. The table is populated, a backup is taken and the
# the table is updated to prepare for this practice.

sqlplus -S /nolog > /tmp/setup.log 2>&1 <<EOF
connect / as sysdba

ALTER PLUGGABLE DATABASE ALL CLOSE;

ALTER PLUGGABLE DATABASE ALL SAVE STATE;

ALTER PLUGGABLE DATABASE ORCLPDB1 OPEN;

alter session set container=orclpdb1;

-- CLEANUP from previous run
DROP USER bar91 CASCADE;

DROP TABLESPACE bar91tbs INCLUDING CONTENTS AND DATAFILES;

-- Create tablespace
CREATE TABLESPACE bar91tbs 
DATAFILE '/u01/app/oracle/oradata/ORCLCDB/orclpdb1/bar91tbs01.dbf' SIZE 10M
SEGMENT SPACE MANAGEMENT MANUAL;

-- Create user
CREATE USER bar91 IDENTIFIED BY cloud_4U 
DEFAULT TABLESPACE bar91tbs
QUOTA UNLIMITED ON bar91tbs;

GRANT CREATE SESSION TO bar91;

-- create table and populate 
-- be sure table is at least 2 blocks long
CREATE TABLE bar91.barcopy
TABLESPACE bar91tbs
AS SELECT * FROM HR.EMPLOYEES;

INSERT INTO bar91.BARCOPY
SELECT * FROM bar91.BARCOPY;

INSERT INTO bar91.BARCOPY
SELECT * FROM bar91.BARCOPY;

EOF

#-- Create backup of the bar*tbs tablespace

rman target "'sys/cloud_4U@orclpdb1 as sysdba'">> /tmp/setup.log 2>&1 <<EOF

BACKUP AS COPY TABLESPACE bar91tbs;
EOF

#-- update the table
sqlplus -S /nolog >> /tmp/setup.log 2>&1 <<EOF
connect / as sysdba
alter session set container=orclpdb1;
UPDATE bar91.BARCOPY SET salary = salary+1;
COMMIT;

EOF
echo "Setup complete." >> /tmp/setup.log
