#!/bin/sh

# SWITCH TO PDB FIRST

# precreate users and tables for practices 

# create and populate CM schema from Common Mistakes practice

cd /home/oracle/solutions/Common_Mistakes
./setup_rest.sh

#Explain Plan practice setup script
# creates and populates the EP user schema

cd /home/oracle/solutions/Explain_Plan

sqlplus / as sysdba @ep_setup.sql

#Applicaytion Tracing setup script
# creates and populates tha TRACE user schema

cd /home/oracle/solutions/Application_Tracing

sqlplus / as sysdba @at_setup.sql

# Create the mysales table and statistics for the Access Path practice

cd /home/oracle/solutions/Access_Paths

sqlplus / as sysdba @ap_setup.sql

sqlplus sh/sh @idx_setup.sql

sqlplus sh/sh @create_mysales_index.sql

# Create the SPM user from the SQL Performance Management Practice


sqlplus /nolog <<FIN!
connect / as sysdba 

set echo on

drop user spm cascade;

create user spm identified by spm;

grant dba to spm;

exit

FIN!

# Create the ACS user and populate the ACS schema

cd /home/oracle/solutions/Adaptive_Cursor_Sharing

sqlplus / as sysdba @acs_setup.sql

# Create the CS User and populate the CS schema

cd /home/oracle/solutions/Cursor_Sharing

sqlplus / as sysdba @cs_setup.sql

# Create and grant privileges to AST user

sqlplus / as sysdba <<-EOF

drop user ast cascade;

create user ast identified by ast;

grant dba to ast;

EOF
# create and populate the IOT user for teh HINTS practice

cd /home/oracle/solutions/Hints
sqlplus / as sysdba @iot_setup.sql

# Unlock the HR account and grant DBA role for the Hints practice

cd /home/oracle/solutions/Hints

sqlplus / as sysdba <<-EOF

alter user hr identified by hr account unlock;

grant dba to hr

grant select_catalog_role to hr;

grant select ny dictionary to hr;
exit

EOF

# grant alter session required for code_examples

sqlplus / as sysdba <<-EOF

GRANT ALTER SESSION TO PUBLIC;

exit
EOF

# Create and populate the QRC schema for teh Results Cache Practice
cd $HOME/solutions/Query_Result_Cache/

./result_cache_setup.sh 

# Create users for practice 8-1 SHC, NIC, and IC

cd /home/oracle/solutions/Access_Paths

sqlplus /nolog @shc_setup.sql

sqlplus /nolog @nic_setup.sql

sqlplus /nolog @ic_setup.sql

# setup the practice 10-1 System Statistics

cd /home/oracle/solutions/System_Stats

sqlplus / as sysdba @sysstats_setup.sql

# setup the practice 10-2 Automatic Statisics Gathering

cd /home/oracle/solutions/Automatic_Gather_Stats

sqlplus / as sysdba @ags_setup.sql


