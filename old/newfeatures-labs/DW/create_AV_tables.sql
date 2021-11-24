set echo on
DROP USER av CASCADE;
CREATE USER av IDENTIFIED BY Welcome_1 ;
GRANT dba TO av;

CREATE TABLE AV.GEOGRAPHY_DIM (region_id varchar2(120), region_name varchar2(120),
                               country_id varchar2(2), country_name varchar2(120),
                               state_province_id varchar2(120), state_province_name varchar2(400));

CREATE TABLE AV.PRODUCT_DIM (department_id number(22), department_name varchar2(100),
                               category_id number(22), category_name varchar2(100));	

CREATE TABLE AV.TIME_DIM (YEAR_ID varchar2(30), YEAR_NAME varchar2(40), YEAR_END_DATE DATE, 
                          QUARTER_ID varchar2(30), QUARTER_NAME varchar2(40), QUARTER_END_DATE DATE,
						  QUARTER_OF_YEAR number(22), MONTH_ID varchar2(30), MONTH_NAME varchar2(40),
						  MONTH_END_DATE DATE, MONTH_OF_YEAR number(22), MONTH_LONG_NAME varchar2(30),
						  SEASON varchar2(10), SEASON_ORDER number(22), MONTH_OF_QUARTER number(22));
						
CREATE TABLE AV.SALES_FACT (MONTH_ID varchar2(10), CATEGORY_ID number(22), 
                            STATE_PROVINCE_ID varchar2(120), UNITS number(22), SALES number(22));
exit
