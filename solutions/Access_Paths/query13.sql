set echo on

set linesize 200
set timing on
set autotrace traceonly

SELECT *
FROM promotions
WHERE promo_id > 300
/

SELECT /*+ INDEX(promotions) */ *            
FROM promotions
WHERE promo_id > 300
/

set autotrace off
set timing off

