DROP TABLE AUTHOR CASCADE CONSTRAINTS 
;
DROP TABLE PUBLISHER CASCADE CONSTRAINTS 
;
DROP TABLE BOOKS CASCADE CONSTRAINTS 
;
DROP TABLE CUSTOMER CASCADE CONSTRAINTS 
;
DROP TABLE CREDIT_CARD_DETAILS CASCADE CONSTRAINTS 
;
DROP TABLE ORDER_DETAILS CASCADE CONSTRAINTS 
;
DROP TABLE PURCHASE_HISTORY CASCADE CONSTRAINTS 
;
DROP TABLE SHIPPING_TYPE CASCADE CONSTRAINTS 
;
DROP TABLE SHOPPING_CART CASCADE CONSTRAINTS 
;

CREATE TABLE AUTHOR 
    ( 
      Author_ID VARCHAR2 (10)  NOT NULL , 
      Author_Name VARCHAR2 (20) 
    ) 
;



COMMENT ON TABLE AUTHOR IS 'Author'
;


ALTER TABLE AUTHOR 
    ADD CONSTRAINT AUTHOR_PK PRIMARY KEY (Author_ID) ;



CREATE TABLE BOOKS 
    ( 
     Book_ID VARCHAR2 (10)  NOT NULL , 
     Book_Name VARCHAR2 (50) , 
     Author_ID VARCHAR2 (10)  NOT NULL , 
     Price NUMBER (10) , 
     Publisher_ID VARCHAR2 (10)  NOT NULL 
    ) 
;



COMMENT ON TABLE BOOKS IS 'Books'
;


ALTER TABLE BOOKS 
    ADD CONSTRAINT books_PK PRIMARY KEY (Book_ID) ;



CREATE TABLE CUSTOMER 
    ( 
      Customer_ID VARCHAR2 (6) NOT NULL ,
      Customer_Name VARCHAR2 (40) , 
      Street_Address VARCHAR2 (50) , 
      City VARCHAR2 (25) ,   
      Phone_Number VARCHAR2 (15) , 
      Credit_Card_Number VARCHAR2 (20) NOT NULL 
      )
;



COMMENT ON TABLE AUTHOR IS 'Customer'
;

ALTER TABLE CUSTOMER
   ADD CONSTRAINT Cust_ID_PK PRIMARY KEY(Customer_ID);


CREATE TABLE CREDIT_CARD_DETAILS
    ( 
     Credit_Card_Number VARCHAR2 (20) NOT NULL , 
     Credit_Card_Type VARCHAR2 (15) , 
     Expiry_Date DATE
     )
;



COMMENT ON TABLE CREDIT_CARD_DETAILS IS 'Credit_Card_Details'
;

ALTER TABLE CREDIT_CARD_DETAILS
   ADD CONSTRAINT CC_NUMBER_PK PRIMARY KEY(Credit_Card_Number);



CREATE TABLE ORDER_DETAILS
    ( 
     Order_ID VARCHAR2(6)  NOT NULL , 
     Customer_ID VARCHAR2(6) NOT NULL ,
     Shipping_Type VARCHAR2(10)  NOT NULL , 
     Date_of_Purchase DATE , 
     Shopping_Cart_ID VARCHAR2 (10)  NOT NULL 
    ) 
;



COMMENT ON TABLE ORDER_DETAILS IS 'Order_Details'
;


ALTER TABLE ORDER_DETAILS 
    ADD CONSTRAINT Order_ID_PK PRIMARY KEY (Order_ID) ;



CREATE TABLE PUBLISHER 
    ( 
      Publisher_ID VARCHAR2 (10)  NOT NULL , 
      Publisher_Name VARCHAR2 (50) 
    ) 
;



COMMENT ON TABLE PUBLISHER IS 'Publisher'
;


ALTER TABLE PUBLISHER 
    ADD CONSTRAINT PUBLISHER_PK PRIMARY KEY (Publisher_ID) ;



CREATE TABLE PURCHASE_HISTORY
    ( 
     Customer_ID VARCHAR2 (6) NOT NULL , 
     Order_ID VARCHAR2 (6)  NOT NULL 
    ) 
;



COMMENT ON TABLE PURCHASE_HISTORY IS 'Purchase_History'
;



CREATE TABLE SHIPPING_TYPE 
    ( 
     Shipping_Type VARCHAR2 (10)  NOT NULL , 
     Shipping_Price NUMBER (6) 
    ) 
;



COMMENT ON TABLE SHIPPING_TYPE  IS 'Shipping_Type'
;


ALTER TABLE SHIPPING_TYPE  
    ADD CONSTRAINT SHIPPING_TYPE_PK PRIMARY KEY (Shipping_Type) ;



CREATE TABLE SHOPPING_CART
    ( 
     shopping_cart_id VARCHAR2 (10)  NOT NULL , 
     book_id VARCHAR2 (10)  NOT NULL , 
     price NUMBER (10) , 
     shopping_cart_date DATE , 
     quantity NUMBER (6) 
    ) 
;



COMMENT ON TABLE SHOPPING_CART IS 'Shopping_Cart'
;


ALTER TABLE SHOPPING_CART
    ADD CONSTRAINT SHOPPING_CART_PK PRIMARY KEY (Shopping_Cart_ID) ;






