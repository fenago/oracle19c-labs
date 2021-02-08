Rem
Rem $Header: dsh_v2.sql 29-aug-2002.11:51:11 hyeh Exp $
Rem
Rem sh_drop.sql
Rem
Rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      sh_drop.sql - Drop database objects
Rem
Rem    DESCRIPTION
Rem      SH is the Sales History schema of the Oracle 9i Sample
Rem	   Schemas
Rem
Rem    NOTES
Rem      
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem     hyeh       08/29/02 - hyeh_mv_comschema_to_rdbms
Rem     ahunold    05/29/02 - directory objects owned by sys
Rem     ahunold    04/09/02 - dropping directory
Rem     ahunold    02/01/02 - bug2206757
Rem     hbaer      01/29/01 - Created
Rem

REM drop all tables of schema

DROP TABLE sales      CASCADE CONSTRAINTS ;
DROP TABLE costs      CASCADE CONSTRAINTS ;
DROP TABLE times      CASCADE CONSTRAINTS ;
DROP TABLE channels   CASCADE CONSTRAINTS ;
DROP TABLE promotions CASCADE CONSTRAINTS ;
DROP TABLE customers  CASCADE CONSTRAINTS ;
DROP TABLE countries  CASCADE CONSTRAINTS ;
DROP TABLE products   CASCADE CONSTRAINTS ;

DROP TABLE mv_capabilities_table  CASCADE CONSTRAINTS ;
DROP TABLE plan_table             CASCADE CONSTRAINTS ;
DROP TABLE rewrite_table          CASCADE CONSTRAINTS ;
DROP TABLE sales_transactions_ext CASCADE CONSTRAINTS ;

REM automatically generated by dbms_olap package

DROP TABLE mview$_exceptions;

REM drop all dimensions

DROP DIMENSION customers_dim;
DROP DIMENSION times_dim;
DROP DIMENSION products_dim;
DROP DIMENSION promotions_dim;
DROP DIMENSION channels_dim;

REM drop materialized views

DROP MATERIALIZED VIEW cal_month_sales_mv;
DROP MATERIALIZED VIEW fweek_pscat_sales_mv;

COMMIT;

