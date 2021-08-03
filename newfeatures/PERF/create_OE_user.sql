SET ECHO ON
DROP TABLESPACE example INCLUDING CONTENTS AND DATAFILES;
CREATE TABLESPACE example DATAFILE '/u02/app/oracle/oradata/ORCL/pdb1/example01.dbf' SIZE 500M AUTOEXTEND ON;

DROP USER oe CASCADE;
CREATE USER oe IDENTIFIED BY Welcome_1 DEFAULT TABLESPACE example;

GRANT create session, unlimited tablespace,create table TO oe;

CREATE TABLE oe.customers (CUSTOMER_ID NUMBER(6), CUST_FIRST_NAME VARCHAR2(20), CUST_LAST_NAME VARCHAR2(20),
                           CUST_ADDRESS VARCHAR2(20), PHONE_NUMBERS NUMBER,
						   NLS_LANGUAGE VARCHAR2(3), NLS_TERRITORY VARCHAR2(30), CREDIT_LIMIT NUMBER(9,2),
						   CUST_EMAIL VARCHAR2(30), ACCOUNT_MGR_ID NUMBER(6), 
						   CUST_GEO_LOCATION MDSYS.SDO_GEOMETRY, DATE_OF_BIRTH DATE, 
						   MARITAL_STATUS VARCHAR2(20), GENDER VARCHAR2(1), INCOME_LEVEL VARCHAR2(20));
INSERT INTO oe.customers VALUES (100, 'Charles','Dickens','London',010101010,'BRI','UK',1000,'chdickens',200,null,sysdate,'Married','M',10000);
INSERT INTO oe.customers VALUES (200, 'William','Faulkner','New Albany',020101010,'AM','US',2000,'wifaulkner',300,null,sysdate,'Married','M',15000);

CREATE TABLE oe.product_information (PRODUCT_ID NUMBER(6), PRODUCT_NAME VARCHAR2(50), 
                                     PRODUCT_DESCRIPTION VARCHAR2(2000), CATEGORY_ID NUMBER(2),
									 WEIGHT_CLASS NUMBER(1), WARRANTY_PERIOD number,
									 SUPPLIER_ID NUMBER(6), PRODUCT_STATUS VARCHAR2(20), LIST_PRICE NUMBER(8,2),
									 MIN_PRICE NUMBER(8,2), CATALOG_URL VARCHAR2(50));
INSERT INTO oe.product_information VALUES (1,'Pencil','For writing',1,1,2,1,'Avail',10,10,'url1');
INSERT INTO oe.product_information VALUES (2,'Booknote','For writing',1,2,2,1,'Avail',20,20,'url2');

CREATE TABLE oe.orders ( ORDER_ID NUMBER(12), ORDER_DATE TIMESTAMP(6) WITH LOCAL TIME ZONE, 
                         ORDER_MODE VARCHAR2(8), CUSTOMER_ID NUMBER(6), ORDER_STATUS NUMBER(2),
						 ORDER_TOTAL NUMBER(8,2), SALES_REP_ID NUMBER(6), PROMOTION_ID NUMBER(6));

create sequence OE.orders_seq start with 1 increment by 1 nomaxvalue  nocycle cache 10; 						 
INSERT INTO oe.orders VALUES (1,sysdate, 'MODE1',100, 30,8000,210,400);
INSERT INTO oe.orders VALUES (1,sysdate, 'MODE2',200, 30,9000,220,500);
INSERT INTO oe.orders VALUES (2,sysdate, 'MODE2',300, 40,5000,220,600);

CREATE TABLE oe.order_items (order_id NUMBER(12), LINE_ITEM_ID NUMBER(3), PRODUCT_ID NUMBER(6),
                             UNIT_PRICE NUMBER(8,2), QUANTITY NUMBER(8));
	
INSERT INTO oe.order_items VALUES (	1,1,1,210,2);
INSERT INTO oe.order_items VALUES (	1,2,2,210,2);
INSERT INTO oe.order_items VALUES (	2,1,1,210,4);
INSERT INTO oe.order_items VALUES (	2,2,2,210,4);

COMMIT;
EXIT