DROP INDEX sh.cust_country_id_idx
/
CREATE INDEX sh.cust_country_id_idx
ON sh.customers(country_id)
/
