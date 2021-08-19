set echo on

CREATE table promotions_iot           
(promo_id number primary key
,  promo_name VARCHAR2(40)
,  promo_subcategory VARCHAR2 (30)
,  promo_category  VARCHAR2 (30)
,  promo_cost NUMBER
,  promo_begin_date DATE
,  promo_end_date DATE)
ORGANIZATION INDEX
/

INSERT INTO promotions_iot
SELECT promo_id, promo_name, promo_subcategory, promo_category, promo_cost, promo_begin_date, promo_end_date 
FROM promotions
/

