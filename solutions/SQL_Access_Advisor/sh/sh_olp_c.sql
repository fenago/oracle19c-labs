Rem
Rem $Header: sh_olp_c.sql 29-aug-2002.11:56:55 hyeh Exp $
Rem
Rem sh_olp_c.sql
Rem
Rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      sh_olp_c.sql - Create columns used by OLAP Server 
Rem
Rem    DESCRIPTION
Rem      SH is the Sales History schema of the Oracle 9i Sample
Rem	   Schemas
Rem
Rem    NOTES
Rem      
Rem
Rem    MODIFIED   (MM/DD/YY)
rem      hyeh      08/29/02 - hyeh_mv_comschema_to_rdbms
rem      ahunold   03/16/02 - fweek_pscat_sales_mv COMPILE
rem      ahunold   09/17/01 - sh_analz.sql
rem      ahunold   05/10/01 - Time dimension attributes
rem      pfay      04/10/01 - change case 
Rem      ahunold   04/05/01 - dimension names
Rem      ahunold   03/05/01 - external table, no DROPs
Rem      ahunold   02/07/01 - CMWLite
Rem      ahunold   02/01/01 - Merged ahunold_two_facts
Rem      hbaer     01/29/01 - Created
Rem

ALTER TABLE products
	ADD prod_total VARCHAR2(13)
	DEFAULT 'Product total';

ALTER TABLE customers
	ADD cust_total VARCHAR2(14)
	DEFAULT 'Customer total';

ALTER TABLE promotions
	ADD promo_total VARCHAR2(15)
	DEFAULT 'Promotion total';

ALTER TABLE channels
	ADD channel_total VARCHAR2(13)
	DEFAULT 'Channel total';

ALTER TABLE countries
	ADD country_total VARCHAR2(11)
	DEFAULT 'World total';

COMMIT;

Rem modified dimension definition to include new total column

DROP DIMENSION times_dim;

CREATE DIMENSION times_dim
   LEVEL day         IS TIMES.TIME_ID
   LEVEL month       IS TIMES.CALENDAR_MONTH_DESC
   LEVEL quarter     IS TIMES.CALENDAR_QUARTER_DESC
   LEVEL year        IS TIMES.CALENDAR_YEAR
   LEVEL fis_week    IS TIMES.WEEK_ENDING_DAY
   LEVEL fis_month   IS TIMES.FISCAL_MONTH_DESC
   LEVEL fis_quarter IS TIMES.FISCAL_QUARTER_DESC
   LEVEL fis_year    IS TIMES.FISCAL_YEAR
   HIERARCHY cal_rollup    (
             day     CHILD OF
             month   CHILD OF
             quarter CHILD OF
             year
   )
   HIERARCHY fis_rollup    (
             day         CHILD OF
             fis_week    CHILD OF
             fis_month	 CHILD OF
             fis_quarter CHILD OF
             fis_year
   )
   ATTRIBUTE day DETERMINES 
	(day_number_in_week, day_name, day_number_in_month,
         calendar_week_number)
   ATTRIBUTE month DETERMINES
	(calendar_month_desc,
         calendar_month_number, calendar_month_name,
         days_in_cal_month, end_of_cal_month)
   ATTRIBUTE quarter DETERMINES
	(calendar_quarter_desc,
         calendar_quarter_number,days_in_cal_quarter,
	 end_of_cal_quarter)
   ATTRIBUTE year DETERMINES
	(calendar_year,
         days_in_cal_year, end_of_cal_year)
   ATTRIBUTE fis_week DETERMINES
	(week_ending_day,
         fiscal_week_number)
   ATTRIBUTE fis_month DETERMINES
	(fiscal_month_desc, fiscal_month_number, fiscal_month_name,
	 days_in_fis_month, end_of_fis_month)
   ATTRIBUTE fis_quarter DETERMINES
	(fiscal_quarter_desc,
         fiscal_quarter_number, days_in_fis_quarter,
	 end_of_fis_quarter)
   ATTRIBUTE fis_year DETERMINES
	(fiscal_year, 
         days_in_fis_year, end_of_fis_year)
;

execute dbms_olap.validate_dimension('times_dim','sh',false,true)
SELECT COUNT(*) FROM mview$_exceptions;

DROP DIMENSION customers_dim;

CREATE DIMENSION customers_dim 
	LEVEL customer	IS (customers.cust_id)
	LEVEL city 	IS (customers.cust_city) 
	LEVEL state 	IS (customers.cust_state_province) 
	LEVEL country 	IS (countries.country_id) 
	LEVEL subregion IS (countries.country_subregion) 
	LEVEL region IS (countries.country_region) 
	LEVEL geog_total IS (countries.country_total) 
	LEVEL cust_total IS (customers.cust_total) 
	HIERARCHY cust_rollup (
		customer	CHILD OF
		city 		CHILD OF 
		state 		CHILD OF 
                cust_total
	)
	HIERARCHY geog_rollup (
		customer	CHILD OF
		city 		CHILD OF 
		state 		CHILD OF 
		country 	CHILD OF 
		subregion 	CHILD OF 		
		region          CHILD OF
                geog_total
	JOIN KEY (customers.country_id) REFERENCES country
	)
	ATTRIBUTE customer DETERMINES
	(cust_first_name, cust_last_name, cust_gender, 
	 cust_marital_status, cust_year_of_birth, 
	 cust_income_level, cust_credit_limit,
         cust_street_address, cust_postal_code,
         cust_main_phone_number, cust_email)
        ATTRIBUTE city DETERMINES (cust_city) 
        ATTRIBUTE state DETERMINES (cust_state_province) 
	ATTRIBUTE country DETERMINES (countries.country_name)
        ATTRIBUTE subregion DETERMINES (countries.country_subregion)
        ATTRIBUTE region DETERMINES (countries.country_region) 
        ATTRIBUTE geog_total DETERMINES (countries.country_total) 
        ATTRIBUTE cust_total DETERMINES (customers.cust_total) 
;

execute dbms_olap.validate_dimension('customers_dim','sh',false,true)
SELECT COUNT(*) FROM mview$_exceptions;

DROP DIMENSION products_dim;

CREATE DIMENSION products_dim 
	LEVEL product 		IS (products.prod_id)
 	LEVEL subcategory 	IS (products.prod_subcategory) 
	LEVEL category		IS (products.prod_category) 
	LEVEL prod_total	IS (products.prod_total) 
	HIERARCHY prod_rollup (
		product		CHILD OF 
		subcategory 	CHILD OF 
		category        CHILD OF
   		prod_total
	) 
	ATTRIBUTE product DETERMINES 
        (products.prod_name, products.prod_desc,
         prod_weight_class, prod_unit_of_measure,
         prod_pack_size,prod_status, prod_list_price, prod_min_price)
	ATTRIBUTE subcategory DETERMINES 
        (prod_subcategory, prod_subcat_desc)
	ATTRIBUTE category DETERMINES 
        (prod_category, prod_cat_desc)
	ATTRIBUTE prod_total DETERMINES 
        (prod_total)
;

execute dbms_olap.validate_dimension('products_dim','sh',false,true)
SELECT COUNT(*) FROM mview$_exceptions;

DROP DIMENSION promotions_dim;

CREATE DIMENSION promotions_dim 
	LEVEL promo 	  IS (promotions.promo_id) 
	LEVEL subcategory IS (promotions.promo_subcategory) 
	LEVEL category 	  IS (promotions.promo_category) 
	LEVEL promo_total IS (promotions.promo_total) 
	HIERARCHY promo_rollup (
		promo 		CHILD OF 
		subcategory 	CHILD OF 
		category	CHILD OF
		promo_total
	) 
	ATTRIBUTE promo DETERMINES 
        (promo_name, promo_cost,
         promo_begin_date, promo_end_date)
        ATTRIBUTE subcategory DETERMINES (promo_subcategory)
        ATTRIBUTE category DETERMINES (promo_category)
        ATTRIBUTE promo_total DETERMINES (promo_total)
;

execute dbms_olap.validate_dimension('promotions_dim','sh',false,true)
SELECT COUNT(*) FROM mview$_exceptions;

DROP DIMENSION channels_dim;

CREATE DIMENSION channels_dim 
	LEVEL channel 	   IS (channels.channel_id) 
	LEVEL channel_class IS (channels.channel_class) 
	LEVEL channel_total IS (channels.channel_total) 
	HIERARCHY channel_rollup (
		channel		CHILD OF 
		channel_class	CHILD OF 
		channel_total
	)
        ATTRIBUTE channel DETERMINES (channel_desc)
        ATTRIBUTE channel_class DETERMINES (channel_class)
        ATTRIBUTE channel_total DETERMINES (channel_total)
;

execute dbms_olap.validate_dimension('channels_dim','sh',false,true)
SELECT COUNT(*) FROM mview$_exceptions;

rem ---------------------------------------------------------------
rem    CMWLite
rem ---------------------------------------------------------------

set serveroutput on size 99999

declare 
  CUBE_TYPE constant varchar2(30) := 'CUBE';
  MEASURE_TYPE constant varchar2(30) := 'MEASURE';
  DIMENSION_TYPE constant varchar2(30) := 'DIMENSION';
  HIERARCHY_TYPE constant varchar2(30) := 'HIERARCHY';
  LEVEL_TYPE constant varchar2(30) := 'LEVEL';
  DIMENSION_ATTRIBUTE_TYPE constant varchar2(30) := 'DIMENSION ATTRIBUTE';
  LEVEL_ATTRIBUTE_TYPE constant varchar2(30) := 'LEVEL ATTRIBUTE';
  TABLE_TYPE constant varchar2(30) := 'TABLE';
  COLUMN_TYPE constant varchar2(30) := 'COLUMN';
  FOREIGN_KEY_TYPE constant varchar2(30) := 'FOREIGN KEY';
  FUNCTION_TYPE constant varchar2(30) := 'FUNCTION';
  PARAMETER_TYPE constant varchar2(30) := 'PARAMETER';
  CATALOG_TYPE constant varchar2(30) := 'CATALOG';
  DESCRIPTOR_TYPE constant varchar2(30) := 'DESCRIPTOR';
  INSTANCE_TYPE CONSTANT VARCHAR2(30) := 'INSTANCE';

  sh_products_dim number;
  sh_customers_dim number;
  sh_times_dim number;
  sh_channels_dim number;
  sh_promotions_dim number;
  time_desc_id number;
  time_span_id number;
  end_date_id number;
  long_desc_id number;
  short_desc_id number;
  desc_id number;
  name_id number;
  sh_catId number;
  tmp number;
  errtxt varchar(60);


begin
 dbms_output.put_line
('<<<<< CREATE CWMLite Metadata for the Sales History Schema >>>>>');
 dbms_output.put_line('-');
 dbms_output.put_line
