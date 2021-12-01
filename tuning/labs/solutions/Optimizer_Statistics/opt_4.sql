DROP TABLE customers3 PURGE; CREATE TABLE customers3 AS
SELECT *
FROM	customers
ORDER BY cust_last_name;

DESCRIBE customers3;
