set echo on
DROP INDEX sh.SALES_PROMO_BIX;
CREATE INDEX sh.i2_promo_id ON sh.sales (promo_id) GLOBAL ;

exit