('<<<<< CREATE CATALOG sh_cat for Sales History >>>>>');
begin
   select catalog_id into sh_catId
     from all_olap_catalogs
     where catalog_name = 'SH_CAT';
   cwm_classify.drop_catalog(sh_catId, true);
   dbms_output.put_line('	Catalog Dropped');
 exception
   when no_data_found then
     dbms_output.put_line('	No catalog to drop');
   when cwm_exceptions.catalog_not_found then
     dbms_output.put_line('	No catalog to drop');
 end;
 sh_catId := cwm_classify.create_catalog('SH_CAT', 'Sales History CWM Business Area');
 dbms_output.put_line('	CWM Collect Garbage');
 cwm_utility.collect_garbage;
 

dbms_output.put_line('-');
dbms_output.put_line
 ('<<<<< CREATE the Sales CUBE >>>>>');
dbms_output.put_line
 ('	Sales amount, Sales quantity 
	<TIMES CHANNELS PRODUCTS CUSTOMERS PROMOTIONS >');
begin
   dbms_output.put_line('	Drop SALES_CUBE prior to recreation');
   cwm_olap_cube.drop_cube(USER, 'SALES_CUBE');
   dbms_output.put_line('	Cube Dropped');
 exception
   when cwm_exceptions.cube_not_found then
     dbms_output.put_line('	No cube to drop');
 end;

CWM_OLAP_CUBE.Create_Cube(USER, 'SALES_CUBE' , 'Sales Analysis', 'Sales amount, Sales quantity <TIMES CHANNELS PRODUCTS CUSTOMERS PROMOTIONS >');

dbms_output.put_line
('	Add dimensions -
	 to SALES_CUBE and map the foreign keys');

-- 	The level name in the map_cube parameter list names  
--	the lowest level of aggregation.  It must be the 
--	lowest level in the dimension that contains data

sh_times_dim := CWM_OLAP_CUBE.Add_Dimension(USER, 'SALES_CUBE' , USER, 'TIMES_DIM', 'TIMES_DIM');
CWM_OLAP_CUBE.Map_Cube(USER, 'SALES_CUBE' , USER, 'SALES', 'SALES_TIME_FK', 'DAY', USER, 'TIMES_DIM', 'TIMES_DIM');

sh_channels_dim := CWM_OLAP_CUBE.Add_Dimension(USER, 'SALES_CUBE' , USER, 'CHANNELS_DIM', 'CHANNELS_DIM');
CWM_OLAP_CUBE.Map_Cube(USER, 'SALES_CUBE' , USER, 'SALES', 'SALES_CHANNEL_FK', 'CHANNEL', USER, 'CHANNELS_DIM', 'CHANNELS_DIM');

sh_products_dim := CWM_OLAP_CUBE.Add_Dimension(USER, 'SALES_CUBE' , USER, 'PRODUCTS_DIM', 'PRODUCTS_DIM');
CWM_OLAP_CUBE.Map_Cube(USER, 'SALES_CUBE' , USER, 'SALES', 'SALES_PRODUCT_FK', 'PRODUCT', USER, 'PRODUCTS_DIM', 'PRODUCTS_DIM');

sh_customers_dim := CWM_OLAP_CUBE.Add_Dimension(USER, 'SALES_CUBE' , USER, 'CUSTOMERS_DIM', 'CUSTOMERS_DIM');
CWM_OLAP_CUBE.Map_Cube(USER, 'SALES_CUBE' , USER, 'SALES', 'SALES_CUSTOMER_FK', 'CUSTOMER', USER, 'CUSTOMERS_DIM', 'CUSTOMERS_DIM');

sh_promotions_dim := CWM_OLAP_CUBE.Add_Dimension(USER, 'SALES_CUBE' , USER, 'PROMOTIONS_DIM', 'PROMOTIONS_DIM');
CWM_OLAP_CUBE.Map_Cube(USER, 'SALES_CUBE' , USER, 'SALES', 'SALES_PROMO_FK', 'PROMO', USER, 'PROMOTIONS_DIM', 'PROMOTIONS_DIM');


dbms_output.put_line
('	Create measures - 
	 for SALES_CUBE and map to columns in the fact table');

CWM_OLAP_MEASURE.Create_Measure
	(USER, 'SALES_CUBE' , 'SALES_AMOUNT', 'Sales', 'Dollar Sales');
CWM_OLAP_MEASURE.Set_Column_Map
	(USER, 'SALES_CUBE' , 'SALES_AMOUNT', USER, 'SALES', 'AMOUNT_SOLD');

CWM_OLAP_MEASURE.Create_Measure
	(USER, 'SALES_CUBE' , 'SALES_QUANTITY', 'Quantity', 'Quantity Sold');
CWM_OLAP_MEASURE.Set_Column_Map
	(USER, 'SALES_CUBE' , 'SALES_QUANTITY', USER, 'SALES', 'QUANTITY_SOLD');

dbms_output.put_line
('	Set default aggregation method -
	 to SUM for all measures over TIME');
 tmp:= cwm_utility.create_function_usage('SUM');
 cwm_olap_measure.set_default_aggregation_method
	(USER, 'SALES_CUBE', 'SALES_AMOUNT', tmp, USER, 'TIMES_DIM', 'TIMES_DIM');
 tmp:= cwm_utility.create_function_usage('SUM');
 cwm_olap_measure.set_default_aggregation_method
	(USER, 'SALES_CUBE', 'SALES_QUANTITY', tmp, USER, 'TIMES_DIM', 'TIMES_DIM');

dbms_output.put_line('	Add SALES_CUBE to the catalog');
 begin
   select catalog_id into sh_catId
     from all_olap_catalogs
     where catalog_name = 'SH_CAT';
   cwm_classify.add_catalog_entity(sh_catID, USER, 'SALES_CUBE', 'SALES_AMOUNT');
   cwm_classify.add_catalog_entity(sh_catID, USER, 'SALES_CUBE', 'SALES_QUANTITY');
   dbms_output.put_line('	SALES_CUBE successfully added to sh_cat');
 exception
   when no_data_found then
     dbms_output.put_line('        No sh_cat catalog to add sales_cube to');
 end;


dbms_output.put_line('-');
dbms_output.put_line
('<<<<< CREATE the Cost CUBE >>>>>');
dbms_output.put_line
 ('	Unit Cost, Unit Price < TIMES PRODUCTS >');
begin
   dbms_output.put_line('	Drop COST_CUBE prior to recreation');
   cwm_olap_cube.drop_cube(USER, 'COST_CUBE');
   dbms_output.put_line('	Cube Dropped');
 exception
   when cwm_exceptions.cube_not_found then
     dbms_output.put_line('      No cube to drop');
 end;

CWM_OLAP_CUBE.Create_Cube(USER, 'COST_CUBE' , 'Cost Analysis', 'Unit Cost, Unit Price < TIMES PRODUCTS >');


dbms_output.put_line
('	Add dimensions -
	 to COST_CUBE and map the foreign keys');

-- 	The level name in the map_cube parameter list names  
--	the lowest level of aggregation.  It must be the 
--	lowest level in the dimension that contains data

sh_times_dim := CWM_OLAP_CUBE.Add_Dimension(USER, 'COST_CUBE' , USER, 'TIMES_DIM', 'TIMES_DIM');
CWM_OLAP_CUBE.Map_Cube(USER, 'COST_CUBE' , USER, 'COSTS', 'COSTS_TIME_FK', 'DAY', USER, 'TIMES_DIM', 'TIMES_DIM');

sh_products_dim := CWM_OLAP_CUBE.Add_Dimension(USER, 'COST_CUBE' , USER, 'PRODUCTS_DIM', 'PRODUCTS_DIM');
CWM_OLAP_CUBE.Map_Cube(USER, 'COST_CUBE' , USER, 'COSTS', 'COSTS_PRODUCT_FK', 'PRODUCT', USER, 'PRODUCTS_DIM', 'PRODUCTS_DIM');


dbms_output.put_line
('	Create measures - 
	 for COST_CUBE and map to columns in the fact table');

CWM_OLAP_MEASURE.Create_Measure(USER, 'COST_CUBE' , 'UNIT_COST', 'Cost', 'Unit Cost Amount');
CWM_OLAP_MEASURE.Set_Column_Map(USER, 'COST_CUBE' , 'UNIT_COST', USER, 'COSTS', 'UNIT_COST');

CWM_OLAP_MEASURE.Create_Measure(USER, 'COST_CUBE' , 'UNIT_PRICE', 'Price', 'Unit Price Amount');
CWM_OLAP_MEASURE.Set_Column_Map(USER, 'COST_CUBE' , 'UNIT_PRICE', USER, 'COSTS', 'UNIT_PRICE');


dbms_output.put_line
('	Set default aggregation method -
	 to SUM for all measures over TIME');
 tmp:= cwm_utility.create_function_usage('SUM');
 cwm_olap_measure.set_default_aggregation_method
	(USER, 'COST_CUBE', 'UNIT_COST', tmp, USER, 'TIMES_DIM', 'TIMES_DIM');
 tmp:= cwm_utility.create_function_usage('SUM');
 cwm_olap_measure.set_default_aggregation_method
	(USER, 'COST_CUBE', 'UNIT_PRICE', tmp, USER, 'TIMES_DIM', 'TIMES_DIM');


dbms_output.put_line('	Add COST_CUBE to the catalog');
 begin
   select catalog_id into sh_catId
     from all_olap_catalogs
     where catalog_name = 'SH_CAT';
   cwm_classify.add_catalog_entity(sh_catID, USER, 'COST_CUBE', 'UNIT_COST');
   cwm_classify.add_catalog_entity(sh_catID, USER, 'COST_CUBE', 'UNIT_PRICE');
   dbms_output.put_line('	COST_CUBE successfully added to sh_cat');
   dbms_output.put_line(' ');
 exception
   when no_data_found then
     dbms_output.put_line('      No sh_cat catalog to add COST_CUBE to');
     dbms_output.put_line(' ');
 end;



dbms_output.put_line('-');
dbms_output.put_line('<<<<< TIME DIMENSION >>>>>');

dbms_output.put_line
('Dimension - display name, description and plural name');

CWM_OLAP_DIMENSION.set_display_name(USER, 'TIMES_DIM', 'Time');
CWM_OLAP_DIMENSION.set_description(USER, 'TIMES_DIM', 'Time Dimension Values');
CWM_OLAP_DIMENSION.set_plural_name(USER, 'TIMES_DIM', 'Times');

dbms_output.put_line
('Level - display name and description');

cwm_olap_level.set_display_name(USER, 'TIMES_DIM', 'DAY', 'Day');
cwm_olap_level.set_description(USER, 'TIMES_DIM', 'DAY', 'Day level of the Calendar hierarchy');

cwm_olap_level.set_display_name(USER, 'TIMES_DIM', 'MONTH', 'Month');
cwm_olap_level.set_description(USER, 'TIMES_DIM', 'MONTH', 'Month level of the Calendar hierarchy');
 
cwm_olap_level.set_display_name(USER, 'TIMES_DIM', 'QUARTER', 'Quarter');
cwm_olap_level.set_description(USER, 'TIMES_DIM', 'QUARTER', 'Quarter level of the Calendar hierarchy');
 
cwm_olap_level.set_display_name(USER, 'TIMES_DIM', 'YEAR', 'Year');
cwm_olap_level.set_description(USER, 'TIMES_DIM', 'YEAR', 'Year level of the Calendar hierarchy');

cwm_olap_level.set_display_name(USER, 'TIMES_DIM', 'FIS_WEEK', 'Fiscal Week');
cwm_olap_level.set_description(USER, 'TIMES_DIM',  'FIS_WEEK', 'Week level of the Fiscal hierarchy');

cwm_olap_level.set_display_name(USER, 'TIMES_DIM', 'FIS_MONTH', 'Fiscal Month');
cwm_olap_level.set_description(USER, 'TIMES_DIM', 'FIS_MONTH', 'Month level of the Fiscal hierarchy');
 
cwm_olap_level.set_display_name(USER, 'TIMES_DIM', 'FIS_QUARTER', 'Fiscal Quarter');
cwm_olap_level.set_description(USER, 'TIMES_DIM', 'FIS_QUARTER', 'Quarter level of the Fiscal hierarchy');
 
cwm_olap_level.set_display_name(USER, 'TIMES_DIM', 'FIS_YEAR', 'Fiscal Year');
cwm_olap_level.set_description(USER, 'TIMES_DIM', 'FIS_YEAR', 'Year level of the Fiscal hierarchy');  


dbms_output.put_line
('Hierarchy - display name and description');

cwm_olap_hierarchy.set_display_name(USER, 'TIMES_DIM', 'CAL_ROLLUP', 'Calendar');
cwm_olap_hierarchy.set_description(USER, 'TIMES_DIM', 'CAL_ROLLUP', 'Standard Calendar hierarchy');

cwm_olap_hierarchy.set_display_name(USER, 'TIMES_DIM', 'FIS_ROLLUP', 'Fiscal');
cwm_olap_hierarchy.set_description(USER, 'TIMES_DIM', 'FIS_ROLLUP', 'Fiscal hierarchy');


dbms_output.put_line('	- default calculation hierarchy');
cwm_olap_cube.set_default_calc_hierarchy(USER,'SALES_CUBE', 'CAL_ROLLUP', USER, 'TIMES_DIM', 'TIMES_DIM');
cwm_olap_cube.set_default_calc_hierarchy(USER,'COST_CUBE', 'CAL_ROLLUP', USER, 'TIMES_DIM', 'TIMES_DIM');


dbms_output.put_line('	- default display hierarchy');
cwm_olap_dimension.set_default_display_hierarchy(USER, 'TIMES_DIM', 'CAL_ROLLUP');


dbms_output.put_line
('Level Attributes - name, display name, description');

--	Level: DAY
cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'DAY', 'DAY_NUMBER_IN_WEEK', 'DAY_NUMBER_IN_WEEK');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'DAY', 'DAY_NUMBER_IN_WEEK',  'Day Number in Week');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'DAY', 'DAY_NUMBER_IN_WEEK',  'Day Number in Week where Monday is day number 1');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'DAY', 'DAY_NAME', 'DAY_NAME');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'DAY', 'DAY_NAME',  'Day Name');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'DAY', 'DAY_NAME',  'Name of the Day of the Week');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'DAY', 'DAY_NUMBER_IN_MONTH', 'DAY_NUMBER_IN_MONTH');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'DAY', 'DAY_NUMBER_IN_MONTH',  'Day Number in Month');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'DAY', 'DAY_NUMBER_IN_MONTH',  'Day number in month');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'DAY', 'CALENDAR_WEEK_NUMBER', 'CALENDAR_WEEK_NUMBER');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'DAY', 'CALENDAR_WEEK_NUMBER',  'Calendar Week Number');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'DAY', 'CALENDAR_WEEK_NUMBER',  'Calendar Week Number');

