#!/bin/bash
# rec_config.sh 
# configure the database for recovery

export ORACLE_SID=orclcdb
ORAENV_ASK='NO'
. oraenv >> /dev/null
ORAENV_ASK=''


# verify control file configuration

echo " Verify controlfiles are multiplexed "

sqlplus -s /nolog <<EOF
CONNECT / as sysdba 
SET SERVEROUTPUT ON
SET FEEDBACK OFF
Declare
 dummy CHAR(1);

BEGIN
 SELECT 'X' into dummy 
 FROM (select count(distinct name) cntl_count 
       from v\$controlfile) a
 Where a.cntl_count > 1;
 DBMS_OUTPUT.PUT_LINE ( 'The control files are multiplexed'); 
EXCEPTION
 when no_data_found then
   DBMS_OUTPUT.PUT_LINE ( 'The control files are NOT multiplexed');
END;
/
EOF


# verify that a PFILE exists
echo "Verify Pfile Exists"
pfile=$ORACLE_HOME/dbs/initorclcdb.ora
if [[ -f $pfile ]]
   then
       echo "PFILE $pfile exists"
   else
sqlplus -s /nolog <<EOF
CONNECT / as sysdba 
CREATE PFILE = '$ORACLE_HOME/dbs/initorclcdb.ora' from SPFILE;
EXIT
EOF

fi

#Verify database is in ARCHIVELOG mode
echo "Verify database is in Archivelog"

#noarch=`sqlplus -s /nolog @arch_mode.sql`

if [ -e /tmp/archivelogtest.log ]
  then 
    rm /tmp/archivelogtest.log
fi 

touch /tmp/archivelogtest.log

sqlplus -s /nolog <<EOF
CONNECT / as sysdba 
@/home/oracle/labs/DBMod_Recovery/arch_mode2.sql
EOF

grep -q NOARCHIVELOG /tmp/archivelogtest.log

if [[ "$?" -eq "0" ]]
 then
    echo "Configuring Archivelog"
    sqlplus -s /nolog <<EOF
    CONNECT / as sysdba 
     SHUTDOWN IMMEDIATE
     STARTUP MOUNT
     ALTER DATABASE ARCHIVELOG;
     ALTER DATABASE OPEN;
     EXIT
EOF
  else
     echo "Database in Archivelog"
fi

echo "Verify fast recovery area is configured"
# Verify fast recovery area is configured
sqlplus -s /nolog <<EOF
CONNECT / as sysdba 
set serveroutput on 
/*set feedback off*/ 
DECLARE
 parval VARCHAR2(4000);
 BEGIN
   BEGIN
   select value into parval from V\$PARAMETER
   WHERE name = 'db_recovery_file_dest'
   AND value is not NULL;
 
   EXCEPTION
   WHEN NO_DATA_FOUND THEN
     EXECUTE IMMEDIATE 'ALTER SYSTEM SET db_recovery_file_dest = ''/u01/app/oracle/fast_recovery_area'' SCOPE=BOTH';
   END; 

   BEGIN
    select value into parval from V\$PARAMETER
    WHERE name = 'db_recovery_file_dest_size'
    AND value is not NULL
    AND value >= '14000000000';
 
   EXCEPTION
    WHEN NO_DATA_FOUND THEN
      EXECUTE IMMEDIATE 'ALTER SYSTEM SET db_recovery_file_dest_size = 15G SCOPE=BOTH';
   END; 
 END;
/ 
EOF

echo "Verify if redo logfiles mulitplexed"
# are redo logfiles mulitplexed

grplist="1 2 3"

for grp in $grplist

do
sqlplus -s /nolog <<EOF
CONNECT / as sysdba 

SET SERVEROUTPUT ON
SET FEEDBACK OFF
DECLARE

   dummy char(1);
   v_grp VARCHAR2(30) := '$grp';
   sqlstr VARCHAR2(200);
   file_name VARCHAR2(100);
begin

   SELECT 'X' INTO dummy 
    FROM (SELECT count(member) mbrcount FROM V\$LOGFILE 
          WHERE group# = v_grp) a
    Where a.mbrcount > 1;

   DBMS_OUTPUT.PUT_LINE ( 'Redo log group '||to_char(v_grp)||' is Multiplexed');

EXCEPTION

when no_data_found then
   file_name:='/u01/app/oracle/fast_recovery_area/ORCLCDB/onlinelog/redo'||to_char(v_grp)||'a.log';
    DBMS_OUTPUT.PUT_LINE ('file_name is '||file_name);
   sqlstr:='ALTER DATABASE ADD LOGFILE MEMBER '''||file_name||''' TO GROUP '||v_grp;
    DBMS_OUTPUT.PUT_LINE ('sqlstr is '||sqlstr);
   EXECUTE IMMEDIATE sqlstr ;
END;
/
EOF

done


