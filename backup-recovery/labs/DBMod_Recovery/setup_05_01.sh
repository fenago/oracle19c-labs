#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
# Run as oracle OS user

# Shutdown the database 
export ORACLE_SID=orclcdb    > /tmp/break.log
chmod 777 /tmp/break.log
ORAENV_ASK='NO'
. oraenv >>/dev/null
ORAENV_ASK=''
echo $ORACLE_SID >> /tmp/break.log
echo "Shutdown $ORACLE_SID database " >> /tmp/break.log

sqlplus / as sysdba >> /tmp/break.log <<EOF
shutdown immediate
startup
exit
EOF

sqlplus sys/fenago@orclpdb1 as sysdba > /tmp/setup.log 2>&1 <<EOF
show con_name
ALTER DATABASE open;
show pdbs

-- CLEANUP from previous run
DROP USER bc CASCADE;
DROP TABLESPACE bctbs INCLUDING CONTENTS AND DATAFILES;

-- Create tablespace
CREATE TABLESPACE bctbs 
DATAFILE '/u01/app/oracle/oradata/ORCLCDB/orclpdb1/bctbs01.dbf' SIZE 10M REUSE
SEGMENT SPACE MANAGEMENT MANUAL;

-- Create user
CREATE USER bc IDENTIFIED BY fenago
DEFAULT TABLESPACE bctbs
QUOTA UNLIMITED ON bctbs;

GRANT CREATE SESSION TO bc;

-- create table and populate 
-- be sure table is at least 2 blocks long
CREATE TABLE bc.bccopy
TABLESPACE bctbs
AS SELECT * FROM HR.EMPLOYEES;

INSERT INTO bc.bccopy
SELECT * FROM bc.bccopy;

INSERT INTO bc.bccopy
SELECT * FROM bc.bccopy;

EOF

#-- Create backup of the bctbs tablespace

rman target "'sys/fenago@orclpdb1 as sysdba'" >> /tmp/setup.log 2>&1 <<EOF
BACKUP AS COPY TABLESPACE bctbs;
EOF

#-- update the table
sqlplus sys/fenago@orclpdb1 as sysdba >> /tmp/setup.log 2>&1 <<EOF
show con_name
UPDATE bc.bccopy SET salary = salary+1;
COMMIT;
EOF
echo "Setup complete." >> /tmp/setup.log