--	Level: MONTH
cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'MONTH', 'CALENDAR_MONTH_DESC', 'CALENDAR_MONTH_DESC');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'MONTH', 'CALENDAR_MONTH_DESC',  'Calendar Month');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'MONTH', 'CALENDAR_MONTH_DESC',  'Calendar Month Description');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'MONTH', 'CALENDAR_MONTH_NUMBER', 'CALENDAR_MONTH_NUMBER');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'MONTH', 'CALENDAR_MONTH_NUMBER',  'Calendar Month Number');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'MONTH', 'CALENDAR_MONTH_NUMBER',  'Month Number in Calendar year where January is month number 1');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'MONTH', 'CALENDAR_MONTH_NAME', 'CALENDAR_MONTH_NAME');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'MONTH', 'CALENDAR_MONTH_NAME',  'Calendar Month Name');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'MONTH', 'CALENDAR_MONTH_NAME',  'Name of the Month');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'MONTH', 'DAYS_IN_CAL_MONTH', 'DAYS_IN_CAL_MONTH');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'MONTH', 'DAYS_IN_CAL_MONTH',  'Days in Calendar Month');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'MONTH', 'DAYS_IN_CAL_MONTH',  'Number of Days in Calendar Month');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'MONTH', 'END_OF_CAL_MONTH', 'END_OF_CAL_MONTH');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'MONTH', 'END_OF_CAL_MONTH',  'End of Calendar Month');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'MONTH', 'END_OF_CAL_MONTH',  'Last Day of the Calendar Month');

--	Level: QUARTER
cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'QUARTER', 'CALENDAR_QUARTER_DESC', 'CALENDAR_QUARTER_DESC');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'QUARTER', 'CALENDAR_QUARTER_DESC',  'Calendar Quarter');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'QUARTER', 'CALENDAR_QUARTER_DESC',  'Calendar Quarter Description');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'QUARTER', 'CALENDAR_QUARTER_NUMBER', 'CALENDAR_QUARTER_NUMBER');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'QUARTER', 'CALENDAR_QUARTER_NUMBER',  'Calendar Quarter Number');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'QUARTER', 'CALENDAR_QUARTER_NUMBER',  'Calendar Quarter Number');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'QUARTER', 'DAYS_IN_CAL_QUARTER', 'DAYS_IN_CAL_QUARTER');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'QUARTER', 'DAYS_IN_CAL_QUARTER',  'Days in Calendar Quarter');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'QUARTER', 'DAYS_IN_CAL_QUARTER',  'Number of Days in Calendar Quarter');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'QUARTER', 'END_OF_CAL_QUARTER', 'END_OF_CAL_QUARTER');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'QUARTER', 'END_OF_CAL_QUARTER',  'End of Calendar Quarter');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'QUARTER', 'END_OF_CAL_QUARTER',  'Last Day of the Calendar Quarter');

--	Level: YEAR
cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'YEAR', 'CALENDAR_YEAR', 'CALENDAR_YEAR');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'YEAR', 'CALENDAR_YEAR',  'Calendar Year');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'YEAR', 'CALENDAR_YEAR',  'Calendar Year');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'YEAR', 'DAYS_IN_CAL_YEAR', 'DAYS_IN_CAL_YEAR');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'YEAR', 'DAYS_IN_CAL_YEAR',  'Days in Calendar Year');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'YEAR', 'DAYS_IN_CAL_YEAR',  'Number of Days in Calendar Year');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'YEAR', 'END_OF_CAL_YEAR', 'END_OF_CAL_YEAR');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'YEAR', 'END_OF_CAL_YEAR',  'End of Calendar Year');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'YEAR', 'END_OF_CAL_YEAR',  'Last Day of the Calendar Year');

--	Level: FISCAL WEEK
cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'FIS_WEEK', 'FISCAL_WEEK_NUMBER', 'FISCAL_WEEK_NUMBER');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'FIS_WEEK', 'FISCAL_WEEK_NUMBER',  'Fiscal Week Number');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'FIS_WEEK', 'FISCAL_WEEK_NUMBER',  'Fiscal Week Number');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'FIS_WEEK', 'WEEK_ENDING_DAY', 'WEEK_ENDING_DAY');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'FIS_WEEK', 'WEEK_ENDING_DAY',  'Fiscal Week Ending Day');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'FIS_WEEK', 'WEEK_ENDING_DAY',  'Fiscal Week Ending Day');

--	Level: FISCAL MONTH
cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'FIS_MONTH', 'FISCAL_MONTH_DESC', 'FISCAL_MONTH_DESC');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'FIS_MONTH', 'FISCAL_MONTH_DESC',  'Fiscal Month');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'FIS_MONTH', 'FISCAL_MONTH_DESC',  'Fiscal Month Description');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'FIS_MONTH', 'FISCAL_MONTH_NUMBER', 'FISCAL_MONTH_NUMBER');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'FIS_MONTH', 'FISCAL_MONTH_NUMBER',  'Fiscal Month Number');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'FIS_MONTH', 'FISCAL_MONTH_NUMBER',  'Fiscal Month Number');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'FIS_MONTH', 'FISCAL_MONTH_NAME', 'FISCAL_MONTH_NAME');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'FIS_MONTH', 'FISCAL_MONTH_NAME',  'Fiscal Month Name');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'FIS_MONTH', 'FISCAL_MONTH_NAME',  'Fiscal Month Name');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'FIS_MONTH', 'DAYS_IN_FIS_MONTH', 'DAYS_IN_FIS_MONTH');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'FIS_MONTH', 'DAYS_IN_FIS_MONTH',  'DAYS_IN_FIS_MONTH');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'FIS_MONTH', 'DAYS_IN_FIS_MONTH',  'Number of Days in Fiscal Month');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'FIS_MONTH', 'END_OF_FIS_MONTH', 'END_OF_FIS_MONTH');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'FIS_MONTH', 'END_OF_FIS_MONTH',  'End of Fiscal Month');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'FIS_MONTH', 'END_OF_FIS_MONTH',  'Last Day of the Fiscal Month');

--	Level: FISCAL QUARTER
cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'FIS_QUARTER', 
'FISCAL_QUARTER_NUMBER', 'FISCAL_QUARTER_NUMBER');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'FIS_QUARTER', 'FISCAL_QUARTER_NUMBER',  'Fiscal Quarter Number');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'FIS_QUARTER', 'FISCAL_QUARTER_NUMBER',  'Fiscal Quarter Number');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'FIS_QUARTER', 'DAYS_IN_FIS_QUARTER', 'DAYS_IN_FIS_QUARTER');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'FIS_QUARTER', 'DAYS_IN_FIS_QUARTER',  'Days in Fiscal Quarter');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'FIS_QUARTER', 'DAYS_IN_FIS_QUARTER',  'Number of Days in Fiscal Quarter');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'FIS_QUARTER', 'END_OF_FIS_QUARTER', 'END_OF_FIS_QUARTER');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'FIS_QUARTER', 'END_OF_FIS_QUARTER',  'End of Fiscal Quarter');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'FIS_QUARTER', 'END_OF_FIS_QUARTER',  'Last Day of the Fiscal Quarter');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'FIS_QUARTER', 'FISCAL_QUARTER_DESC', 'FISCAL_QUARTER_DESC');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'FIS_QUARTER', 'FISCAL_QUARTER_DESC',  'Fiscal Quarter Description');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'FIS_QUARTER', 'FISCAL_QUARTER_DESC',  'Fiscal Quarter Description');

