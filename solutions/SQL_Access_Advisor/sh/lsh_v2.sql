Rem
Rem $Header: lsh_v2.sql 29-aug-2002.11:51:15 hyeh Exp $
Rem
Rem vsh_v2.sql
Rem
Rem Copyright (c) 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      vsh_v2.sql - Loading data for SH schema
Rem
Rem    DESCRIPTION
Rem      <short description of component this file declares/defines>
Rem
Rem    NOTES
Rem      <other useful comments, qualifications, etc.>
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    hyeh        08/29/02 - hyeh_mv_comschema_to_rdbms
Rem    ahunold     08/21/02 - vrs for COSTS
Rem    ahunold     08/15/02 - Created
Rem

SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET VERIFY OFF
SET CONCAT '.'

PROMPT 
PROMPT specify password for SH as parameter 1:
DEFINE sh_pass     = &1
PROMPT 
PROMPT specify path for data files as parameter 2:
DEFINE data_path = &2
PROMPT
PROMPT specify path for log files as parameter 3:
DEFINE log_path = &3
PROMPT
PROMPT specify version as parameter 4:
DEFINE vrs = &4
PROMPT

PROMPT inserting rows tables ...
@?/demo/schema/sales_history/sh_pop1.sql
@?/demo/schema/sales_history/sh_pop2.sql

--
-- CUSTOMERS
--

DEFINE ctl_file = &data_path.cust_&vrs..ctl
DEFINE dat_file = &data_path.cust_&vrs..dat
DEFINE log_file = &log_path.cust_&vrs..log

PROMPT
PROMPT loading CUSTOMERS using:
PROMPT   &ctl_file
PROMPT   &dat_file
PROMPT   &log_file

HOST sqlldr sh/&sh_pass  -
 control=&ctl_file data=&dat_file log=&log_file -
 direct=yes -
 rows=10000

--
-- PRODUCTS
--

DEFINE ctl_file = &data_path.prod_&vrs..ctl
DEFINE dat_file = &data_path.prod_&vrs..dat
DEFINE log_file = &log_path.prod_&vrs..log

PROMPT
PROMPT loading PRODUCTS using:
PROMPT   &ctl_file
PROMPT   &dat_file
PROMPT   &log_file

HOST sqlldr sh/&sh_pass  -
 control=&ctl_file data=&dat_file log=&log_file -
 direct=yes -
 rows=10000

--
-- PROMOTIONS
--

DEFINE ctl_file = &data_path.prom_&vrs..ctl
DEFINE dat_file = &data_path.prom_&vrs..dat
DEFINE log_file = &log_path.prom_&vrs..log

PROMPT
PROMPT loading PROMOTIONS using:
PROMPT   &ctl_file
PROMPT   &dat_file
PROMPT   &log_file

HOST sqlldr sh/&sh_pass  -
 control=&ctl_file data=&dat_file log=&log_file -
 direct=yes -
 rows=10

--
-- SALES
--

DEFINE ctl_file = &data_path.sale_&vrs..ctl
DEFINE dat_file = &data_path.sale_&vrs..dat
DEFINE log_file = &log_path.sale_&vrs..log

PROMPT
PROMPT loading SALES using:
PROMPT   &ctl_file
PROMPT   &dat_file
PROMPT   &log_file

HOST sqlldr sh/&sh_pass  -
 control=&ctl_file data=&dat_file log=&log_file -
 direct=yes -
 rows=100000

--
-- COSTS
--

DEFINE ctl_file = &data_path.cost_&vrs..ctl
DEFINE dat_file = &data_path.cost_&vrs..dat
DEFINE log_file = &log_path.cost_&vrs..log

PROMPT
PROMPT loading COSTS using external table
PROMPT   &ctl_file
PROMPT   &dat_file
PROMPT   &log_file  

CREATE TABLE sales_transactions_ext
(
  PROD_ID NUMBER(6),
  CUST_ID NUMBER,
  TIME_ID DATE,
  CHANNEL_ID CHAR(1),
  PROMO_ID NUMBER(6),
  QUANTITY_SOLD NUMBER(3),
  AMOUNT_SOLD NUMBER(10,2),
  UNIT_COST NUMBER(10,2),
  UNIT_PRICE NUMBER(10,2)
)
ORGANIZATION external 
(
  TYPE oracle_loader
  DEFAULT DIRECTORY data_file_dir
  ACCESS PARAMETERS 
  (
    RECORDS DELIMITED BY NEWLINE CHARACTERSET US7ASCII
    BADFILE log_file_dir:'cost_&vrs..bad'
    LOGFILE log_file_dir:'cost_&vrs..log'
    FIELDS TERMINATED BY "|" LDRTRIM 
  )
  location 
  (
    'sale_&vrs..dat'
  )
)REJECT LIMIT UNLIMITED;

INSERT /*+ append */ INTO COSTS 
( time_id,
  prod_id,
  unit_cost,
  unit_price )
SELECT 
  time_id,
  prod_id,
  AVG(unit_cost),
  AVG(amount_sold/quantity_sold)
FROM 
  sales_transactions_ext
GROUP BY 
  time_id, prod_id;

Rem DROP TABLE sales_transactions_ext;

COMMIT;
