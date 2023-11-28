#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
# Written by Jim Spiller, Modified for 12c: MBillings
# This script deletes a tablespace, and a archive log file that
# is needed for recovery. It moves a backup to a location where 
# RMAN cannot find it to cause an issue for incomplete recovery.
#
ORACLE_SID=orclcdb
ORAENV_ASK='NO'
. oraenv >>/dev/null
ORAENV_ASK=''

echo $ORACLE_SID > /tmp/break.log

# switch log file several times to make sure an archive log file is required
# to perform recovery.

#sqlplus / as sysdba >> /tmp/break.log 2>&1  <<EOF
sqlplus sys/fenago@orclpdb1 as sysdba >> /tmp/break.log 2>&1  <<EOF
EXEC DBMS_LOCK.SLEEP(1.5);
connect / as sysdba
ALTER SYSTEM SWITCH LOGFILE;
connect sys/fenago@orclpdb1 as sysdba
UPDATE BAR.BARCOPY SET salary = salary+1;
Commit;

EXEC DBMS_LOCK.SLEEP(1.5);
connect / as sysdba
ALTER SYSTEM SWITCH LOGFILE;
connect sys/fenago@orclpdb1 as sysdba
UPDATE BAR.BARCOPY SET salary = salary+1;
Commit;

EXEC DBMS_LOCK.SLEEP(1.5);
connect / as sysdba
ALTER SYSTEM SWITCH LOGFILE;
connect sys/fenago@orclpdb1 as sysdba
UPDATE BAR.BARCOPY SET salary = salary+1;
Commit;

EXEC DBMS_LOCK.SLEEP(1.5);
connect / as sysdba
ALTER SYSTEM SWITCH LOGFILE;
connect sys/fenago@orclpdb1 as sysdba
UPDATE BAR.BARCOPY SET salary = salary+1;
Commit;

EXEC DBMS_LOCK.SLEEP(1.5);
connect / as sysdba
ALTER SYSTEM SWITCH LOGFILE;
connect sys/fenago@orclpdb1 as sysdba
UPDATE BAR.BARCOPY SET salary = salary+1;
Commit;

EXEC DBMS_LOCK.SLEEP(1.5);
connect / as sysdba
ALTER SYSTEM SWITCH LOGFILE;
connect sys/fenago@orclpdb1 as sysdba
UPDATE BAR.BARCOPY SET salary = salary+1;
Commit;

EXEC DBMS_LOCK.SLEEP(1.5);
connect / as sysdba
ALTER SYSTEM SWITCH LOGFILE;
connect sys/fenago@orclpdb1 as sysdba
UPDATE BAR.BARCOPY SET salary = salary+1;
Commit;

EXEC DBMS_LOCK.SLEEP(1.5);
connect / as sysdba
ALTER SYSTEM SWITCH LOGFILE;
connect sys/fenago@orclpdb1 as sysdba
UPDATE BAR.BARCOPY SET salary = salary+1;
Commit;
exit
EOF

echo "The last digit of the salary indicates how many times this table has been updated" >> /tmp/break.log
sqlplus sys/fenago@orclpdb1 as sysdba <<EOF
select salary from BAR.BARCOPY
where rownum = 1;
connect / as sysdba
ALTER SYSTEM FLUSH BUFFER_CACHE;
exit
EOF

# Find the newest archive log file where the redo is overwritten and delete it.
sqlplus / as sysdba @rm_archive_log.sql  >>/tmp/break.log

echo "Shutdown the database abort" >>/tmp/break.log
sqlplus / as sysdba >> /tmp/break.log <<EOF
shutdown abort
exit
EOF

#New lines added by DKK for non-ASM log files
chmod 777 rm_log_file.sh
./rm_log_file.sh > /tmp/break.log
rm -f /u01/app/oracle/oradata/ORCLCDB/orclpdb1/bartbs.dbf >> /tmp/break.log

echo "Issue created." >>/tmp/break.log
exit