--	Level: FISCAL YEAR
cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'FIS_YEAR', 'DAYS_IN_FIS_YEAR', 'DAYS_IN_FIS_YEAR');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'FIS_YEAR', 'DAYS_IN_FIS_YEAR',  'Days in Fiscal Year');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'FIS_YEAR', 'DAYS_IN_FIS_YEAR',  'Number of Days in Fiscal Year');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'FIS_YEAR', 'END_OF_FIS_YEAR', 'END_OF_FIS_YEAR');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'FIS_YEAR', 'END_OF_FIS_YEAR',  'End of Fiscal Year');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'FIS_YEAR', 'END_OF_FIS_YEAR',  'Last Day of the Fiscal Year');

cwm_olap_level_attribute.set_name(USER, 'TIMES_DIM', 'FIS_YEAR', 'FISCAL_YEAR', 'FISCAL_YEAR');
cwm_olap_level_attribute.set_display_name(USER, 'TIMES_DIM', 'FIS_YEAR', 'FISCAL_YEAR',  'Fiscal Year');
cwm_olap_level_attribute.set_description(USER, 'TIMES_DIM', 'FIS_YEAR', 'FISCAL_YEAR',  'Fiscal Year');


dbms_output.put_line
('Drop dimension attributes prior to re-creation');

 begin
    cwm_olap_dim_attribute.drop_dimension_attribute
	(USER, 'TIMES_DIM', 'Long Description');
    dbms_output.put_line('	- Long Description dropped');
 exception
    when cwm_exceptions.attribute_not_found then
      null;
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute
	(USER, 'TIMES_DIM', 'Short Description');
    dbms_output.put_line('	- Short Description dropped');
 exception
    when cwm_exceptions.attribute_not_found then
      null;
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute
	(USER, 'TIMES_DIM', 'Period Number of Days');
    dbms_output.put_line('	- Period Number of Days dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       null;
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute
	(USER, 'TIMES_DIM', 'Period End Date');
    dbms_output.put_line('	- Period End Date dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       null;
 end;


dbms_output.put_line
('Create dimension attributes and add their level attributes');

--	Level attributes must be associated with a Dimension attribute
--	SQL does not create Dimension attributes, so we do it here

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute
	(USER, 'TIMES_DIM', 'Long Description', 'Long Time Period Names', 'Full name of time periods');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Long Description', 'DAY', 'DAY_NAME');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Long Description', 'MONTH', 'CALENDAR_MONTH_DESC');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Long Description', 'FIS_MONTH', 'FISCAL_MONTH_DESC');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Long Description', 'QUARTER', 'CALENDAR_QUARTER_DESC');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Long Description', 'FIS_QUARTER', 'FISCAL_QUARTER_DESC');
dbms_output.put_line('	- Long Description created');
 
CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute
	(USER, 'TIMES_DIM', 'Short Description', 'Short Time Period Names', 'Short name of time periods');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Short Description', 'DAY', 'DAY_NAME');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Short Description', 'MONTH', 'CALENDAR_MONTH_DESC');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Short Description', 'FIS_MONTH', 'FISCAL_MONTH_DESC');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Short Description', 'QUARTER', 'CALENDAR_QUARTER_DESC');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Short Description', 'FIS_QUARTER', 'FISCAL_QUARTER_DESC');
dbms_output.put_line('	- Short Description created');
 
CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'TIMES_DIM', 'Period Number of Days', 'Period Number of Days', 'Number of Days in Time Period');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Period Number of Days', 'MONTH', 'DAYS_IN_CAL_MONTH');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Period Number of Days', 'QUARTER', 'DAYS_IN_CAL_QUARTER');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Period Number of Days', 'YEAR', 'DAYS_IN_CAL_YEAR');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Period Number of Days', 'FIS_MONTH', 'DAYS_IN_FIS_MONTH');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Period Number of Days', 'FIS_QUARTER', 'DAYS_IN_FIS_QUARTER');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Period Number of Days', 'FIS_YEAR', 'DAYS_IN_FIS_YEAR');
dbms_output.put_line('	- Period Number of Days created');

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'TIMES_DIM', 'Period End Date', 'Period End Date', 'Last Day in Time Period');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Period End Date', 'MONTH', 'END_OF_CAL_MONTH');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Period End Date', 'QUARTER', 'END_OF_CAL_QUARTER');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Period End Date', 'YEAR', 'END_OF_CAL_YEAR');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Period End Date', 'FIS_MONTH', 'END_OF_FIS_MONTH');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Period End Date', 'FIS_QUARTER', 'END_OF_FIS_QUARTER');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'TIMES_DIM', 'Period End Date', 'FIS_YEAR', 'END_OF_FIS_YEAR');
dbms_output.put_line('	- Period End Date created');

dbms_output.put_line
('Classify entity descriptor use');
 begin
	 SELECT descriptor_id INTO time_desc_id
       FROM all_olap_descriptors
       WHERE descriptor_value = 'Time'
       AND descriptor_type = 'Dimension Type';
       begin
           cwm_classify.add_entity_descriptor_use(time_desc_id, 
		'DIMENSION', USER, 'TIMES_DIM', 'TIMES');
           dbms_output.put_line('	- Time dimension');
         exception
           when cwm_exceptions.element_already_exists
              then null;
       end;
 end;

--	In this case it is the dimension attribute descriptors that are being classified
 begin
       SELECT descriptor_id INTO long_desc_id
       FROM all_olap_descriptors
       WHERE descriptor_value = 'Long Description'
       AND descriptor_type = 'Dimensional Attribute Descriptor';
       begin
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		DIMENSION_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'Long Description');
	     dbms_output.put_line('	- Long description');
         exception
           when cwm_exceptions.element_already_exists
              then null;
         end;         
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'DAY', 'DAY_NAME');
	     dbms_output.put_line('	- Day name');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'MONTH', 'CALENDAR_MONTH_DESC');
	   dbms_output.put_line('	- Calendar month description');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'QUARTER', 'CALENDAR_QUARTER_DESC');
	   dbms_output.put_line('	- Calendar quarter description');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
 	   	LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'FIS_MONTH', 'FISCAL_MONTH_DESC');
 	   dbms_output.put_line('	- Fiscal month description');
 	   exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
 	   	LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'FIS_QUARTER', 'FISCAL_QUARTER_DESC');
 	   dbms_output.put_line('	- Fiscal quarter description');
 	   exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
       end;
 end;

dbms_output.put_line('	- Short Description');
 begin
       SELECT descriptor_id INTO short_desc_id
       FROM all_olap_descriptors
       WHERE descriptor_value = 'Short Description'
       AND descriptor_type = 'Dimensional Attribute Descriptor';
       begin
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		DIMENSION_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'Short Description');
         exception
           when cwm_exceptions.element_already_exists
              then null;
         end;         
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'DAY', 'DAY_NAME');
	     dbms_output.put_line('	- Day name');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'MONTH', 'CALENDAR_MONTH_DESC');
	   dbms_output.put_line('	- Calendar month description');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'QUARTER', 'CALENDAR_QUARTER_DESC');
	   dbms_output.put_line('	- Calendar quarter description');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
 	   	LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'FIS_MONTH', 'FISCAL_MONTH_DESC');
 	   dbms_output.put_line('	- Fiscal month description');
 	   exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
 	   	LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'FIS_QUARTER', 'FISCAL_QUARTER_DESC');
 	   dbms_output.put_line('	- Fiscal quarter description');
 	   exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
       end;
 end;


dbms_output.put_line('	- Time Span');
 begin
       SELECT descriptor_id INTO time_span_id
       FROM all_olap_descriptors
       WHERE descriptor_value = 'Time Span'
       AND descriptor_type = 'Time Dimension Attribute Type';
       begin
         begin
           cwm_classify.add_entity_descriptor_use(time_span_id, 
		DIMENSION_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'Period Number of Days');
         exception
           when cwm_exceptions.element_already_exists
              then null;
         end;         
         begin
           cwm_classify.add_entity_descriptor_use(time_span_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'MONTH', 'DAYS_IN_CAL_MONTH');
	     dbms_output.put_line('	- Days in calendar month');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(time_span_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'QUARTER', 'DAYS_IN_CAL_QUARTER');
	   dbms_output.put_line('	- Days in calendar quarter');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(time_span_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'YEAR', 'DAYS_IN_CAL_YEAR');
	   dbms_output.put_line('	- Days in calendar year');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
	 begin
	   cwm_classify.add_entity_descriptor_use(time_span_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'FIS_MONTH', 'DAYS_IN_FIS_MONTH');
	   dbms_output.put_line('	- Days in fiscal month');
	 exception
	   when cwm_exceptions.element_already_exists 
	      then null;
	 end;
	 begin
	   cwm_classify.add_entity_descriptor_use(time_span_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'FIS_QUARTER', 'DAYS_IN_FIS_QUARTER');
	   dbms_output.put_line('	- Days in fiscal quarter');
	 exception
	   when cwm_exceptions.element_already_exists 
	      then null;
	 end;
	 begin
	   cwm_classify.add_entity_descriptor_use(time_span_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'FIS_YEAR', 'DAYS_IN_FIS_YEAR');
	   dbms_output.put_line('	- Days in fiscal year');
	 exception
	   when cwm_exceptions.element_already_exists 
	      then null;
         end;
       end;
 end;
 
 
 dbms_output.put_line('	- End Date');
  begin
        SELECT descriptor_id INTO end_date_id
        FROM all_olap_descriptors
        WHERE descriptor_value = 'End Date'
        AND descriptor_type = 'Time Dimension Attribute Type';
        begin
          begin
            cwm_classify.add_entity_descriptor_use(end_date_id, 
 		DIMENSION_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'Period End Date');
          exception
            when cwm_exceptions.element_already_exists
               then null;
          end;         
          begin
            cwm_classify.add_entity_descriptor_use(end_date_id, 
 		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'MONTH', 'END_OF_CAL_MONTH');
 	     dbms_output.put_line('	- End of calendar month');
          exception
            when cwm_exceptions.element_already_exists 
               then null;
          end;
          begin
            cwm_classify.add_entity_descriptor_use(end_date_id, 
 		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'QUARTER', 'END_OF_CAL_QUARTER');
 	   dbms_output.put_line('	- End of calendar quarter');
          exception
            when cwm_exceptions.element_already_exists 
               then null;
          end;
          begin
            cwm_classify.add_entity_descriptor_use(end_date_id, 
 		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'YEAR', 'END_OF_CAL_YEAR');
 	   dbms_output.put_line('	- End of calendar year');
          exception
            when cwm_exceptions.element_already_exists 
               then null;
          end;
 	 begin
 	   cwm_classify.add_entity_descriptor_use(end_date_id, 
 		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'FIS_MONTH', 'END_OF_FIS_MONTH');
 	   dbms_output.put_line('	- End of fiscal month');
 	 exception
 	   when cwm_exceptions.element_already_exists 
 	      then null;
 	 end;
 	 begin
 	   cwm_classify.add_entity_descriptor_use(end_date_id, 
 		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'FIS_QUARTER', 'END_OF_FIS_QUARTER');
 	   dbms_output.put_line('	- End of fiscal quarter');
 	 exception
 	   when cwm_exceptions.element_already_exists 
 	      then null;
 	 end;
 	 begin
 	   cwm_classify.add_entity_descriptor_use(end_date_id, 
 		LEVEL_ATTRIBUTE_TYPE, USER, 'TIMES_DIM', 'FIS_YEAR', 'END_OF_FIS_YEAR');
 	   dbms_output.put_line('	- End of fiscal year');
 	 exception
 	   when cwm_exceptions.element_already_exists 
 	      then null;
          end;
        end;
 end;
