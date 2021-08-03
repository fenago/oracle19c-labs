-- delete_orders 
-- Delete an order and all the items
--  commit

set echo on

DECLARE  
        max_records NUMBER(6) := 1800;
        min_records NUMBER(6) := 1200;
		limit_records NUMBER(6) := 500;
	new_order_id NUMBER(12);  	
	number_of_items  NUMBER(2,0);	
	v_cust_id NUMBER(6);
	max_cust_id  NUMBER(12);
	max_prod_id  NUMBER(12);
	dummy  VARCHAR2(1);
	num_records NUMBER(6);
	delay  NUMBER(6,2);
        record_count NUMBER(6);

BEGIN /* delete_order */ 
 
 num_records := &1;

 SELECT count(*) INTO record_count from OE.orders;
 IF record_count > limit_records THEN
	
	IF record_count > max_records THEN
		num_records := 2*num_records;
	ELSIF record_count < min_records THEN
		num_records := num_records/2;
	END IF;

-- Get an order randomly --  
	FOR j in 1..num_records LOOP
 
	<<NEXT_ORDER>>
	BEGIN 
	SELECT order_id INTO new_order_id
		FROM OE.ORDERS WHERE rownum <2;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN GOTO NEXT_ORDER;
	END;

-- 	DELETE the order_items

	DELETE FROM OE.ORDER_ITEMS WHERE ORDER_ID = new_order_id;
    DELETE FROM OE.ORDERS WHERE ORDER_ID = new_order_id;
	
	COMMIT;

	END LOOP;

ELSE
	NULL; -- Too few records to allow a delete
END IF;
END;
/

EXIT
