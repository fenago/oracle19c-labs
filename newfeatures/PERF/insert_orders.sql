-- Insert_orders number_of_Orders
-- Number_of orders must be specified
-- Get a new order_number 
--  create a random number of order items between 1-20
--  commit
--  Uses the order_seq sequence generator
-- expects that the setup_orders has been previously run to 
--  reset the sequence generator and foreign key constraint

set echo on

DECLARE  
        max_orders NUMBER(6) := 2000;
        min_orders NUMBER(6) := 1000;
        record_count NUMBER(6);
	new_order_id NUMBER(12);  
	new_order_total  NUMBER(12,2);
	number_of_items  NUMBER(2,0);
  	new_quantity NUMBER(8);
	new_prod_id NUMBER(6);
	new_sales_rep NUMBER(10);
  	v_unit_price NUMBER(8,2);
  	v_cust_id NUMBER(6);
        v_order_status NUMBER(2);
	max_cust_id  NUMBER(12);
	max_prod_id  NUMBER(12);
	parm1  VARCHAR2(6);
	num_records NUMBER(6) DEFAULT 1;
	delay  NUMBER(6,2);
        dummy VARCHAR2(1);
		

BEGIN /* insert_order */ 

  num_records := TO_NUMBER('&1');

  SELECT count(*) INTO record_count from OE.orders;

  IF record_count > max_orders THEN num_records := num_records - 5;
  ELSIF record_count < min_orders THEN num_records := num_records + 9;
  END IF;

  FOR j in 1 .. num_records LOOP
  SELECT ORDERS_SEQ.NEXTVAL, TRUNC(DBMS_RANDOM.VALUE(1,20)),
	TRUNC(DBMS_RANDOM.VALUE(150,179)), TRUNC(DBMS_RANDOM.VALUE(1,10))
	INTO new_order_id, number_of_items, new_sales_rep, v_order_status 
	FROM DUAL;
  
<<NEXT_CUST>> 

  BEGIN 

  SELECT customer_id INTO v_cust_id
     FROM  OE.CUSTOMERS WHERE rownum <2;
  EXCEPTION
     WHEN NO_DATA_FOUND THEN GOTO NEXT_CUST;
  END;
  
  new_order_total := 0;

   FOR i in 1 .. number_of_items LOOP

	<<NEXT_ITEM>>
     BEGIN
	BEGIN 

	SELECT PRODUCT_ID, NVL(LIST_PRICE,0), TRUNC(DBMS_RANDOM.VALUE(1,100))
	INTO new_prod_id, v_unit_price, new_quantity 
	FROM OE.PRODUCT_INFORMATION WHERE ROWNUM < 2;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN GOTO NEXT_ITEM;

	END;

    BEGIN	
	INSERT INTO OE.ORDER_ITEMS( ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY) 
	VALUES (new_order_id, i, new_prod_id, v_unit_price, new_quantity);

 	new_order_total := new_order_total + (v_unit_price*new_quantity);

	EXCEPTION 
	WHEN DUP_VAL_ON_INDEX THEN GOTO NEXT_ITEM;
	END;
    COMMIT;
      END; 
   END LOOP;


--     DBMS_OUTPUT.PUT_LINE('order_id='||new_order_id);
  INSERT INTO OE.ORDERS (ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID,	ORDER_STATUS, ORDER_TOTAL, SALES_REP_ID) 
	VALUES (new_order_id , SYSTIMESTAMP, 'online', v_cust_id, 1,
		new_order_total, new_sales_rep);
  COMMIT;

END LOOP;

END;
/

exit;