--- ------------------- Process the CUSTOMERS Dimension ------------

dbms_output.put_line('-');
dbms_output.put_line
('<<<<< CUSTOMERS DIMENSION >>>>>');
dbms_output.put_line
('Dimension - display name, description and plural name');

CWM_OLAP_DIMENSION.set_display_name(USER, 'CUSTOMERS_DIM', 'Customer');
CWM_OLAP_DIMENSION.set_description(USER, 'CUSTOMERS_DIM', 'Customer Dimension Values');
CWM_OLAP_DIMENSION.set_plural_name(USER, 'CUSTOMERS_DIM', 'Customers');


dbms_output.put_line
('Level - display name and description');

cwm_olap_level.set_display_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'Customer');
cwm_olap_level.set_description(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'Customer level of standard CUSTOMER hierarchy');

cwm_olap_level.set_display_name(USER, 'CUSTOMERS_DIM', 'CITY', 'City');
cwm_olap_level.set_description(USER, 'CUSTOMERS_DIM', 'CITY', 'City level of the standard CUSTOMER hierarchy');
 
cwm_olap_level.set_display_name(USER, 'CUSTOMERS_DIM', 'STATE', 'State');
cwm_olap_level.set_description(USER, 'CUSTOMERS_DIM', 'STATE', 'State level of the standard CUSTOMER hierarchy');

cwm_olap_level.set_display_name(USER, 'CUSTOMERS_DIM', 'COUNTRY', 'Country');
cwm_olap_level.set_description(USER, 'CUSTOMERS_DIM', 'COUNTRY', 'Country level of the standard CUSTOMER hierarchy');

cwm_olap_level.set_display_name(USER, 'CUSTOMERS_DIM', 'SUBREGION', 'Subregion');
cwm_olap_level.set_description(USER, 'CUSTOMERS_DIM', 'SUBREGION', 'Subregion level of the standard CUSTOMER hierarchy');
 
cwm_olap_level.set_display_name(USER, 'CUSTOMERS_DIM', 'REGION', 'Region');
cwm_olap_level.set_description(USER, 'CUSTOMERS_DIM', 'REGION', 'Region level of the standard CUSTOMER hierarchy');
 
cwm_olap_level.set_display_name(USER, 'CUSTOMERS_DIM', 'GEOG_TOTAL', 'Geography Total');
cwm_olap_level.set_description(USER, 'CUSTOMERS_DIM', 'GEOG_TOTAL', 'Geography Total for the standard CUSTOMER hierarchy');
 
cwm_olap_level.set_display_name(USER, 'CUSTOMERS_DIM', 'CUST_TOTAL', 'Customer Total');
cwm_olap_level.set_description(USER, 'CUSTOMERS_DIM', 'CUST_TOTAL', 'Customer Total for the standard CUSTOMER hierarchy');
  

dbms_output.put_line
('Hierarchy - display name and description');

cwm_olap_hierarchy.set_display_name(USER, 'CUSTOMERS_DIM', 'GEOG_ROLLUP', 'Standard');
cwm_olap_hierarchy.set_description(USER, 'CUSTOMERS_DIM', 'GEOG_ROLLUP', 'Standard GEOGRAPHY hierarchy');

cwm_olap_hierarchy.set_display_name(USER, 'CUSTOMERS_DIM', 'CUST_ROLLUP', 'Standard');
cwm_olap_hierarchy.set_description(USER, 'CUSTOMERS_DIM', 'CUST_ROLLUP', 'Standard CUSTOMER hierarchy');


dbms_output.put_line('	- default calculation hierarchy');
cwm_olap_cube.set_default_calc_hierarchy(USER,'SALES_CUBE', 'GEOG_ROLLUP', USER, 'CUSTOMERS_DIM', 'CUSTOMERS_DIM');


dbms_output.put_line('	- default display hierarchy');
cwm_olap_dimension.set_default_display_hierarchy(USER, 'CUSTOMERS_DIM', 'GEOG_ROLLUP');


dbms_output.put_line
('Level Attributes - name, display name, description');

--	Level: CUSTOMER

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_FIRST_NAME', 'CUST_FIRST_NAME');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_FIRST_NAME', 'First Name');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_FIRST_NAME', 'Customer First Name');

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_LAST_NAME', 'CUST_LAST_NAME');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_LAST_NAME', 'Last Name');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_LAST_NAME', 'Customer Last Name');

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_GENDER', 'CUST_GENDER');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_GENDER', 'Gender');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_GENDER', 'Customer Gender');

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_MARITAL_STATUS', 'CUST_MARITAL_STATUS');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_MARITAL_STATUS', 'Marital Status');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_MARITAL_STATUS', 'Customer Marital Status');

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_YEAR_OF_BIRTH', 'CUST_YEAR_OF_BIRTH');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_YEAR_OF_BIRTH', 'Year of Birth');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_YEAR_OF_BIRTH', 'Customer Year of Birth');

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_INCOME_LEVEL', 'CUST_INCOME_LEVEL');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_INCOME_LEVEL', 'Income Level');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_INCOME_LEVEL', 'Customer Income Level');

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_CREDIT_LIMIT', 'CUST_CREDIT_LIMIT');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_CREDIT_LIMIT', 'Credit Limit');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_CREDIT_LIMIT', 'Customer Credit Limit');

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_STREET_ADDRESS', 'CUST_STREET_ADDRESS');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_STREET_ADDRESS', 'Street Address');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_STREET_ADDRESS', 'Customer Street Address');

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_POSTAL_CODE', 'CUST_POSTAL_CODE');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_POSTAL_CODE', 'Postal Code');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_POSTAL_CODE', 'Customer Postal Code');

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_MAIN_PHONE_NUMBER', 'CUST_MAIN_PHONE_NUMBER');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_MAIN_PHONE_NUMBER', 'Main Phone Number');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_MAIN_PHONE_NUMBER', 'Customer Main Phone Number');

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_EMAIL', 'CUST_EMAIL');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_EMAIL', 'E-mail');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_EMAIL', 'Customer E-mail');

--	Level: CITY

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'CITY', 'CUST_CITY', 'CUST_CITY');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'CITY', 'CUST_CITY', 'City');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'CITY', 'CUST_CITY', 'City Name');

--	Level: STATE

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'STATE', 'CUST_STATE_PROVINCE', 'CUST_STATE_PROVINCE');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'STATE', 'CUST_STATE_PROVINCE', 'State/Province');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'STATE', 'CUST_STATE_PROVINCE', 'State/Province Name');

--	Level: SUBREGION

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'SUBREGION', 'COUNTRY_SUBREGION', 'COUNTRY_SUBREGION');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'SUBREGION', 'COUNTRY_SUBREGION', 'Subregion');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'SUBREGION', 'COUNTRY_SUBREGION', 'Subregion Name');

--	Level: REGION

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'REGION', 'COUNTRY_REGION', 'COUNTRY_REGION');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'REGION', 'COUNTRY_REGION', 'Region');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'REGION', 'COUNTRY_REGION', 'Region Name');

--	Level: COUNTRY

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'COUNTRY', 'COUNTRY_NAME', 'COUNTRY_NAME');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'COUNTRY', 'COUNTRY_NAME', 'Country Name');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'COUNTRY', 'COUNTRY_NAME', 'Country Name');

--	Level: GEOGRAPHY TOTAL

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'GEOG_TOTAL', 'COUNTRY_TOTAL', 'COUNTRY_TOTAL');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'GEOG_TOTAL', 'COUNTRY_TOTAL', 'Country Total');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'GEOG_TOTAL', 'COUNTRY_TOTAL', 'Country Total');

--	Level: CUSTOMER TOTAL

cwm_olap_level_attribute.set_name(USER, 'CUSTOMERS_DIM', 'CUST_TOTAL', 'CUST_TOTAL', 'CUST_TOTAL');
cwm_olap_level_attribute.set_display_name(USER, 'CUSTOMERS_DIM', 'CUST_TOTAL', 'CUST_TOTAL', 'Customer Total');
cwm_olap_level_attribute.set_description(USER, 'CUSTOMERS_DIM', 'CUST_TOTAL', 'CUST_TOTAL', 'Customer Total');


