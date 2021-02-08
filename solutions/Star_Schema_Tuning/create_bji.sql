CREATE BITMAP INDEX sales_c_state_bjix ON sales(customers.cust_state_province) 
FROM sales, customers 
WHERE sales.cust_id=customers.cust_id 
LOCAL NOLOGGING COMPUTE STATISTICS;
