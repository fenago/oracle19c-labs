





ALTER SESSION SET OPTIMIZER_USE_PENDING_STATISTICS = true;


UPDATE  sh.customers 
  SET   cust_email='ChalmersB@company.example.icom' 
  WHERE cust_first_name = 'Bruce' 
  AND   cust_last_name = 'Chalmers';
COMMIT;




BEGIN
  DBMS_STATS.PUBLISH_PENDING_STATS('SH','CUSTOMERS');
END;
/




BEGIN
  DBMS_STATS.SET_TABLE_PREFS('sh', 'sales', 'publish', 'false');
END;