dbms_output.put_line
('Drop dimension attributes prior to re-creation');

 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Long Description');
    dbms_output.put_line('	- Long Description dropped');
 exception
    when cwm_exceptions.attribute_not_found then
      null;
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Short Description' );
    dbms_output.put_line('	- Short Description dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       dbms_output.put_line('      No attribute to drop');
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'CUSTOMERS_DIM', 'First Name');
    dbms_output.put_line('	- First Name dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       dbms_output.put_line('      No attribute to drop');
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Last Name');
    dbms_output.put_line('	- Last Name dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       dbms_output.put_line('      No attribute to drop');
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Gender');
    dbms_output.put_line('	- Gender dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       dbms_output.put_line('      No attribute to drop');
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Marital Status');
    dbms_output.put_line('	- Marital Status dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       dbms_output.put_line('      No attribute to drop');
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Year of Birth');
    dbms_output.put_line('	- Year of Birth dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       dbms_output.put_line('      No attribute to drop');
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Income Level');
    dbms_output.put_line('	- Income Level dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       dbms_output.put_line('      No attribute to drop');
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Credit Limit');
    dbms_output.put_line('	- Credit Limit dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       dbms_output.put_line('	No attribute to drop');
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Street Address');
    dbms_output.put_line('	- Street Address dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       dbms_output.put_line('      No attribute to drop');
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Postal Code');
    dbms_output.put_line('	- Postal Code dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       dbms_output.put_line('      No attribute to drop');
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Phone Number');
    dbms_output.put_line('	- Phone Number dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       dbms_output.put_line('	No attribute to drop');
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'CUSTOMERS_DIM', 'E-mail');
    dbms_output.put_line('	- E-mail dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       dbms_output.put_line('	No attribute to drop');
 end;

dbms_output.put_line
('Create dimension attributes and add their level attributes');
  
CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Long Description', 'Customer Information', 'Long Description of Customer Information');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Long Description', 'CUSTOMER', 'CUST_LAST_NAME');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Long Description', 'CITY', 'CUST_CITY');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Long Description', 'STATE', 'CUST_STATE_PROVINCE');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Long Description', 'COUNTRY', 'COUNTRY_NAME');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Long Description', 'SUBREGION', 'COUNTRY_SUBREGION');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Long Description', 'REGION', 'COUNTRY_REGION');
dbms_output.put_line('	- Long Description created');
  
CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Short Description', 'Customer Information', 'Short Description of Customer Information');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Short Description', 'CUSTOMER', 'CUST_LAST_NAME');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Short Description', 'CITY', 'CUST_CITY');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Short Description', 'STATE', 'CUST_STATE_PROVINCE');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Short Description', 'COUNTRY', 'COUNTRY_NAME');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Short Description', 'SUBREGION', 'COUNTRY_SUBREGION');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Short Description', 'REGION', 'COUNTRY_REGION');
dbms_output.put_line('	- Short Description created');

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'CUSTOMERS_DIM', 'First Name', 'First Name', 'First Name');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'First Name', 'CUSTOMER', 'CUST_FIRST_NAME');

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Last Name', 'Last Name', 'Last Name');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Last Name', 'CUSTOMER', 'CUST_LAST_NAME');

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Gender', 'Gender', 'Gender');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Gender', 'CUSTOMER', 'CUST_GENDER');

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Marital Status', 'Marital Status', 'Marital Status');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Marital Status', 'CUSTOMER', 'CUST_MARITAL_STATUS');

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Year of Birth', 'Year of Birth', 'Year of Birth');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Year of Birth', 'CUSTOMER', 'CUST_YEAR_OF_BIRTH');

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Income Level', 'Income Level', 'Income Level');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Income Level', 'CUSTOMER', 'CUST_INCOME_LEVEL');

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Credit Limit', 'Credit Limit', 'Credit Limit');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Credit Limit', 'CUSTOMER', 'CUST_CREDIT_LIMIT');

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Street Address', 'Street Address', 'Street Address');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Street Address', 'CUSTOMER', 'CUST_STREET_ADDRESS');

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Postal Code', 'Postal Code', 'Postal Code');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Postal Code', 'CUSTOMER', 'CUST_POSTAL_CODE');

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'CUSTOMERS_DIM', 'Phone Number', 'Phone Number', 'Phone Number');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'Phone Number', 'CUSTOMER', 'CUST_MAIN_PHONE_NUMBER');

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'CUSTOMERS_DIM', 'E-mail', 'E-mail', 'E-mail');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CUSTOMERS_DIM', 'E-mail', 'CUSTOMER', 'CUST_EMAIL');
dbms_output.put_line('	- Other Customer Information created');


dbms_output.put_line
('Classify entity descriptor use');
 begin
       SELECT descriptor_id INTO long_desc_id
       FROM all_olap_descriptors
       WHERE descriptor_value = 'Long Description'
       AND descriptor_type = 'Dimensional Attribute Descriptor';
       begin
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		DIMENSION_ATTRIBUTE_TYPE, USER, 'CUSTOMERS_DIM', 'Long Description');
         exception
           when cwm_exceptions.element_already_exists
              then null;
         end;         
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_LAST_NAME');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'CUSTOMERS_DIM', 'CITY', 'CUST_CITY');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'CUSTOMERS_DIM', 'STATE', 'CUST_STATE_PROVINCE');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'CUSTOMERS_DIM', 'COUNTRY', 'COUNTRY_NAME');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'CUSTOMERS_DIM', 'SUBREGION', 'COUNTRY_SUBREGION');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'CUSTOMERS_DIM', 'REGION', 'COUNTRY_REGION');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
       end;
	 dbms_output.put_line('	- Long Description');
 end;

begin
       SELECT descriptor_id INTO short_desc_id
       FROM all_olap_descriptors
       WHERE descriptor_value = 'Short Description'
       AND descriptor_type = 'Dimensional Attribute Descriptor';
       begin
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		DIMENSION_ATTRIBUTE_TYPE, USER, 'CUSTOMERS_DIM', 'Short Description');
         exception
           when cwm_exceptions.element_already_exists
              then null;
         end;         
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'CUSTOMERS_DIM', 'CUSTOMER', 'CUST_LAST_NAME');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'CUSTOMERS_DIM', 'CITY', 'CUST_CITY');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'CUSTOMERS_DIM', 'STATE', 'CUST_STATE_PROVINCE');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'CUSTOMERS_DIM', 'COUNTRY', 'COUNTRY_NAME');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'CUSTOMERS_DIM', 'SUBREGION', 'COUNTRY_SUBREGION');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'CUSTOMERS_DIM', 'REGION', 'COUNTRY_REGION');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
       end;
	 dbms_output.put_line('	- Short Description');
 end;

-- ------------------- Process the PRODUCT Dimension --------------

dbms_output.put_line('-');
dbms_output.put_line
('<<<<< PRODUCTS DIMENSION >>>>>');
dbms_output.put_line
('Dimension - display name, description and plural name');

CWM_OLAP_DIMENSION.set_display_name(USER, 'PRODUCTS_DIM', 'Product');
CWM_OLAP_DIMENSION.set_description(USER, 'PRODUCTS_DIM', 'Product Dimension Values');
CWM_OLAP_DIMENSION.set_plural_name(USER, 'PRODUCTS_DIM', 'Products');


dbms_output.put_line
('Level - display name and description');

cwm_olap_level.set_display_name(USER, 'PRODUCTS_DIM', 'PRODUCT', 'Products');
cwm_olap_level.set_description(USER, 'PRODUCTS_DIM', 'PRODUCT', 'Product level of standard PRODUCT hierarchy');

cwm_olap_level.set_display_name(USER, 'PRODUCTS_DIM', 'SUBCATEGORY', 'Sub-categories');
cwm_olap_level.set_description(USER, 'PRODUCTS_DIM', 'SUBCATEGORY', 'Sub-category level of standard PRODUCT hierarchy');
 
cwm_olap_level.set_display_name(USER, 'PRODUCTS_DIM', 'CATEGORY', 'Categories');
cwm_olap_level.set_description(USER, 'PRODUCTS_DIM', 'CATEGORY', 'Category level of standard PRODUCT hierarchy');
 
cwm_olap_level.set_display_name(USER, 'PRODUCTS_DIM', 'PROD_TOTAL', 'Product Total');
cwm_olap_level.set_description(USER, 'PRODUCTS_DIM', 'PROD_TOTAL', 'Product Total for the standard PRODUCT hierarchy');
  

dbms_output.put_line
('Hierarchy - display name and description');

cwm_olap_hierarchy.set_display_name(USER, 'PRODUCTS_DIM', 'PROD_ROLLUP', 'Standard');
cwm_olap_hierarchy.set_description(USER, 'PRODUCTS_DIM', 'PROD_ROLLUP', 'Standard Product hierarchy');


dbms_output.put_line('	- default calculation hierarchy');
cwm_olap_cube.set_default_calc_hierarchy(USER,'SALES_CUBE', 'PROD_ROLLUP', USER, 'PRODUCTS_DIM', 'PRODUCTS_DIM');
cwm_olap_cube.set_default_calc_hierarchy(USER,'COST_CUBE', 'PROD_ROLLUP', USER, 'PRODUCTS_DIM', 'PRODUCTS_DIM');


dbms_output.put_line('	- default display hierarchy');
cwm_olap_dimension.set_default_display_hierarchy(USER, 'PRODUCTS_DIM', 'PROD_ROLLUP');


dbms_output.put_line
('Level Attributes - name, display name, description');

--	Level: PRODUCT
cwm_olap_level_attribute.set_name(USER, 'PRODUCTS_DIM', 'PRODUCT', 'PROD_NAME', 'PROD_NAME');
cwm_olap_level_attribute.set_display_name(USER, 'PRODUCTS_DIM', 'PRODUCT', 'PROD_NAME',  'Product Name(s)');
cwm_olap_level_attribute.set_description(USER, 'PRODUCTS_DIM', 'PRODUCT', 'PROD_NAME',  'Names for Product values of the Standard Product hierarchy');

cwm_olap_level_attribute.set_name(USER, 'PRODUCTS_DIM', 'PRODUCT', 'PROD_DESC', 'PROD_DESC');
cwm_olap_level_attribute.set_display_name(USER, 'PRODUCTS_DIM', 'PRODUCT', 'PROD_DESC',  'Product Description');
cwm_olap_level_attribute.set_description(USER, 'PRODUCTS_DIM', 'PRODUCT', 'PROD_DESC',  'Product Description including characteristics of the product');

cwm_olap_level_attribute.set_name(USER, 'PRODUCTS_DIM', 'PRODUCT', 'PROD_WEIGHT_CLASS', 'PROD_WEIGHT_CLASS');
cwm_olap_level_attribute.set_display_name(USER, 'PRODUCTS_DIM', 'PRODUCT', 'PROD_WEIGHT_CLASS',  'Weight Class');
cwm_olap_level_attribute.set_description(USER, 'PRODUCTS_DIM', 'PRODUCT', 'PROD_WEIGHT_CLASS',  'Product Weight Class');

cwm_olap_level_attribute.set_name(USER, 'PRODUCTS_DIM', 'PRODUCT', 'PROD_UNIT_OF_MEASURE', 'PROD_UNIT_OF_MEASURE');
cwm_olap_level_attribute.set_display_name(USER, 'PRODUCTS_DIM', 'PRODUCT', 'PROD_UNIT_OF_MEASURE',  'Unit of Measure');
cwm_olap_level_attribute.set_description(USER, 'PRODUCTS_DIM', 'PRODUCT', 'PROD_UNIT_OF_MEASURE',  'Product Unit of Measure');

--	Level: SUBCATEGORY
cwm_olap_level_attribute.set_name(USER, 'PRODUCTS_DIM', 'SUBCATEGORY', 'PROD_SUBCATEGORY', 'PROD_SUBCATEGORY');
cwm_olap_level_attribute.set_display_name(USER, 'PRODUCTS_DIM', 'SUBCATEGORY', 'PROD_SUBCATEGORY',  'Sub-category');
cwm_olap_level_attribute.set_description(USER, 'PRODUCTS_DIM', 'SUBCATEGORY', 'PROD_SUBCATEGORY',  'Product Sub-category');

