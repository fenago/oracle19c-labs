DROP INDEX sh.cust_ln_fn_idx
/
CREATE INDEX sh.cust_ln_fn_idx
ON sh.cust (cust_last_name, cust_first_name)
/
