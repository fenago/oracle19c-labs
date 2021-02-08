LOAD DATA
APPEND
INTO TABLE sales
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '^'
(COMPANY_ID FILLER,
 PROD_ID,
 CUST_ID,
 TIME_ID DATE(10) "YYYY-MM-DD",
 CHANNEL_ID,
 PROMO_ID,
 QUANTITY_SOLD,
 AMOUNT_SOLD)