cwm_olap_level_attribute.set_name(USER, 'PRODUCTS_DIM', 'SUBCATEGORY', 'PROD_SUBCAT_DESC', 'PROD_SUBCAT_DESC');
cwm_olap_level_attribute.set_display_name(USER, 'PRODUCTS_DIM', 'SUBCATEGORY', 'PROD_SUBCAT_DESC',  'Sub-category Description');
cwm_olap_level_attribute.set_description(USER, 'PRODUCTS_DIM', 'SUBCATEGORY', 'PROD_SUBCAT_DESC',  'Product Sub-category Description');

--	Level: CATEGORY
cwm_olap_level_attribute.set_name(USER, 'PRODUCTS_DIM', 'CATEGORY', 'PROD_CATEGORY', 'PROD_CATEGORY');
cwm_olap_level_attribute.set_display_name(USER, 'PRODUCTS_DIM', 'CATEGORY', 'PROD_CATEGORY',  'Category');
cwm_olap_level_attribute.set_description(USER, 'PRODUCTS_DIM', 'CATEGORY', 'PROD_CATEGORY',  'Product category');

cwm_olap_level_attribute.set_name(USER, 'PRODUCTS_DIM', 'CATEGORY', 'PROD_CAT_DESC', 'PROD_CAT_DESC');
cwm_olap_level_attribute.set_display_name(USER, 'PRODUCTS_DIM', 'CATEGORY', 'PROD_CAT_DESC',  'Category Description');
cwm_olap_level_attribute.set_description(USER, 'PRODUCTS_DIM', 'CATEGORY', 'PROD_CAT_DESC',  'Product Category Description');

--	Level: PRODUCT TOTAL
cwm_olap_level_attribute.set_name(USER, 'PRODUCTS_DIM', 'PROD_TOTAL', 'PROD_TOTAL', 'PROD_TOTAL');
cwm_olap_level_attribute.set_display_name(USER, 'PRODUCTS_DIM', 'PROD_TOTAL', 'PROD_TOTAL',  'Product Total');
cwm_olap_level_attribute.set_description(USER, 'PRODUCTS_DIM', 'PROD_TOTAL', 'PROD_TOTAL',  'Product Total');


dbms_output.put_line
('Drop dimension attributes prior to re-creation');

 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'PRODUCTS_DIM', 'Long Description');
    dbms_output.put_line('	- Long Description dropped');
 exception
    when cwm_exceptions.attribute_not_found then
      null;
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'PRODUCTS_DIM', 'Short Description' );
    dbms_output.put_line('	- Short Description dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       dbms_output.put_line('No attribute to drop');
 end;


dbms_output.put_line
('Create dimension attributes and add their level attributes');
  
CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'PRODUCTS_DIM', 'Long Description', 'Long Product Description', 'Full Description of Products');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'PRODUCTS_DIM', 'Long Description', 'PRODUCT', 'PROD_DESC');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'PRODUCTS_DIM', 'Long Description', 'SUBCATEGORY', 'PROD_SUBCAT_DESC');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'PRODUCTS_DIM', 'Long Description', 'CATEGORY', 'PROD_CAT_DESC');
dbms_output.put_line('	- Long Description created');

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'PRODUCTS_DIM', 'Short Description', 'Short Product Names', 'Short name of Products');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'PRODUCTS_DIM', 'Short Description', 'PRODUCT', 'PROD_NAME');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'PRODUCTS_DIM', 'Short Description', 'SUBCATEGORY', 'PROD_SUBCAT_DESC');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'PRODUCTS_DIM', 'Short Description', 'CATEGORY', 'PROD_CAT_DESC');
dbms_output.put_line('	- Short Description created');


dbms_output.put_line
('Classify entity descriptor use');

 begin
       SELECT descriptor_id INTO long_desc_id
       FROM all_olap_descriptors
       WHERE descriptor_value = 'Long Description'
       AND descriptor_type = 'Dimensional Attribute Descriptor';
       begin
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		DIMENSION_ATTRIBUTE_TYPE, USER, 'PRODUCTS_DIM', 'Long Description');
         exception
           when cwm_exceptions.element_already_exists
              then null;
         end;         
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'PRODUCTS_DIM', 'PRODUCT', 'PROD_DESC');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'PRODUCTS_DIM', 'SUBCATEGORY', 'PROD_SUBCAT_DESC');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'PRODUCTS_DIM', 'CATEGORY', 'PROD_CAT_DESC');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
       end;
  	 dbms_output.put_line('	- Long Description');
 end;

 begin
       SELECT descriptor_id INTO short_desc_id
       FROM all_olap_descriptors
       WHERE descriptor_value = 'Short Description'
       AND descriptor_type = 'Dimensional Attribute Descriptor';
       begin
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		DIMENSION_ATTRIBUTE_TYPE, USER, 'PRODUCTS_DIM', 'Short Description');
         exception
           when cwm_exceptions.element_already_exists
              then null;
         end;         
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'PRODUCTS_DIM', 'PRODUCT', 'PROD_DESC');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'PRODUCTS_DIM', 'SUBCATEGORY', 'PROD_SUBCAT_DESC');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'PRODUCTS_DIM', 'CATEGORY', 'PROD_CAT_DESC');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
       end;
	 dbms_output.put_line('	- Short Description');
 end;

-- ------------------- Process the PROMOTIONS Dimension --------------

dbms_output.put_line('-');
dbms_output.put_line
('<<<<< PROMOTIONS DIMENSION >>>>>');
dbms_output.put_line
('Dimension - display name, description and plural name');

CWM_OLAP_DIMENSION.set_display_name(USER, 'PROMOTIONS_DIM', 'Promotions');
CWM_OLAP_DIMENSION.set_description(USER, 'PROMOTIONS_DIM', 'Promotion Values');
CWM_OLAP_DIMENSION.set_plural_name(USER, 'PROMOTIONS_DIM', 'Promotions');


dbms_output.put_line
('Level - display name and description');

cwm_olap_level.set_display_name(USER, 'PROMOTIONS_DIM', 'PROMO', 'Promotions');
cwm_olap_level.set_description(USER, 'PROMOTIONS_DIM', 'PROMO', 'Promotion level of the standard PROMOTION hierarchy');

cwm_olap_level.set_display_name(USER, 'PROMOTIONS_DIM', 'SUBCATEGORY', 'Promotions Sub-categories');
cwm_olap_level.set_description(USER, 'PROMOTIONS_DIM', 'SUBCATEGORY', 'Sub-category level of the standard PROMOTION hierarchy');
 
cwm_olap_level.set_display_name(USER, 'PROMOTIONS_DIM', 'CATEGORY', 'Promotions Categories');
cwm_olap_level.set_description(USER, 'PROMOTIONS_DIM', 'CATEGORY', 'Category level of the standard PROMOTION hierarchy');
 
cwm_olap_level.set_display_name(USER, 'PROMOTIONS_DIM', 'PROMO_TOTAL', 'Promotions Total');
cwm_olap_level.set_description(USER, 'PROMOTIONS_DIM', 'PROMO_TOTAL', 'Promotions Total for the standard PROMOTION hierarchy');
  

dbms_output.put_line
('Hierarchy - display name and description');

cwm_olap_hierarchy.set_display_name(USER, 'PROMOTIONS_DIM', 'PROMO_ROLLUP', 'Standard Promotions');
cwm_olap_hierarchy.set_description(USER, 'PROMOTIONS_DIM', 'PROMO_ROLLUP', 'Standard Promotions hierarchy');


dbms_output.put_line('	- default calculation hierarchy');
cwm_olap_cube.set_default_calc_hierarchy(USER,'SALES_CUBE', 'PROMO_ROLLUP', USER, 'PROMOTIONS_DIM', 'PROMOTIONS_DIM');


dbms_output.put_line('	- default display hierarchy');
cwm_olap_dimension.set_default_display_hierarchy(USER, 'PROMOTIONS_DIM', 'PROMO_ROLLUP');


dbms_output.put_line
('Level Attributes - name, display name, description');

--	Level: PROMO
cwm_olap_level_attribute.set_name(USER, 'PROMOTIONS_DIM', 'PROMO', 'PROMO_NAME', 'PROMO_NAME');
cwm_olap_level_attribute.set_display_name(USER, 'PROMOTIONS_DIM', 'PROMO', 'PROMO_NAME', 'Promotion Name(s)');
cwm_olap_level_attribute.set_description(USER, 'PROMOTIONS_DIM', 'PROMO', 'PROMO_NAME', 'Names for the Promotions in the Standard Promotions hierarchy');

cwm_olap_level_attribute.set_name(USER, 'PROMOTIONS_DIM', 'PROMO', 'PROMO_COST', 'PROMO_COST');
cwm_olap_level_attribute.set_display_name(USER, 'PROMOTIONS_DIM', 'PROMO', 'PROMO_COST', 'Promotion costs');
cwm_olap_level_attribute.set_description(USER, 'PROMOTIONS_DIM', 'PROMO', 'PROMO_COST', 'Promotion costs');

cwm_olap_level_attribute.set_name(USER, 'PROMOTIONS_DIM', 'PROMO', 'PROMO_BEGIN_DATE', 'PROMO_BEGIN_DATE');
cwm_olap_level_attribute.set_display_name(USER, 'PROMOTIONS_DIM', 'PROMO', 'PROMO_BEGIN_DATE', 'Begin date');
cwm_olap_level_attribute.set_description(USER, 'PROMOTIONS_DIM', 'PROMO', 'PROMO_BEGIN_DATE', 'Promotion Begin Date');

cwm_olap_level_attribute.set_name(USER, 'PROMOTIONS_DIM', 'PROMO', 'PROMO_END_DATE', 'PROMO_END_DATE');
cwm_olap_level_attribute.set_display_name(USER, 'PROMOTIONS_DIM', 'PROMO', 'PROMO_END_DATE', 'End date');
cwm_olap_level_attribute.set_description(USER, 'PROMOTIONS_DIM', 'PROMO', 'PROMO_END_DATE', 'Promotion End Date');

--	Level: SUBCATEGORY
cwm_olap_level_attribute.set_name(USER, 'PROMOTIONS_DIM', 'SUBCATEGORY', 'PROMO_SUBCATEGORY', 'PROMO_SUBCATEGORY');
cwm_olap_level_attribute.set_display_name(USER, 'PROMOTIONS_DIM', 'SUBCATEGORY', 'PROMO_SUBCATEGORY', 'Sub-Category');
cwm_olap_level_attribute.set_description(USER, 'PROMOTIONS_DIM', 'SUBCATEGORY', 'PROMO_SUBCATEGORY', 'Promotion Sub-Category');

