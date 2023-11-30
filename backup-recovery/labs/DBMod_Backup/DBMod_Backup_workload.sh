#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
# Start this script as OS user: oracle
#   This script moves 1% of the data in the Inventory.product_master
# to inventory obsolete_product


sqlplus / as sysdba<<EOF
ALTER SESSION set container=orclpdb1;
/* retrieve a random integer between 1 an 100 use that as a mod function */
/* to change the obsolete date for product ids in the table */


update inventory.product_master set obsoleted = SYSDATE
where mod(product_id,100) IN (
  select (round(dbms_random.value(1,100))) from dual)
/
commit;

EOF
exit
