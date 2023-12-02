#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
# Written by Jim Spiller, Modified for 12c by MBillings, 18c by D. Keesling
#
# This script creates the BAR user the bartbs tablespace
# and barcopy table. The table is populated, a backup is taken and the
# the table is updated to prepare for this practice.

ORACLE_SID=orclcdb
ORAENV_ASK='NO'
. oraenv >> /dev/null
ORAENV_ASK=''

echo $ORACLE_SID > /tmp/setup.log
LABS=$HOME/labs/DBMod_Recovery

mkdir -p /u01/app/oracle/backup/ORCLCDB/orclpdb1

BACKUPDIR=/u01/app/oracle/backup/ORCLCDB/orclpdb1

sqlplus  /nolog >> /tmp/setup.log <<EOF
connect / as sysdba

ALTER SESSION set container=orclpdb1;
show con_name

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

rman target "'sys/fenago@orclpdb1 as sysdba'" >> /tmp/setup.log <<EOF

run {
ALLOCATE CHANNEL "ch1" DEVICE TYPE DISK FORMAT "/u01/app/oracle/backup/ORCLCDB/orclpdb1/bartest%U";
BACKUP AS COPY TAG 'BARTEST' TABLESPACE bartbs;
}
EOF

#-- update the table
sqlplus  /nolog >> /tmp/setup.log <<EOF
connect / as sysdba

ALTER SESSION set container=orclpdb1;
show con_name
UPDATE BAR.BARCOPY SET salary = salary+1;
COMMIT;
ALTER SYSTEM FLUSH BUFFER_CACHE;

EOF
echo "Setup complete." >> /tmp/setup.log
exit
