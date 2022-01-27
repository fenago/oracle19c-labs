DECLARE
  v_custno	    number;
  v_last_name   varchar2(40);
  v_credit_limit   varchar2(40);

BEGIN


    SELECT CUST_ID, CUST_LAST_NAME,
       CASE
	 WHEN CUST_CREDIT_LIMIT < 100.00
	   THEN 'New Customer'
	 WHEN CUST_CREDIT_LIMIT BETWEEN 100.00 and 300.00
	   THEN 'Customer for AT LEAST 4 years'
	 WHEN CUST_CREDIT_LIMIT between 300.01 and 1000.00
	   THEN 'Customer for at LEAST 10 years'
	 else 'SURPRISE - SORRY NO MORE CREDIT'
       END as CREDIT
           into v_custno, v_last_name,v_credit_limit
   FROM CUSTOMERS
   WHERE CUST_ID = 101;
END;

/
