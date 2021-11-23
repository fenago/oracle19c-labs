set echo on

set linesize 200
set timing on
set autotrace traceonly

SELECT /*+ INDEX_COMBINE(c) */ c.*                  
FROM   customers c
WHERE  c.cust_year_of_birth   = 1953
OR   c.cust_credit_limit  = 10000
/

set timing off
set autotrace off

