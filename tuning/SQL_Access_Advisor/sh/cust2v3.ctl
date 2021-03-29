LOAD DATA
APPEND
INTO TABLE customers
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
(CUST_ID,
 CUST_FIRST_NAME,
 CUST_LAST_NAME,
 CUST_GENDER,
 CUST_YEAR_OF_BIRTH,
 CUST_MARITAL_STATUS,
 CUST_STREET_ADDRESS,
 CUST_POSTAL_CODE,
 CUST_CITY,
 CUST_CITY_ID,
 CUST_STATE_PROVINCE,
 CUST_STATE_PROVINCE_ID,
 COUNTRY_ID,
 CUST_MAIN_PHONE_NUMBER,
 CUST_INCOME_LEVEL,
 CUST_CREDIT_LIMIT,
 CUST_EMAIL,
 CUST_TOTAL,
 CUST_TOTAL_ID,
 COMPANY_ID FILLER,
 CUST_SRC_ID,
 CUST_EFF_FROM DATE(10) "YYYY-MM-DD",
 CUST_EFF_TO DATE(10) "YYYY-MM-DD",
 CUST_VALID)