--	Level: CATEGORY
cwm_olap_level_attribute.set_name(USER, 'PROMOTIONS_DIM', 'CATEGORY', 'PROMO_CATEGORY', 'PROMO_CATEGORY');
cwm_olap_level_attribute.set_display_name(USER, 'PROMOTIONS_DIM', 'CATEGORY', 'PROMO_CATEGORY', 'Category');
cwm_olap_level_attribute.set_description(USER, 'PROMOTIONS_DIM', 'CATEGORY', 'PROMO_CATEGORY', 'Promotion Category');

--	Level: PROMOTIONS TOTAL
cwm_olap_level_attribute.set_name(USER, 'PROMOTIONS_DIM', 'PROMO_TOTAL', 'PROMO_TOTAL', 'PROMO_TOTAL');
cwm_olap_level_attribute.set_display_name(USER, 'PROMOTIONS_DIM', 'PROMO_TOTAL', 'PROMO_TOTAL', 'Promotions Total');
cwm_olap_level_attribute.set_description(USER, 'PROMOTIONS_DIM', 'PROMO_TOTAL', 'PROMO_TOTAL', 'Promotions Total');


dbms_output.put_line
('Drop dimension attributes prior to re-creation');

 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'PROMOTIONS_DIM', 'Long Description');
    dbms_output.put_line('	- Long Description dropped');
 exception
    when cwm_exceptions.attribute_not_found then
      null;
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'PROMOTIONS_DIM', 'Short Description' );
    dbms_output.put_line('	- Short Description dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       dbms_output.put_line('No attribute to drop');
 end;


dbms_output.put_line
('Create dimension attributes and add their level attributes');
  
CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'PROMOTIONS_DIM', 'Long Description', 'Long Description of Promotions', 'Long Description of Promotions');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'PROMOTIONS_DIM', 'Long Description', 'PROMO', 'PROMO_NAME');
dbms_output.put_line('	- Long Description created');

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'PROMOTIONS_DIM', 'Short Description', 'ShortDescription of Promotions', 'Short Description of Promotions');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'PROMOTIONS_DIM', 'Short Description', 'PROMO', 'PROMO_NAME');
dbms_output.put_line('	- Short Description created');


dbms_output.put_line
('Classify entity descriptor use');

 begin
       SELECT descriptor_id INTO long_desc_id
       FROM all_olap_descriptors
       WHERE descriptor_value = 'Long Description'
       AND descriptor_type = 'Dimensional Attribute Descriptor';
       begin
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		DIMENSION_ATTRIBUTE_TYPE, USER, 'PROMOTIONS_DIM', 'Long Description');
         exception
           when cwm_exceptions.element_already_exists
              then null;
         end;         
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'PROMOTIONS_DIM', 'PROMO', 'PROMO_NAME');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
       end;
  	 dbms_output.put_line('	- Long Description');
 end;

 begin
       SELECT descriptor_id INTO short_desc_id
       FROM all_olap_descriptors
       WHERE descriptor_value = 'Short Description'
       AND descriptor_type = 'Dimensional Attribute Descriptor';
       begin
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		DIMENSION_ATTRIBUTE_TYPE, USER, 'PROMOTIONS_DIM', 'Short Description');
         exception
           when cwm_exceptions.element_already_exists
              then null;
         end;         
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'PROMOTIONS_DIM', 'PROMO', 'PROMO_NAME');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
       end;
	 dbms_output.put_line('	- Short Description');
 end;


-- ------------------- Process the CHANNELS Dimension --------------

dbms_output.put_line('-');
dbms_output.put_line
('<<<<< CHANNELS DIMENSION >>>>>');
dbms_output.put_line
('Dimension - display name, description and plural name');

CWM_OLAP_DIMENSION.set_display_name(USER, 'CHANNELS_DIM', 'Channel');
CWM_OLAP_DIMENSION.set_description(USER, 'CHANNELS_DIM', 'Channel Values');
CWM_OLAP_DIMENSION.set_plural_name(USER, 'CHANNELS_DIM', 'Channels');


dbms_output.put_line
('Level - display name and description');

cwm_olap_level.set_display_name(USER, 'CHANNELS_DIM', 'CHANNEL', 'Channel');
cwm_olap_level.set_description(USER, 'CHANNELS_DIM', 'CHANNEL', 'Channel level of the standard hierarchy');

cwm_olap_level.set_display_name(USER, 'CHANNELS_DIM', 'CHANNEL_CLASS', 'Channel Class');
cwm_olap_level.set_description(USER, 'CHANNELS_DIM', 'CHANNEL_CLASS', 'Channel Class level of the standard hierarchy');

cwm_olap_level.set_display_name(USER, 'CHANNELS_DIM', 'CHANNEL_TOTAL', 'Channel Total');
cwm_olap_level.set_description(USER, 'CHANNELS_DIM', 'CHANNEL_TOTAL', 'Channel Total for the standard hierarchy');
  

dbms_output.put_line
('Hierarchy - display name and description');

cwm_olap_hierarchy.set_display_name(USER, 'CHANNELS_DIM', 'CHANNEL_ROLLUP', 'Standard Channels');
cwm_olap_hierarchy.set_description(USER, 'CHANNELS_DIM', 'CHANNEL_ROLLUP', 'Standard Channels hierarchy');


dbms_output.put_line('	- default calculation hierarchy');
cwm_olap_cube.set_default_calc_hierarchy(USER,'SALES_CUBE', 'CHANNEL_ROLLUP', USER, 'CHANNELS_DIM', 'CHANNELS_DIM');


dbms_output.put_line('	- default display hierarchy');
cwm_olap_dimension.set_default_display_hierarchy(USER, 'CHANNELS_DIM', 'CHANNEL_ROLLUP');


dbms_output.put_line
('Level Attributes - name, display name, description');

--	Level: CHANNEL
cwm_olap_level_attribute.set_name(USER, 'CHANNELS_DIM', 'CHANNEL', 'CHANNEL_DESC', 'CHANNEL_DESC');
cwm_olap_level_attribute.set_display_name(USER, 'CHANNELS_DIM', 'CHANNEL', 'CHANNEL_DESC', 'Channel');
cwm_olap_level_attribute.set_description(USER, 'CHANNELS_DIM', 'CHANNEL', 'CHANNEL_DESC', 'Channel Description');

--	Level: CHANNEL CLASS
cwm_olap_level_attribute.set_name(USER, 'CHANNELS_DIM', 'CHANNEL_CLASS', 'CHANNEL_CLASS', 'CHANNEL_CLASS');
cwm_olap_level_attribute.set_display_name(USER, 'CHANNELS_DIM', 'CHANNEL_CLASS', 'CHANNEL_CLASS', 'Channel Class');
cwm_olap_level_attribute.set_description(USER, 'CHANNELS_DIM', 'CHANNEL_CLASS', 'CHANNEL_CLASS', 'Channel Class Identifier');

--	Level: CHANNEL TOTAL
cwm_olap_level_attribute.set_name(USER, 'CHANNELS_DIM', 'CHANNEL_TOTAL', 'CHANNEL_TOTAL', 'CHANNEL_TOTAL');
cwm_olap_level_attribute.set_display_name(USER, 'CHANNELS_DIM', 'CHANNEL_TOTAL', 'CHANNEL_TOTAL', 'Channel Total');
cwm_olap_level_attribute.set_description(USER, 'CHANNELS_DIM', 'CHANNEL_TOTAL', 'CHANNEL_TOTAL', 'Channel Total');


dbms_output.put_line
('Drop dimension attributes prior to re-creation');

 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'CHANNELS_DIM', 'Long Description');
    dbms_output.put_line('	- Long Description dropped');
 exception
    when cwm_exceptions.attribute_not_found then
      null;
 end;
 begin
    cwm_olap_dim_attribute.drop_dimension_attribute(USER, 'CHANNELS_DIM', 'Short Description' );
    dbms_output.put_line('	- Short Description dropped');
 exception
     when cwm_exceptions.attribute_not_found then
       dbms_output.put_line('No attribute to drop');
 end;


dbms_output.put_line
('Create dimension attributes and add their level attributes');
  
CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'CHANNELS_DIM', 'Long Description', 'Long Description of Channels', 'Long Description of Channels');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CHANNELS_DIM', 'Long Description', 'CHANNEL', 'CHANNEL_DESC');
dbms_output.put_line('	- Long Description created');

CWM_OLAP_DIM_ATTRIBUTE.create_dimension_attribute(USER, 'CHANNELS_DIM', 'Short Description', 'Short Description of Channels', 'Short Description of Channels');
  CWM_OLAP_DIM_ATTRIBUTE.add_level_attribute(USER, 'CHANNELS_DIM', 'Short Description', 'CHANNEL', 'CHANNEL_DESC');
dbms_output.put_line('	- Short Description created');


dbms_output.put_line
('Classify entity descriptor use');

 begin
       SELECT descriptor_id INTO long_desc_id
       FROM all_olap_descriptors
       WHERE descriptor_value = 'Long Description'
       AND descriptor_type = 'Dimensional Attribute Descriptor';
       begin
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		DIMENSION_ATTRIBUTE_TYPE, USER, 'CHANNELS_DIM', 'Long Description');
         exception
           when cwm_exceptions.element_already_exists
              then null;
         end;         
         begin
           cwm_classify.add_entity_descriptor_use(long_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'CHANNELS_DIM', 'CHANNEL', 'CHANNEL_DESC');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
       end;
  	 dbms_output.put_line('	- Long Description');
 end;

 begin
       SELECT descriptor_id INTO short_desc_id
       FROM all_olap_descriptors
       WHERE descriptor_value = 'Short Description'
       AND descriptor_type = 'Dimensional Attribute Descriptor';
       begin
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		DIMENSION_ATTRIBUTE_TYPE, USER, 'CHANNELS_DIM', 'Short Description');
         exception
           when cwm_exceptions.element_already_exists
              then null;
         end;         
         begin
           cwm_classify.add_entity_descriptor_use(short_desc_id, 
		LEVEL_ATTRIBUTE_TYPE, USER, 'CHANNELS_DIM', 'CHANNEL', 'CHANNEL_DESC');
         exception
           when cwm_exceptions.element_already_exists 
              then null;
         end;
       end;
	 dbms_output.put_line('	- Short Description');
 end;


-- ------------------- Final Processing -------------------------------

dbms_output.put_line('-');
dbms_output.put_line
('<<<<< FINAL PROCESSING >>>>>');
commit;
dbms_output.put_line
('	- Changes have been committed');
exception
  when others then
    cwm_utility.dump_error;
    errtxt := cwm_utility.get_last_error_description;
    dbms_output.put_line('ERROR: ' || errtxt);
    rollback;
    raise;
end;
.
/

COMMIT;

-- ------------------- Statistics ---------------------------

ALTER MATERIALIZED VIEW fweek_pscat_sales_mv COMPILE;
@?/demo/schema/sales_history/sh_analz.sql



