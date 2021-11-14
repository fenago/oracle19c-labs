#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
# 

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd /home/oracle/labs/PERF

$ORACLE_HOME/bin/rman target / <<EOF
 CONFIGURE ARCHIVELOG DELETION POLICY TO none;
 ALTER SYSTEM SET db_recovery_file_dest='/u02/app/oracle/oradata/ORCL';
 ALTER SYSTEM SET db_recovery_file_dest_size=30g;
 DELETE ARCHIVELOG ALL;
yes
 DELETE OBSOLETE;
YES
exit
EOF

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/PERF/inmemory_size.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/PERF/shutdown.sql

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/PERF/startup.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/admin/create_PDB1.sql
$ORACLE_HOME/bin/sqlplus "system/Welcome_1@PDB1" @/home/oracle/labs/PERF/create_OE_user.sql
$ORACLE_HOME/bin/sqlplus "system/Welcome_1@PDB1" @/home/oracle/labs/PERF/create_IM_tables.sql
$ORACLE_HOME/bin/rman target / <<EOF
 DELETE ARCHIVELOG ALL;
YES
 DELETE OBSOLETE;
YES
exit
EOF
$ORACLE_HOME/bin/sqlldr oe/Welcome_1@PDB1 control=/home/oracle/labs/PERF/control_part.ctl
$ORACLE_HOME/bin/sqlldr oe/Welcome_1@PDB1 control=/home/oracle/labs/PERF/control_date.ctl
$ORACLE_HOME/bin/rman target / <<EOF
 DELETE ARCHIVELOG ALL;
yes
 DELETE OBSOLETE;
YES
exit
EOF
$ORACLE_HOME/bin/sqlldr oe/Welcome_1@PDB1 control=/home/oracle/labs/PERF/control_lineorder.ctl
$ORACLE_HOME/bin/rman target / <<EOF
 DELETE ARCHIVELOG ALL;
yes
 DELETE OBSOLETE;
YES
exit
EOF
$ORACLE_HOME/bin/sqlldr oe/Welcome_1@PDB1 control=/home/oracle/labs/PERF/control_lineorder2.ctl
$ORACLE_HOME/bin/rman target / <<EOF
 DELETE ARCHIVELOG ALL;
yes
 DELETE OBSOLETE;
YES 
exit
EOF
$ORACLE_HOME/bin/sqlldr oe/Welcome_1@PDB1 control=/home/oracle/labs/PERF/control_supplier.ctl
$ORACLE_HOME/bin/sqlldr oe/Welcome_1@PDB1 control=/home/oracle/labs/PERF/control_customer.ctl
$ORACLE_HOME/bin/rman target / <<EOF
 DELETE ARCHIVELOG ALL;
yes
 DELETE OBSOLETE;
yes
exit
EOF
$ORACLE_HOME/bin/sqlplus "system/Welcome_1@PDB1" @/home/oracle/labs/PERF/load_IM_tables.sql
