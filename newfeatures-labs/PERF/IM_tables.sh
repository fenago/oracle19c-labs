#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=fenagodb
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/PERF

$ORACLE_HOME/bin/rman target / <<EOF
 CONFIGURE ARCHIVELOG DELETION POLICY TO none;
 ALTER SYSTEM SET db_recovery_file_dest='/u02/app/oracle/oradata/ORCL';
 ALTER SYSTEM SET db_recovery_file_dest_size=30g;
 DELETE ARCHIVELOG ALL;
 DELETE OBSOLETE;
exit
EOF

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @inmemory_size.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/SEC/shutdown.sql

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/SEC/startup.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/admin/create_PDB1.sql
$ORACLE_HOME/bin/sqlplus "system/fenago@PDB1" @create_IM_tables.sql
$ORACLE_HOME/bin/rman target / <<EOF
 DELETE ARCHIVELOG ALL;
 DELETE OBSOLETE;
exit
EOF
$ORACLE_HOME/bin/sqlldr oe/Welcome_1@PDB1 control=control_part.ctl
$ORACLE_HOME/bin/sqlldr oe/Welcome_1@PDB1 control=control_date.ctl
$ORACLE_HOME/bin/rman target / <<EOF
 DELETE ARCHIVELOG ALL;
 DELETE OBSOLETE;
exit
EOF
$ORACLE_HOME/bin/sqlldr oe/Welcome_1@PDB1 control=control_lineorder.ctl
$ORACLE_HOME/bin/rman target / <<EOF
 DELETE ARCHIVELOG ALL;
 DELETE OBSOLETE;
exit
EOF
$ORACLE_HOME/bin/sqlldr oe/Welcome_1@PDB1 control=control_lineorder2.ctl
$ORACLE_HOME/bin/rman target / <<EOF
 DELETE ARCHIVELOG ALL;
 DELETE OBSOLETE;
exit
EOF
$ORACLE_HOME/bin/sqlldr oe/Welcome_1@PDB1 control=control_supplier.ctl
$ORACLE_HOME/bin/sqlldr oe/Welcome_1@PDB1 control=control_customer.ctl
$ORACLE_HOME/bin/rman target / <<EOF
 DELETE ARCHIVELOG ALL;
 DELETE OBSOLETE;
exit
EOF
$ORACLE_HOME/bin/sqlplus "system/fenago@PDB1" @load_IM_tables.sql
