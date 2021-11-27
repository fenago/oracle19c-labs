#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
# Written by Jim Spiller, Modified for 12c by MBillings
#
# This script creates the bc user the bartbs tablespace
# and BARCOPY table. The table is polpulated, a backup is taken and the
# the table is updated to prepare for this practice.

LABS=$HOME/labs/DBMod_Recovery

echo ' ' >/tmp/setup.log 2>&1

ORACLE_SID=orclcdb
ORAENV_ASK='NO'
. oraenv >>/dev/null
ORAENV_ASK=''

# remove the initorcl.ora file from the $ORACLE_HOME/dbs directory
# rm of initorcl.ora removed by DKK because initorcl.ora doesn't exist
# rm $ORACLE_HOME/dbs/initorcl.ora

sqlplus -S / as sysdba >> /tmp/setup.log 2>&1 <<EOF
ALTER PLUGGABLE DATABASE ORCLPDB1 OPEN;

connect sys/cloud_4U@orclpdb1 as sysdba

show con_name

-- CLEANUP from previous run
DROP USER bar CASCADE;

DROP TABLESPACE bartbs INCLUDING CONTENTS AND DATAFILES;

-- Create tablespace
CREATE TABLESPACE bartbs 
DATAFILE '/u01/app/oracle/oradata/ORCLCDB/orclpdb1/bartbs.dbf' SIZE 10M
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

EOF

#-- Create backup of the bartbs tablespace

rman target "'sys/cloud_4U@orclpdb1 as sysdba'" >> /tmp/setup.log 2>&1 <<EOF

BACKUP AS COPY TABLESPACE bartbs;
EOF

#-- update the table
sqlplus  /nolog >> /tmp/setup.log 2>&1 <<EOF
connect sys/cloud_4U@orclpdb1 as sysdba

UPDATE BAR.BARCOPY SET salary = salary+1;
COMMIT;

EOF
echo "Setup done." >> /tmp/setup.log