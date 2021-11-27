#!/bin/bash

cd /home/oracle/labs/solutions/Common_Mistakes

sqlplus / as sysdba <<EOF

alter user sh identified by sh account unlock;

grant dba to sh;

EOF

