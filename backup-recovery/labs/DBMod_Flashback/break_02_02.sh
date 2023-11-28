#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#  -- Run as ORACLE OS user

sqlplus sys/fenago@orclpdb1 as sysdba >/home/oracle/labs/DBMod_Flashback/break.log <<EOF

create table bar.bar101 as select * from BAR.BARCOPY;
ALTER TABLE BAR.BAR101 add (address_line1 VARCHAR2(200), address_line2 VARCHAR2(200));

create table bar.bar102 as select * from BAR.BARCOPY;
ALTER TABLE BAR.BAR102 add (address_line1i VARCHAR2(200), address_line2 VARCHAR2(200));
drop table BAR.BAR102;

create table bar.bar102 as select * from BAR.BARCOPY;
ALTER TABLE BAR.BAR102 add (location_id NUMBER(12));
drop table bar.bar102;

drop table bar.bar101;

create table bar.bar102 as select * from BAR.BARCOPY;
ALTER TABLE BAR.BAR102 add (photo BLOB);

EOF
echo "Table DDL and DML executed." >> /home/oracle/labs/DBMod_Flashback/break.log
