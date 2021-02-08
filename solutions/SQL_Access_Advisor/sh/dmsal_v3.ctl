LOAD DATA INFILE data
    INTO TABLE SALES
    APPEND
    FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '^'
(PROD_ID,
 CUST_ID,
 TIME_ID DATE(10) "YYYY-MM-DD",
 CHANNEL_ID,
 PROMO_ID,
 QUANTITY_SOLD "TO_NUMBER(:QUANTITY_SOLD,'99999999.99')",
 AMOUNT_SOLD "TO_NUMBER(:AMOUNT_SOLD,'99999999.99')")
