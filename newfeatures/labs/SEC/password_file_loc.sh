#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cp /u01/app/oracle/product/19.3.0/dbhome_1/dbs/orapwORCL /u02/app/oracle/admin/ORCL/orapwORCL
mv /u01/app/oracle/product/19.3.0/dbhome_1/dbs/orapwORCL /u01/app/oracle/product/19.3.0/dbhome_1/dbs/orapwORCL.old
orapwd FILE='/u02/app/oracle/admin/ORCL/orapwORCL' INPUT_FILE='/u01/app/oracle/product/19.13.0/dbhome_1/dbs/orapwORCL.old' FORCE=y
