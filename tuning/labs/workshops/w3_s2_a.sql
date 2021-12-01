DROP INDEX sh.cust_fn_ln_idx
/
CREATE INDEX sh.cust_fn_ln_idx
ON sh.cust (cust_first_name, cust_last_name)
/