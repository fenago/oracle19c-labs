-- Update_orders number_of_orders
-- Change the order status 
--  commit

set echo on

DECLARE  
	new_order_id NUMBER(12);  	
	number_of_items  NUMBER(2,0);	
	v_cust_id NUMBER(6);
	max_cust_id  NUMBER(12);
	max_prod_id  NUMBER(12);
	dummy  VARCHAR2(1);
	num_records NUMBER(6);
	delay  NUMBER(6,2);

BEGIN /* update_order */ 

 num_records := &1;

 FOR j IN 1..num_records LOOP
-- Get an order randomly --  
 
  <<NEXT_ORDER>>
  BEGIN 
  SELECT order_id INTO new_order_id
     FROM  OE.ORDERS 
     WHERE rownum <2;
  EXCEPTION
     WHEN NO_DATA_FOUND THEN GOTO NEXT_ORDER;
  END;

-- Update the order_status

  UPDATE OE.ORDERS SET ORDER_STATUS = MOD(ORDER_STATUS + 1, 10)
	WHERE ORDER_ID = new_order_id;
	
  COMMIT;

 END LOOP;
END;
/

EXIT
