#!/bin/ksh

sqlplus sys/oracle as sysdba <<FIN!

-- as sysdba flush the shared pool
ALTER system flush buffer_cache;
ALTER system flush shared_pool;


-- connect as dwh_test
CONNECT apps/apps;
set echo on;
spool /tmp/dwh_test.log;
-- Generated on  Thu Sep 18 20:38:59 2003
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY:MON-DD:HH24:MI:SS';
SET LINES 80;
set wrap on
SET PAGES 0;
rem SET TRIMS ON;
SET HEADING OFF;
SELECT '@Start', sysdate from dual;
rem SET TERMOUT ON;
rem set ECHO OFF;
SET ECHO ON;
rem SET FEEDBACK OFF;
rem alter session set tracefile_identifier='noprof';
rem alter session set sql_trace=true;
alter system set cursor_sharing=exact;
set autotrace traceonly statistics;

PROMPT @Statement 1  
execute dbms_application_info.set_module('DWH_TEST','1');

SET TIMING ON;
SELECT DISTINCT
    'B' || t1.pg_featurevalue_15_id pg_featurevalue_15_id
FROM
    lu_pg_featurevalue_15 t1,
    lu_elementrange_rel t2
WHERE
/* Attribute Joins */
      ((t1.pg_featurevalue_15_num BETWEEN t2.lbound AND t2.ubound)
      )
/* Attribute Filters */
  AND ((t1.pg_featurevalue_15_id = 1485)
  AND  (t2.elementrange_id = 3091)
      )
/
PROMPT @1 Results in 15 Ticks



PROMPT @Statement 2  
rem #execute dbms_application_info.set_module('DWH_TEST','2');

SELECT DISTINCT
    'B' || t1.pg_featurevalue_15_id pg_featurevalue_15_id
FROM
    lu_pg_featurevalue_15 t1,
    lu_elementrange_rel t2
WHERE
/* Attribute Joins */
      ((t1.pg_featurevalue_15_num BETWEEN t2.lbound AND t2.ubound)
      )
/* Attribute Filters */
  AND ((t1.pg_featurevalue_15_id = 12425)
  AND  (t2.elementrange_id = 3091)
      )
/
PROMPT @1 Results in 0 Ticks



PROMPT @Statement 3  
rem #execute dbms_application_info.set_module('DWH_TEST','3');

SELECT DISTINCT
    'B' || t1.pg_featurevalue_15_id pg_featurevalue_15_id
FROM
    lu_pg_featurevalue_15 t1,
    lu_elementrange_rel t2
WHERE
/* Attribute Joins */
      ((t1.pg_featurevalue_15_num BETWEEN t2.lbound AND t2.ubound)
      )
/* Attribute Filters */
  AND ((t1.pg_featurevalue_15_id = 49620)
  AND  (t2.elementrange_id = 3091)
      )
/
PROMPT @1 Results in 16 Ticks



PROMPT @Statement 4  
rem #execute dbms_application_info.set_module('DWH_TEST','4');

SELECT DISTINCT
    'B' || t1.pg_featurevalue_47_id pg_featurevalue_47_id
FROM
    lu_pg_featurevalue_47 t1,
    lu_elementgroup_rel t2
WHERE
/* Attribute Joins */
      ((t1.pg_featurevalue_47_id = t2.value_id)
      )
/* Attribute Filters */
  AND ((t1.pg_featurevalue_47_id = 5454)
  AND  (t2.elementgroup_id = 6624)
      )
/
PROMPT @1 Results in 0 Ticks



PROMPT @Statement 5  
rem #execute dbms_application_info.set_module('DWH_TEST','5');

SELECT DISTINCT
    'B' || t1.pg_featurevalue_47_id pg_featurevalue_47_id
FROM
    lu_pg_featurevalue_47 t1,
    lu_elementgroup_rel t2
WHERE
/* Attribute Joins */
      ((t1.pg_featurevalue_47_id = t2.value_id)
      )
/* Attribute Filters */
  AND ((t1.pg_featurevalue_47_id = 16003)
  AND  (t2.elementgroup_id = 6624)
      )
/
PROMPT @1 Results in 15 Ticks



PROMPT @Statement 6  
rem #execute dbms_application_info.set_module('DWH_TEST','6');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_13_id pg_featurevalue_13_id,
    'B' || t2.pg_featurevalue_02_id pg_featurevalue_02_id,
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t5.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t6.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    lu_pg_featurevalue_15 t3,
    lu_elementrange_rel t4,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t6,
    lu_elementrange_rel t5
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.pd_price_units_eur BETWEEN t5.lbound AND t5.ubound)
  AND  (t1.period_id = t6.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_08_id IN (716,717))
  AND  (t2.pg_featurevalue_02_id IN (4165,4166))
  AND  (t2.pg_featurevalue_13_id = 5424)
  AND  (t4.elementrange_id IN (3091,3092))
  AND  (t5.elementrange_id IN (8693,8694,8695,8696,8697,8698,8699))
  AND  (t6.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_13_id,
    t2.pg_featurevalue_02_id,
    t4.elementrange_id,
    t2.pg_featurevalue_08_id,
    t2.pg_featurevalue_01_id,
    t5.elementrange_id,
    t2.productgroup_id,
    t6.elementgroup_id
/
PROMPT @69 Results in 12078 Ticks



PROMPT @Statement 7  
rem #execute dbms_application_info.set_module('DWH_TEST','7');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_13_id pg_featurevalue_13_id,
    'B' || t2.pg_featurevalue_02_id pg_featurevalue_02_id,
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t5.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t6.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    lu_pg_featurevalue_15 t3,
    lu_elementrange_rel t4,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t6,
    lu_elementrange_rel t5
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.pd_price_units_eur BETWEEN t5.lbound AND t5.ubound)
  AND  (t1.period_id = t6.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_08_id IN (716,717))
  AND  (t2.pg_featurevalue_02_id IN (4165,4166))
  AND  (t2.pg_featurevalue_13_id = 5424)
  AND  (t4.elementrange_id IN (3091,3092))
  AND  (t5.elementrange_id IN (8686,8687,8688,8689,8690,8691,8692,8693))
  AND  (t6.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_13_id,
    t2.pg_featurevalue_02_id,
    t4.elementrange_id,
    t2.pg_featurevalue_08_id,
    t2.pg_featurevalue_01_id,
    t5.elementrange_id,
    t2.productgroup_id,
    t6.elementgroup_id
/
PROMPT @160 Results in 14344 Ticks



PROMPT @Statement 8  
rem #execute dbms_application_info.set_module('DWH_TEST','8');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_05_id pg_featurevalue_05_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'r' || t3.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t4.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t4,
    lu_elementrange_rel t3
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t1.pd_price_units_eur BETWEEN t3.lbound AND t3.ubound)
  AND  (t1.period_id = t4.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  NOT ((t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95)))
  AND  (t2.pg_featurevalue_08_id = 717)
  AND  (t2.pg_featurevalue_05_id IN (5446,5447))
  AND  (t3.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t4.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_05_id,
    t2.pg_featurevalue_08_id,
    t3.elementrange_id,
    t2.productgroup_id,
    t4.elementgroup_id
/
PROMPT @46 Results in 24281 Ticks



PROMPT @Statement 9  
rem #execute dbms_application_info.set_module('DWH_TEST','9');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_13_id pg_featurevalue_13_id,
    'B' || t2.pg_featurevalue_02_id pg_featurevalue_02_id,
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t5.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t6.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    lu_pg_featurevalue_15 t3,
    lu_elementrange_rel t4,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t6,
    lu_elementrange_rel t5
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.pd_price_units_eur BETWEEN t5.lbound AND t5.ubound)
  AND  (t1.period_id = t6.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_08_id IN (716,717))
  AND  (t2.pg_featurevalue_02_id IN (4165,4166))
  AND  (t2.pg_featurevalue_13_id = 5424)
  AND  (t4.elementrange_id IN (3091,3092))
  AND  (t5.elementrange_id IN (8680,8681,8682,8683,8684,8685,8686))
  AND  (t6.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_13_id,
    t2.pg_featurevalue_02_id,
    t4.elementrange_id,
    t2.pg_featurevalue_08_id,
    t2.pg_featurevalue_01_id,
    t5.elementrange_id,
    t2.productgroup_id,
    t6.elementgroup_id
/
PROMPT @179 Results in 12500 Ticks



PROMPT @Statement 10  
rem #execute dbms_application_info.set_module('DWH_TEST','10');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'G' || t3.elementgroup_id pg_featurevalue_18_id,
    'r' || t4.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t5.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    lu_elementgroup_rel t3,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t5,
    lu_elementrange_rel t4
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_18_id = t3.value_id)
  AND  (t1.pd_price_units_eur BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.period_id = t5.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  NOT ((t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95)))
  AND  (t3.elementgroup_id IN (8902,8903))
  AND  (t4.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t5.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t3.elementgroup_id,
    t4.elementrange_id,
    t2.productgroup_id,
    t5.elementgroup_id
/
PROMPT @40 Results in 1390 Ticks



PROMPT @Statement 11  
rem #execute dbms_application_info.set_module('DWH_TEST','11');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_13_id pg_featurevalue_13_id,
    'B' || t2.pg_featurevalue_02_id pg_featurevalue_02_id,
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t5.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t6.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    lu_pg_featurevalue_15 t3,
    lu_elementrange_rel t4,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t6,
    lu_elementrange_rel t5
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.pd_price_units_eur BETWEEN t5.lbound AND t5.ubound)
  AND  (t1.period_id = t6.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_08_id IN (716,717))
  AND  (t2.pg_featurevalue_02_id IN (4165,4166))
  AND  (t2.pg_featurevalue_13_id = 5424)
  AND  (t4.elementrange_id IN (3091,3092))
  AND  (t5.elementrange_id IN (8671,8672,8673,8674,8675,8676,8679))
  AND  (t6.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_13_id,
    t2.pg_featurevalue_02_id,
    t4.elementrange_id,
    t2.pg_featurevalue_08_id,
    t2.pg_featurevalue_01_id,
    t5.elementrange_id,
    t2.productgroup_id,
    t6.elementgroup_id
/
PROMPT @220 Results in 12297 Ticks



PROMPT @Statement 12  
rem #execute dbms_application_info.set_module('DWH_TEST','12');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t5.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t6.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    lu_pg_featurevalue_15 t3,
    lu_elementrange_rel t4,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t6,
    lu_elementrange_rel t5
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.pd_price_units_eur BETWEEN t5.lbound AND t5.ubound)
  AND  (t1.period_id = t6.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t4.elementrange_id IN (3091,3092,3093,3107))
  AND  (t5.elementrange_id IN (8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t6.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t4.elementrange_id,
    t2.pg_featurevalue_01_id,
    t5.elementrange_id,
    t2.productgroup_id,
    t6.elementgroup_id
/
PROMPT @281 Results in 39812 Ticks



PROMPT @Statement 13  
rem #execute dbms_application_info.set_module('DWH_TEST','13');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t5.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t6.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    lu_pg_featurevalue_15 t3,
    lu_elementrange_rel t4,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t6,
    lu_elementrange_rel t5
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.pd_price_units_eur BETWEEN t5.lbound AND t5.ubound)
  AND  (t1.period_id = t6.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t4.elementrange_id IN (3091,3092,3093,3107))
  AND  (t5.elementrange_id IN (8680,8681,8682,8683,8684,8685,8686,8687,8688,8689))
  AND  (t6.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t4.elementrange_id,
    t2.pg_featurevalue_01_id,
    t5.elementrange_id,
    t2.productgroup_id,
    t6.elementgroup_id
/
PROMPT @319 Results in 40938 Ticks



PROMPT @Statement 14  
rem #execute dbms_application_info.set_module('DWH_TEST','14');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_05_id pg_featurevalue_05_id,
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'G' || t5.elementgroup_id pg_featurevalue_01_id,
    'r' || t6.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t7.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    lu_pg_featurevalue_15 t3,
    lu_elementgroup_rel t5,
    lu_elementrange_rel t4,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t7,
    lu_elementrange_rel t6
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t2.pg_featurevalue_01_id = t5.value_id)
  AND  (t1.pd_price_units_eur BETWEEN t6.lbound AND t6.ubound)
  AND  (t1.period_id = t7.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_05_id IN (5446,5447))
  AND  (t4.elementrange_id = 3091)
  AND  (t5.elementgroup_id IN (1959,1960,1961,1962,8574))
  AND  (t6.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t7.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_05_id,
    t4.elementrange_id,
    t5.elementgroup_id,
    t6.elementrange_id,
    t2.productgroup_id,
    t7.elementgroup_id
/
PROMPT @135 Results in 49031 Ticks



PROMPT @Statement 15  
rem #execute dbms_application_info.set_module('DWH_TEST','15');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t5.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t6.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    lu_pg_featurevalue_15 t3,
    lu_elementrange_rel t4,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t6,
    lu_elementrange_rel t5
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.pd_price_units_eur BETWEEN t5.lbound AND t5.ubound)
  AND  (t1.period_id = t6.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t4.elementrange_id IN (3091,3092,3093,3107))
  AND  (t5.elementrange_id IN (8656,8657))
  AND  (t6.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t4.elementrange_id,
    t2.pg_featurevalue_01_id,
    t5.elementrange_id,
    t2.productgroup_id,
    t6.elementgroup_id
/
PROMPT @5 Results in 9625 Ticks



PROMPT @Statement 16  
rem #execute dbms_application_info.set_module('DWH_TEST','16');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_13_id pg_featurevalue_13_id,
    'B' || t2.pg_featurevalue_02_id pg_featurevalue_02_id,
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t5.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t6.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    lu_pg_featurevalue_15 t3,
    lu_elementrange_rel t4,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t6,
    lu_elementrange_rel t5
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.pd_price_units_eur BETWEEN t5.lbound AND t5.ubound)
  AND  (t1.period_id = t6.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_08_id IN (716,717))
  AND  (t2.pg_featurevalue_02_id IN (4165,4166))
  AND  (t2.pg_featurevalue_13_id = 5424)
  AND  (t4.elementrange_id IN (3091,3092))
  AND  (t5.elementrange_id IN (8664,8665,8666,8667,8668,8669,8670,8671))
  AND  (t6.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_13_id,
    t2.pg_featurevalue_02_id,
    t4.elementrange_id,
    t2.pg_featurevalue_08_id,
    t2.pg_featurevalue_01_id,
    t5.elementrange_id,
    t2.productgroup_id,
    t6.elementgroup_id
/
PROMPT @140 Results in 14219 Ticks



PROMPT @Statement 17  
rem #execute dbms_application_info.set_module('DWH_TEST','17');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t5.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t6.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    lu_pg_featurevalue_15 t3,
    lu_elementrange_rel t4,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t6,
    lu_elementrange_rel t5
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.pd_price_units_eur BETWEEN t5.lbound AND t5.ubound)
  AND  (t1.period_id = t6.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t4.elementrange_id IN (3091,3092,3093,3107))
  AND  (t5.elementrange_id IN (8668,8669,8670,8671,8672,8673,8674,8675,8676,8679))
  AND  (t6.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t4.elementrange_id,
    t2.pg_featurevalue_01_id,
    t5.elementrange_id,
    t2.productgroup_id,
    t6.elementgroup_id
/
PROMPT @353 Results in 41250 Ticks



PROMPT @Statement 18  
rem #execute dbms_application_info.set_module('DWH_TEST','18');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_13_id pg_featurevalue_13_id,
    'B' || t2.pg_featurevalue_02_id pg_featurevalue_02_id,
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t5.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t6.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    lu_pg_featurevalue_15 t3,
    lu_elementrange_rel t4,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t6,
    lu_elementrange_rel t5
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.pd_price_units_eur BETWEEN t5.lbound AND t5.ubound)
  AND  (t1.period_id = t6.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_08_id IN (716,717))
  AND  (t2.pg_featurevalue_02_id IN (4165,4166))
  AND  (t2.pg_featurevalue_13_id = 5424)
  AND  (t4.elementrange_id IN (3091,3092))
  AND  (t5.elementrange_id IN (8658,8659,8660,8661,8662,8663,8664))
  AND  (t6.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_13_id,
    t2.pg_featurevalue_02_id,
    t4.elementrange_id,
    t2.pg_featurevalue_08_id,
    t2.pg_featurevalue_01_id,
    t5.elementrange_id,
    t2.productgroup_id,
    t6.elementgroup_id
/
PROMPT @3 Results in 12578 Ticks



PROMPT @Statement 19  
rem #execute dbms_application_info.set_module('DWH_TEST','19');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t5.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t6.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    lu_pg_featurevalue_15 t3,
    lu_elementrange_rel t4,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t6,
    lu_elementrange_rel t5
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.pd_price_units_eur BETWEEN t5.lbound AND t5.ubound)
  AND  (t1.period_id = t6.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t4.elementrange_id IN (3091,3092,3093,3107))
  AND  (t5.elementrange_id IN (8658,8659,8660,8661,8662,8663,8664,8665,8666,8667))
  AND  (t6.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t4.elementrange_id,
    t2.pg_featurevalue_01_id,
    t5.elementrange_id,
    t2.productgroup_id,
    t6.elementgroup_id
/
PROMPT @118 Results in 41453 Ticks



PROMPT @Statement 20  
rem #execute dbms_application_info.set_module('DWH_TEST','20');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_13_id pg_featurevalue_13_id,
    'B' || t2.pg_featurevalue_02_id pg_featurevalue_02_id,
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t5.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t6.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    lu_pg_featurevalue_15 t3,
    lu_elementrange_rel t4,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t6,
    lu_elementrange_rel t5
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.pd_price_units_eur BETWEEN t5.lbound AND t5.ubound)
  AND  (t1.period_id = t6.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_08_id IN (716,717))
  AND  (t2.pg_featurevalue_02_id IN (4165,4166))
  AND  (t2.pg_featurevalue_13_id = 5424)
  AND  (t4.elementrange_id IN (3091,3092))
  AND  (t5.elementrange_id IN (8656,8657))
  AND  (t6.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_13_id,
    t2.pg_featurevalue_02_id,
    t4.elementrange_id,
    t2.pg_featurevalue_08_id,
    t2.pg_featurevalue_01_id,
    t5.elementrange_id,
    t2.productgroup_id,
    t6.elementgroup_id
/
PROMPT @0 Results in 4594 Ticks



PROMPT @Statement 21  
rem #execute dbms_application_info.set_module('DWH_TEST','21');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_02_id pg_featurevalue_02_id,
    'B' || t2.pg_featurevalue_15_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'r' || t3.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t4.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t4,
    lu_elementrange_rel t3
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t1.pd_price_units_eur BETWEEN t3.lbound AND t3.ubound)
  AND  (t1.period_id = t4.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_08_id IN (716,717))
  AND  (t2.pg_featurevalue_15_id IN (12425,1485))
  AND  (t2.pg_featurevalue_02_id IN (4165,4166))
  AND  (t3.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t4.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_02_id,
    t2.pg_featurevalue_15_id,
    t2.pg_featurevalue_08_id,
    t3.elementrange_id,
    t2.productgroup_id,
    t4.elementgroup_id
/
PROMPT @171 Results in 68984 Ticks



PROMPT @Statement 22  
rem #execute dbms_application_info.set_module('DWH_TEST','22');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_02_id pg_featurevalue_02_id,
    'B' || t2.pg_featurevalue_15_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'r' || t3.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t4.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t4,
    lu_elementrange_rel t3
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t1.pd_price_units_eur BETWEEN t3.lbound AND t3.ubound)
  AND  (t1.period_id = t4.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_08_id IN (716,717))
  AND  (t2.pg_featurevalue_15_id IN (12425,1485))
  AND  (t2.pg_featurevalue_02_id IN (4165,4166))
  AND  NOT ((/* ElementGroup Subselect */
             (
              t2.pg_featurevalue_01_id IN
              (SELECT g1.value_id
               FROM   lu_elementgroup_rel g1
               WHERE
               /* ElementGroup Filters */
                     (g1.elementgroup_id IN (1959,1960,1961,1962))
              )
             )
            )
           )
  AND  (t3.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t4.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_02_id,
    t2.pg_featurevalue_15_id,
    t2.pg_featurevalue_08_id,
    t3.elementrange_id,
    t2.productgroup_id,
    t4.elementgroup_id
/
PROMPT @149 Results in 70531 Ticks



PROMPT @Statement 23  
rem #execute dbms_application_info.set_module('DWH_TEST','23');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_13_id pg_featurevalue_13_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t3.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t4.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t4,
    lu_elementrange_rel t3
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t1.pd_price_units_eur BETWEEN t3.lbound AND t3.ubound)
  AND  (t1.period_id = t4.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_08_id IN (716,717))
  AND  (t2.pg_featurevalue_13_id = 5424)
  AND  (t3.elementrange_id IN (8656,8657))
  AND  (t4.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_13_id,
    t2.pg_featurevalue_08_id,
    t2.pg_featurevalue_01_id,
    t3.elementrange_id,
    t2.productgroup_id,
    t4.elementgroup_id
/
PROMPT @1 Results in 4531 Ticks



PROMPT @Statement 24  
rem #execute dbms_application_info.set_module('DWH_TEST','24');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_05_id pg_featurevalue_05_id,
    'B' || t2.pg_featurevalue_02_id pg_featurevalue_02_id,
    'B' || t2.pg_featurevalue_15_id pg_featurevalue_15_id,
    'r' || t3.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t4.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor) salesunits
FROM
    lu_item_293 t2,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t4,
    lu_elementrange_rel t3
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t1.pd_price_units_eur BETWEEN t3.lbound AND t3.ubound)
  AND  (t1.period_id = t4.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  NOT ((t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95)))
  AND  (t2.pg_featurevalue_15_id = 1484)
  AND  (t2.pg_featurevalue_02_id IN (4165,4166))
  AND  (t2.pg_featurevalue_05_id = 5447)
  AND  (t3.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t4.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_05_id,
    t2.pg_featurevalue_02_id,
    t2.pg_featurevalue_15_id,
    t3.elementrange_id,
    t2.productgroup_id,
    t4.elementgroup_id
/
PROMPT @16 Results in 532 Ticks



PROMPT @Statement 25  
rem #execute dbms_application_info.set_module('DWH_TEST','25');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_05_id pg_featurevalue_05_id,
    'B' || t2.pg_featurevalue_02_id pg_featurevalue_02_id,
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'r' || t5.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t6.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor) salesunits
FROM
    lu_item_293 t2,
    lu_pg_featurevalue_15 t3,
    lu_elementrange_rel t4,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t6,
    lu_elementrange_rel t5
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.pd_price_units_eur BETWEEN t5.lbound AND t5.ubound)
  AND  (t1.period_id = t6.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  NOT ((t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95)))
  AND  (t2.pg_featurevalue_08_id IN (716,717))
  AND  (t2.pg_featurevalue_02_id IN (4165,4166))
  AND  (t2.pg_featurevalue_05_id = 5447)
  AND  (t4.elementrange_id = 3091)
  AND  (t5.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t6.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_05_id,
    t2.pg_featurevalue_02_id,
    t4.elementrange_id,
    t2.pg_featurevalue_08_id,
    t5.elementrange_id,
    t2.productgroup_id,
    t6.elementgroup_id
/
PROMPT @77 Results in 8219 Ticks



PROMPT @Statement 26  
rem #execute dbms_application_info.set_module('DWH_TEST','26');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'G' || t3.elementgroup_id pg_featurevalue_13_id,
    'B' || t2.pg_featurevalue_15_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t4.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t5.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor) salesunits
FROM
    lu_item_293 t2,
    lu_elementgroup_rel t3,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t5,
    lu_elementrange_rel t4
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_13_id = t3.value_id)
  AND  (t1.pd_price_units_eur BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.period_id = t5.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_08_id = 717)
  AND  (t2.pg_featurevalue_15_id IN (12425,1485))
  AND  (t3.elementgroup_id IN (1952,1953))
  AND  (t4.elementrange_id IN (8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t5.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t3.elementgroup_id,
    t2.pg_featurevalue_15_id,
    t2.pg_featurevalue_08_id,
    t2.pg_featurevalue_01_id,
    t4.elementrange_id,
    t2.productgroup_id,
    t5.elementgroup_id
/
PROMPT @20 Results in 15000 Ticks



PROMPT @Statement 27  
rem #execute dbms_application_info.set_module('DWH_TEST','27');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_13_id pg_featurevalue_13_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t3.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t4.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t4,
    lu_elementrange_rel t3
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t1.pd_price_units_eur BETWEEN t3.lbound AND t3.ubound)
  AND  (t1.period_id = t4.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_08_id IN (716,717))
  AND  (t2.pg_featurevalue_13_id = 5424)
  AND  (t3.elementrange_id IN (8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t4.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_13_id,
    t2.pg_featurevalue_08_id,
    t2.pg_featurevalue_01_id,
    t3.elementrange_id,
    t2.productgroup_id,
    t4.elementgroup_id
/
PROMPT @313 Results in 42485 Ticks



PROMPT @Statement 28  
rem #execute dbms_application_info.set_module('DWH_TEST','28');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_05_id pg_featurevalue_05_id,
    'B' || t2.pg_featurevalue_15_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t3.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t4.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor) salesunits
FROM
    lu_item_293 t2,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t4,
    lu_elementrange_rel t3
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t1.pd_price_units_eur BETWEEN t3.lbound AND t3.ubound)
  AND  (t1.period_id = t4.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_15_id IN (1481,1484))
  AND  (t2.pg_featurevalue_05_id IN (5446,5447))
  AND  (t3.elementrange_id IN (8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t4.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_05_id,
    t2.pg_featurevalue_15_id,
    t2.pg_featurevalue_01_id,
    t3.elementrange_id,
    t2.productgroup_id,
    t4.elementgroup_id
/
PROMPT @11 Results in 12641 Ticks



PROMPT @Statement 29  
rem #execute dbms_application_info.set_module('DWH_TEST','29');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_13_id pg_featurevalue_13_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t3.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t4.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    lu_item_293 t2,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t4,
    lu_elementrange_rel t3
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t1.pd_price_units_eur BETWEEN t3.lbound AND t3.ubound)
  AND  (t1.period_id = t4.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_08_id IN (716,717))
  AND  (t2.pg_featurevalue_13_id = 5424)
  AND  (t3.elementrange_id IN (8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679))
  AND  (t4.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_13_id,
    t2.pg_featurevalue_08_id,
    t2.pg_featurevalue_01_id,
    t3.elementrange_id,
    t2.productgroup_id,
    t4.elementgroup_id
/
PROMPT @318 Results in 42875 Ticks



PROMPT @Statement 30  
rem #execute dbms_application_info.set_module('DWH_TEST','30');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_05_id pg_featurevalue_05_id,
    'B' || t2.pg_featurevalue_15_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t3.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t4.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor) salesunits
FROM
    lu_item_293 t2,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t4,
    lu_elementrange_rel t3
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t1.pd_price_units_eur BETWEEN t3.lbound AND t3.ubound)
  AND  (t1.period_id = t4.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_15_id IN (1481,1484))
  AND  (t2.pg_featurevalue_05_id IN (5446,5447))
  AND  (t3.elementrange_id IN (8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686))
  AND  (t4.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_05_id,
    t2.pg_featurevalue_15_id,
    t2.pg_featurevalue_01_id,
    t3.elementrange_id,
    t2.productgroup_id,
    t4.elementgroup_id
/
PROMPT @72 Results in 11703 Ticks



PROMPT @Statement 31  
rem #execute dbms_application_info.set_module('DWH_TEST','31');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'G' || t3.elementgroup_id pg_featurevalue_13_id,
    'B' || t2.pg_featurevalue_15_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t4.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t5.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor) salesunits
FROM
    lu_item_293 t2,
    lu_elementgroup_rel t3,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t5,
    lu_elementrange_rel t4
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_13_id = t3.value_id)
  AND  (t1.pd_price_units_eur BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.period_id = t5.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_08_id = 717)
  AND  (t2.pg_featurevalue_15_id IN (12425,1485))
  AND  (t3.elementgroup_id IN (1952,1953))
  AND  (t4.elementrange_id IN (8680,8681,8682,8683,8684,8685,8686,8687,8688,8689))
  AND  (t5.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t3.elementgroup_id,
    t2.pg_featurevalue_15_id,
    t2.pg_featurevalue_08_id,
    t2.pg_featurevalue_01_id,
    t4.elementrange_id,
    t2.productgroup_id,
    t5.elementgroup_id
/
PROMPT @103 Results in 14610 Ticks



PROMPT @Statement 32  
rem #execute dbms_application_info.set_module('DWH_TEST','32');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_05_id pg_featurevalue_05_id,
    'B' || t2.pg_featurevalue_15_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t3.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t4.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor) salesunits
FROM
    lu_item_293 t2,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t4,
    lu_elementrange_rel t3
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t1.pd_price_units_eur BETWEEN t3.lbound AND t3.ubound)
  AND  (t1.period_id = t4.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_15_id IN (1481,1484))
  AND  (t2.pg_featurevalue_05_id IN (5446,5447))
  AND  (t3.elementrange_id IN (8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671))
  AND  (t4.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_05_id,
    t2.pg_featurevalue_15_id,
    t2.pg_featurevalue_01_id,
    t3.elementrange_id,
    t2.productgroup_id,
    t4.elementgroup_id
/
PROMPT @299 Results in 11828 Ticks



PROMPT @Statement 33  
rem #execute dbms_application_info.set_module('DWH_TEST','33');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'G' || t3.elementgroup_id pg_featurevalue_13_id,
    'B' || t2.pg_featurevalue_15_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t4.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t5.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor) salesunits
FROM
    lu_item_293 t2,
    lu_elementgroup_rel t3,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t5,
    lu_elementrange_rel t4
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_13_id = t3.value_id)
  AND  (t1.pd_price_units_eur BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.period_id = t5.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_08_id = 717)
  AND  (t2.pg_featurevalue_15_id IN (12425,1485))
  AND  (t3.elementgroup_id IN (1952,1953))
  AND  (t4.elementrange_id IN (8668,8669,8670,8671,8672,8673,8674,8675,8676,8679))
  AND  (t5.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t3.elementgroup_id,
    t2.pg_featurevalue_15_id,
    t2.pg_featurevalue_08_id,
    t2.pg_featurevalue_01_id,
    t4.elementrange_id,
    t2.productgroup_id,
    t5.elementgroup_id
/
PROMPT @222 Results in 14875 Ticks



PROMPT @Statement 34  
rem #execute dbms_application_info.set_module('DWH_TEST','34');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'G' || t3.elementgroup_id pg_featurevalue_13_id,
    'B' || t2.pg_featurevalue_15_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t4.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t5.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor) salesunits
FROM
    lu_item_293 t2,
    lu_elementgroup_rel t3,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t5,
    lu_elementrange_rel t4
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_13_id = t3.value_id)
  AND  (t1.pd_price_units_eur BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.period_id = t5.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_08_id = 717)
  AND  (t2.pg_featurevalue_15_id IN (12425,1485))
  AND  (t3.elementgroup_id IN (1952,1953))
  AND  (t4.elementrange_id IN (8658,8659,8660,8661,8662,8663,8664,8665,8666,8667))
  AND  (t5.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t3.elementgroup_id,
    t2.pg_featurevalue_15_id,
    t2.pg_featurevalue_08_id,
    t2.pg_featurevalue_01_id,
    t4.elementrange_id,
    t2.productgroup_id,
    t5.elementgroup_id
/
PROMPT @127 Results in 15234 Ticks



PROMPT @Statement 35  
rem #execute dbms_application_info.set_module('DWH_TEST','35');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_05_id pg_featurevalue_05_id,
    'B' || t2.pg_featurevalue_15_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t3.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t4.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor) salesunits
FROM
    lu_item_293 t2,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t4,
    lu_elementrange_rel t3
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t1.pd_price_units_eur BETWEEN t3.lbound AND t3.ubound)
  AND  (t1.period_id = t4.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_15_id IN (1481,1484))
  AND  (t2.pg_featurevalue_05_id IN (5446,5447))
  AND  (t3.elementrange_id IN (8656,8657))
  AND  (t4.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_05_id,
    t2.pg_featurevalue_15_id,
    t2.pg_featurevalue_01_id,
    t3.elementrange_id,
    t2.productgroup_id,
    t4.elementgroup_id
/
PROMPT @11 Results in 2281 Ticks



PROMPT @Statement 36  
rem #execute dbms_application_info.set_module('DWH_TEST','36');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'G' || t5.elementgroup_id pg_featurevalue_31_id,
    'B' || t2.pg_featurevalue_09_id pg_featurevalue_09_id,
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'r' || t6.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t7.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor) salesunits
FROM
    lu_item_293 t2,
    lu_pg_featurevalue_15 t3,
    lu_elementgroup_rel t5,
    lu_elementrange_rel t4,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t7,
    lu_elementrange_rel t6
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t2.pg_featurevalue_31_id = t5.value_id)
  AND  (t1.pd_price_units_eur BETWEEN t6.lbound AND t6.ubound)
  AND  (t1.period_id = t7.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_09_id IN (5484,5485))
  AND  (t5.elementgroup_id = 8597)
  AND  (t4.elementrange_id = 3106)
  AND  (t6.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t7.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t5.elementgroup_id,
    t2.pg_featurevalue_09_id,
    t4.elementrange_id,
    t6.elementrange_id,
    t2.productgroup_id,
    t7.elementgroup_id
/
PROMPT @13 Results in 562 Ticks



PROMPT @Statement 37  
rem #execute dbms_application_info.set_module('DWH_TEST','37');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'G' || t3.elementgroup_id pg_featurevalue_13_id,
    'B' || t2.pg_featurevalue_15_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'B' || t2.pg_featurevalue_01_id pg_featurevalue_01_id,
    'r' || t4.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t5.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor) salesunits
FROM
    lu_item_293 t2,
    lu_elementgroup_rel t3,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t5,
    lu_elementrange_rel t4
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_13_id = t3.value_id)
  AND  (t1.pd_price_units_eur BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.period_id = t5.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95))
  AND  (t2.pg_featurevalue_08_id = 717)
  AND  (t2.pg_featurevalue_15_id IN (12425,1485))
  AND  (t3.elementgroup_id IN (1952,1953))
  AND  (t4.elementrange_id IN (8656,8657))
  AND  (t5.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t3.elementgroup_id,
    t2.pg_featurevalue_15_id,
    t2.pg_featurevalue_08_id,
    t2.pg_featurevalue_01_id,
    t4.elementrange_id,
    t2.productgroup_id,
    t5.elementgroup_id
/
PROMPT @1 Results in 3469 Ticks



PROMPT @Statement 38  
rem #execute dbms_application_info.set_module('DWH_TEST','38');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_13_id pg_featurevalue_13_id,
    'G' || t3.elementgroup_id pg_featurevalue_01_id,
    'r' || t4.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t5.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor) salesunits
FROM
    lu_item_293 t2,
    lu_elementgroup_rel t3,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t5,
    lu_elementrange_rel t4
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_01_id = t3.value_id)
  AND  (t1.pd_price_units_eur BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.period_id = t5.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_13_id = 5424)
  AND  (t3.elementgroup_id IN (1959,1960,1961,1962,8574))
  AND  (t4.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t5.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_13_id,
    t3.elementgroup_id,
    t4.elementrange_id,
    t2.productgroup_id,
    t5.elementgroup_id
/
PROMPT @172 Results in 76250 Ticks



PROMPT @Statement 39  
rem #execute dbms_application_info.set_module('DWH_TEST','39');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'G' || t3.elementgroup_id pg_featurevalue_47_id,
    'r' || t4.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t5.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor) salesunits
FROM
    lu_item_293 t2,
    lu_elementgroup_rel t3,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t5,
    lu_elementrange_rel t4
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_47_id = t3.value_id)
  AND  (t1.pd_price_units_eur BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.period_id = t5.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  NOT ((t2.pg_featurevalue_15_id IN (1474,1481,1483,1484)
             OR
             /* ElementGroup Subselect */
             (
              t2.pg_featurevalue_15_id IN
              (SELECT g1.value_id
               FROM   lu_elementgroup_rel g1
               WHERE
               /* ElementGroup Filters */
                     (g1.elementgroup_id = 8507)
              )
             )
             OR
             /* ElementRange Subselect */
             t2.pg_featurevalue_15_id IN
             (SELECT r1.pg_featurevalue_15_id
              FROM   lu_pg_featurevalue_15 r1,
                     lu_elementrange_rel r2
              WHERE
              /* Feature Filter */
                    (r1.pg_feature_15_id = 977)
              /* Attribute Join */
                AND (r1.pg_featurevalue_15_num BETWEEN r2.lbound AND r2.ubound)
              /* ElementRange Filter */
                AND (r2.elementrange_id = 5783)
             )
            )
           )
  AND  (t3.elementgroup_id = 6624)
  AND  (t4.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t5.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t3.elementgroup_id,
    t4.elementrange_id,
    t2.productgroup_id,
    t5.elementgroup_id
/
PROMPT @8 Results in 2781 Ticks



PROMPT @Statement 40  
rem #execute dbms_application_info.set_module('DWH_TEST','40');

SELECT /* ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_13_id pg_featurevalue_13_id,
    'r' || t3.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t4.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor) salesunits
FROM
    lu_item_293 t2,
    fact_pd_out_itm_293 t1,
    lu_elementgroup_rel t4,
    lu_elementrange_rel t3
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing Begin */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t1.pd_price_units_eur BETWEEN t3.lbound AND t3.ubound)
  AND  (t1.period_id = t4.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_13_id = 5424)
  AND  NOT ((/* ElementGroup Subselect */
             (
              t2.pg_featurevalue_01_id IN
              (SELECT g1.value_id
               FROM   lu_elementgroup_rel g1
               WHERE
               /* ElementGroup Filters */
                     (g1.elementgroup_id IN (1959,1960,1961,1962))
              )
             )
            )
           )
  AND  (t3.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t4.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_13_id,
    t3.elementrange_id,
    t2.productgroup_id,
    t4.elementgroup_id
/
PROMPT @40 Results in 92391 Ticks



PROMPT @Statement 41  
rem #execute dbms_application_info.set_module('DWH_TEST','41');

SELECT
    'B' || tt1.ch_featurevalue_09_id ch_featurevalue_09_id,
    'G' || tt1.ch_featurevalue_02_elgr_id ch_featurevalue_02_id,
    'r' || tt1.pg_featurevalue_15_elrg_id pg_featurevalue_15_id,
    'G' || tt1.pg_featurevalue_01_elgr_id pg_featurevalue_01_id,
    'G' || tt1.countrychannel_elgr_id countrychannel_id,
    'B' || tt1.productgroup_id productgroup_id,
    'G' || tt1.period_elgr_id period_id,
    SUM(tt1.dnfactorsales*tt1.turnoverfactor) salesvalueselloutlets,
    SUM(tt1.dnfactortotal*tt1.turnoverfactor) salesvaluetotaloutlets,
    SUM(tt1.distributionfactor*tt1.dissalesflag) selloutletsavg,
    SUM(tt1.distributionfactor*tt1.distotalflag) carroutletsavg
FROM 
    --------------------------
    -- TempTable 1
    --------------------------
    ( 
    SELECT /* ORDERED INDEX(t1) USE_HASH(t1) INDEX(t2) */
        t2.ch_featurevalue_09_id ch_featurevalue_09_id,
        t3.elementgroup_id ch_featurevalue_02_elgr_id,
        t7.elementrange_id pg_featurevalue_15_elrg_id,
        t8.elementgroup_id pg_featurevalue_01_elgr_id,
        t4.elementgroup_id countrychannel_elgr_id,
        t5.productgroup_id productgroup_id,
        t9.elementgroup_id period_elgr_id,
        t2.outlet_id outlet_id,
        t1.project_id project_id,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)))) dnfactorsales,
        MAX(t1.pd_turnover_factor*t1.pd_projection_factor) turnoverfactor,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)) + ABS(DECODE(t1.pd_purchase_units,NULL,0,t1.pd_purchase_units)) + ABS(DECODE(t1.pd_stock_new_units,NULL,0,t1.pd_stock_new_units)))) dnfactortotal,
        MAX(t1.pd_distribution_factor) distributionfactor,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)))) dissalesflag,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)) + ABS(DECODE(t1.pd_purchase_units,NULL,0,t1.pd_purchase_units)) + ABS(DECODE(t1.pd_stock_new_units,NULL,0,t1.pd_stock_new_units)))) distotalflag,
        /* Additional Columns Begin */
        t1.project_id project_id_d, t1.period_id period_id_d, t1.outlet_id outlet_id_d
        /* Additional Columns End */
    FROM
        lu_item_293 t5,
        lu_pg_featurevalue_15 t6,
        lu_elementgroup_rel t8,
        lu_elementrange_rel t7,
        fact_pd_out_itm_293 t1,
        lu_elementgroup_rel t9,
        lu_outlet_293 t2,
        lu_elementgroup_rel t3,
        lu_elementgroup_rel t4
    WHERE
    /* Attribute Joins */
          ((t1.outlet_id = t2.outlet_id
    /* Customizing Begin */
      AND   t1.period_id = t2.period_id
      AND   t1.project_id = t2.project_id)
    /* Customizing End */
      AND  (t2.ch_featurevalue_02_id = t3.value_id)
      AND  (t2.country_channel_id = t4.value_id)
      AND  (t1.item_id = t5.item_id
    /* Customizing Begin */
      AND   t1.productgroup_id = t5.productgroup_id)
    /* Customizing End */
      AND  (t5.pg_featurevalue_15_id = t6.pg_featurevalue_15_id)
      AND  (t6.pg_featurevalue_15_num BETWEEN t7.lbound AND t7.ubound)
      AND  (t5.pg_featurevalue_01_id = t8.value_id)
      AND  (t1.period_id = t9.value_id)
          )
    /* Attribute Filters */
      AND ((t5.productgroup_id = 15520)
      AND  (t1.productgroup_id = 15520) /* Push Down Filters */
      AND  (t2.ch_featurevalue_09_id = 7379)
      AND  (t3.elementgroup_id IN (3481,3482))
      AND  (t7.elementrange_id IN (3091,3092,3093,3107))
      AND  (t8.elementgroup_id IN (1959,1960,1961,1962,8574))
      AND  (t4.elementgroup_id = 14786)
      AND  (t2.country_channel_id IN (1873,1882)) /* Resolved ElementGroup Filters */
      AND  (t1.country_channel_id IN (1873,1882)) /* Push Down Filters */
      AND  (t9.elementgroup_id = 14659)
      AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
          )
    /* Fact Filters */
      AND (t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
          )
    GROUP BY
        t2.ch_featurevalue_09_id,
        t3.elementgroup_id,
        t7.elementrange_id,
        t8.elementgroup_id,
        t4.elementgroup_id,
        t5.productgroup_id,
        t9.elementgroup_id,
        t2.outlet_id,
        t1.project_id,
        /* Additional GroupBys Begin */
        t1.project_id, t1.period_id, t1.outlet_id
        /* Additional GroupBys End */
    ) tt1
GROUP BY
    tt1.ch_featurevalue_09_id,
    tt1.ch_featurevalue_02_elgr_id,
    tt1.pg_featurevalue_15_elrg_id,
    tt1.pg_featurevalue_01_elgr_id,
    tt1.countrychannel_elgr_id,
    tt1.productgroup_id,
    tt1.period_elgr_id
/
PROMPT @32 Results in 3140 Ticks



PROMPT @Statement 42  
rem #execute dbms_application_info.set_module('DWH_TEST','42');

SELECT
    'B' || tt1.ch_featurevalue_09_id ch_featurevalue_09_id,
    'G' || tt1.ch_featurevalue_02_elgr_id ch_featurevalue_02_id,
    'G' || tt1.pg_featurevalue_13_elgr_id pg_featurevalue_13_id,
    'B' || tt1.pg_featurevalue_15_id pg_featurevalue_15_id,
    'B' || tt1.pg_featurevalue_08_id pg_featurevalue_08_id,
    'G' || tt1.countrychannel_elgr_id countrychannel_id,
    'B' || tt1.productgroup_id productgroup_id,
    'G' || tt1.period_elgr_id period_id,
    SUM(tt1.dnfactorsales*tt1.turnoverfactor) salesvalueselloutlets,
    SUM(tt1.dnfactortotal*tt1.turnoverfactor) salesvaluetotaloutlets,
    SUM(tt1.distributionfactor*tt1.dissalesflag) selloutletsavg,
    SUM(tt1.distributionfactor*tt1.distotalflag) carroutletsavg
FROM 
    --------------------------
    -- TempTable 1
    --------------------------
    ( 
    SELECT /* ORDERED INDEX(t1) USE_HASH(t1) INDEX(t2) */
        t2.ch_featurevalue_09_id ch_featurevalue_09_id,
        t3.elementgroup_id ch_featurevalue_02_elgr_id,
        t6.elementgroup_id pg_featurevalue_13_elgr_id,
        t5.pg_featurevalue_15_id pg_featurevalue_15_id,
        t5.pg_featurevalue_08_id pg_featurevalue_08_id,
        t4.elementgroup_id countrychannel_elgr_id,
        t5.productgroup_id productgroup_id,
        t7.elementgroup_id period_elgr_id,
        t2.outlet_id outlet_id,
        t1.project_id project_id,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)))) dnfactorsales,
        MAX(t1.pd_turnover_factor*t1.pd_projection_factor) turnoverfactor,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)) + ABS(DECODE(t1.pd_purchase_units,NULL,0,t1.pd_purchase_units)) + ABS(DECODE(t1.pd_stock_new_units,NULL,0,t1.pd_stock_new_units)))) dnfactortotal,
        MAX(t1.pd_distribution_factor) distributionfactor,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)))) dissalesflag,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)) + ABS(DECODE(t1.pd_purchase_units,NULL,0,t1.pd_purchase_units)) + ABS(DECODE(t1.pd_stock_new_units,NULL,0,t1.pd_stock_new_units)))) distotalflag,
        /* Additional Columns Begin */
        t1.project_id project_id_d, t1.period_id period_id_d, t1.outlet_id outlet_id_d
        /* Additional Columns End */
    FROM
        lu_item_293 t5,
        lu_elementgroup_rel t6,
        fact_pd_out_itm_293 t1,
        lu_elementgroup_rel t7,
        lu_outlet_293 t2,
        lu_elementgroup_rel t3,
        lu_elementgroup_rel t4
    WHERE
    /* Attribute Joins */
          ((t1.outlet_id = t2.outlet_id
    /* Customizing Begin */
      AND   t1.period_id = t2.period_id
      AND   t1.project_id = t2.project_id)
    /* Customizing End */
      AND  (t2.ch_featurevalue_02_id = t3.value_id)
      AND  (t2.country_channel_id = t4.value_id)
      AND  (t1.item_id = t5.item_id
    /* Customizing Begin */
      AND   t1.productgroup_id = t5.productgroup_id)
    /* Customizing End */
      AND  (t5.pg_featurevalue_13_id = t6.value_id)
      AND  (t1.period_id = t7.value_id)
          )
    /* Attribute Filters */
      AND ((t5.productgroup_id = 15520)
      AND  (t1.productgroup_id = 15520) /* Push Down Filters */
      AND      NOT ((t5.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95)))
      AND  (t5.pg_featurevalue_08_id = 717)
      AND  (t5.pg_featurevalue_15_id IN (12425,1485))
      AND  (t2.ch_featurevalue_09_id = 7379)
      AND  (t3.elementgroup_id IN (3481,3482))
      AND  (t6.elementgroup_id IN (1952,1953))
      AND  (t4.elementgroup_id = 14786)
      AND  (t2.country_channel_id IN (1873,1882)) /* Resolved ElementGroup Filters */
      AND  (t1.country_channel_id IN (1873,1882)) /* Push Down Filters */
      AND  (t7.elementgroup_id = 14659)
      AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
          )
    /* Fact Filters */
      AND (t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
          )
    GROUP BY
        t2.ch_featurevalue_09_id,
        t3.elementgroup_id,
        t6.elementgroup_id,
        t5.pg_featurevalue_15_id,
        t5.pg_featurevalue_08_id,
        t4.elementgroup_id,
        t5.productgroup_id,
        t7.elementgroup_id,
        t2.outlet_id,
        t1.project_id,
        /* Additional GroupBys Begin */
        t1.project_id, t1.period_id, t1.outlet_id
        /* Additional GroupBys End */
    ) tt1
GROUP BY
    tt1.ch_featurevalue_09_id,
    tt1.ch_featurevalue_02_elgr_id,
    tt1.pg_featurevalue_13_elgr_id,
    tt1.pg_featurevalue_15_id,
    tt1.pg_featurevalue_08_id,
    tt1.countrychannel_elgr_id,
    tt1.productgroup_id,
    tt1.period_elgr_id
/
PROMPT @6 Results in 516 Ticks



PROMPT @Statement 43  
rem #execute dbms_application_info.set_module('DWH_TEST','43');

SELECT
    'B' || tt1.ch_featurevalue_09_id ch_featurevalue_09_id,
    'G' || tt1.ch_featurevalue_02_elgr_id ch_featurevalue_02_id,
    'B' || tt1.pg_featurevalue_05_id pg_featurevalue_05_id,
    'B' || tt1.pg_featurevalue_02_id pg_featurevalue_02_id,
    'r' || tt1.pg_featurevalue_15_elrg_id pg_featurevalue_15_id,
    'B' || tt1.pg_featurevalue_08_id pg_featurevalue_08_id,
    'G' || tt1.countrychannel_elgr_id countrychannel_id,
    'B' || tt1.productgroup_id productgroup_id,
    'G' || tt1.period_elgr_id period_id,
    SUM(tt1.dnfactorsales*tt1.turnoverfactor) salesvalueselloutlets,
    SUM(tt1.dnfactortotal*tt1.turnoverfactor) salesvaluetotaloutlets,
    SUM(tt1.distributionfactor*tt1.dissalesflag) selloutletsavg,
    SUM(tt1.distributionfactor*tt1.distotalflag) carroutletsavg
FROM 
    --------------------------
    -- TempTable 1
    --------------------------
    ( 
    SELECT /* ORDERED INDEX(t1) USE_HASH(t1) INDEX(t2) */
        t2.ch_featurevalue_09_id ch_featurevalue_09_id,
        t3.elementgroup_id ch_featurevalue_02_elgr_id,
        t5.pg_featurevalue_05_id pg_featurevalue_05_id,
        t5.pg_featurevalue_02_id pg_featurevalue_02_id,
        t7.elementrange_id pg_featurevalue_15_elrg_id,
        t5.pg_featurevalue_08_id pg_featurevalue_08_id,
        t4.elementgroup_id countrychannel_elgr_id,
        t5.productgroup_id productgroup_id,
        t8.elementgroup_id period_elgr_id,
        t2.outlet_id outlet_id,
        t1.project_id project_id,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)))) dnfactorsales,
        MAX(t1.pd_turnover_factor*t1.pd_projection_factor) turnoverfactor,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)) + ABS(DECODE(t1.pd_purchase_units,NULL,0,t1.pd_purchase_units)) + ABS(DECODE(t1.pd_stock_new_units,NULL,0,t1.pd_stock_new_units)))) dnfactortotal,
        MAX(t1.pd_distribution_factor) distributionfactor,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)))) dissalesflag,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)) + ABS(DECODE(t1.pd_purchase_units,NULL,0,t1.pd_purchase_units)) + ABS(DECODE(t1.pd_stock_new_units,NULL,0,t1.pd_stock_new_units)))) distotalflag,
        /* Additional Columns Begin */
        t1.project_id project_id_d, t1.period_id period_id_d, t1.outlet_id outlet_id_d
        /* Additional Columns End */
    FROM
        lu_item_293 t5,
        lu_pg_featurevalue_15 t6,
        lu_elementrange_rel t7,
        fact_pd_out_itm_293 t1,
        lu_elementgroup_rel t8,
        lu_outlet_293 t2,
        lu_elementgroup_rel t3,
        lu_elementgroup_rel t4
    WHERE
    /* Attribute Joins */
          ((t1.outlet_id = t2.outlet_id
    /* Customizing Begin */
      AND   t1.period_id = t2.period_id
      AND   t1.project_id = t2.project_id)
    /* Customizing End */
      AND  (t2.ch_featurevalue_02_id = t3.value_id)
      AND  (t2.country_channel_id = t4.value_id)
      AND  (t1.item_id = t5.item_id
    /* Customizing Begin */
      AND   t1.productgroup_id = t5.productgroup_id)
    /* Customizing End */
      AND  (t5.pg_featurevalue_15_id = t6.pg_featurevalue_15_id)
      AND  (t6.pg_featurevalue_15_num BETWEEN t7.lbound AND t7.ubound)
      AND  (t1.period_id = t8.value_id)
          )
    /* Attribute Filters */
      AND ((t5.productgroup_id = 15520)
      AND  (t1.productgroup_id = 15520) /* Push Down Filters */
      AND  (t5.pg_featurevalue_08_id IN (716,717))
      AND  (t5.pg_featurevalue_02_id IN (4165,4166))
      AND  (t5.pg_featurevalue_05_id = 5447)
      AND  (t2.ch_featurevalue_09_id = 7379)
      AND  (t3.elementgroup_id IN (3481,3482))
      AND  (t7.elementrange_id = 3091)
      AND      NOT ((/* ElementGroup Subselect */
                 (
                  t5.pg_featurevalue_01_id IN
                  (SELECT g1.value_id
                   FROM   lu_elementgroup_rel g1
                   WHERE
                   /* ElementGroup Filters */
                         (g1.elementgroup_id IN (1959,1960,1961,1962))
                  )
                 )
                )
           )
      AND  (t4.elementgroup_id = 14786)
      AND  (t2.country_channel_id IN (1873,1882)) /* Resolved ElementGroup Filters */
      AND  (t1.country_channel_id IN (1873,1882)) /* Push Down Filters */
      AND  (t8.elementgroup_id = 14659)
      AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
          )
    /* Fact Filters */
      AND (t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
          )
    GROUP BY
        t2.ch_featurevalue_09_id,
        t3.elementgroup_id,
        t5.pg_featurevalue_05_id,
        t5.pg_featurevalue_02_id,
        t7.elementrange_id,
        t5.pg_featurevalue_08_id,
        t4.elementgroup_id,
        t5.productgroup_id,
        t8.elementgroup_id,
        t2.outlet_id,
        t1.project_id,
        /* Additional GroupBys Begin */
        t1.project_id, t1.period_id, t1.outlet_id
        /* Additional GroupBys End */
    ) tt1
GROUP BY
    tt1.ch_featurevalue_09_id,
    tt1.ch_featurevalue_02_elgr_id,
    tt1.pg_featurevalue_05_id,
    tt1.pg_featurevalue_02_id,
    tt1.pg_featurevalue_15_elrg_id,
    tt1.pg_featurevalue_08_id,
    tt1.countrychannel_elgr_id,
    tt1.productgroup_id,
    tt1.period_elgr_id
/
PROMPT @8 Results in 2093 Ticks



PROMPT @Statement 44  
rem #execute dbms_application_info.set_module('DWH_TEST','44');

SELECT
    'B' || tt1.ch_featurevalue_09_id ch_featurevalue_09_id,
    'G' || tt1.ch_featurevalue_02_elgr_id ch_featurevalue_02_id,
    'G' || tt1.pg_featurevalue_13_elgr_id pg_featurevalue_13_id,
    'B' || tt1.pg_featurevalue_15_id pg_featurevalue_15_id,
    'B' || tt1.pg_featurevalue_08_id pg_featurevalue_08_id,
    'G' || tt1.countrychannel_elgr_id countrychannel_id,
    'B' || tt1.productgroup_id productgroup_id,
    'G' || tt1.period_elgr_id period_id,
    SUM(tt1.dnfactorsales*tt1.turnoverfactor) salesvalueselloutlets,
    SUM(tt1.dnfactortotal*tt1.turnoverfactor) salesvaluetotaloutlets,
    SUM(tt1.distributionfactor*tt1.dissalesflag) selloutletsavg,
    SUM(tt1.distributionfactor*tt1.distotalflag) carroutletsavg
FROM 
    --------------------------
    -- TempTable 1
    --------------------------
    ( 
    SELECT /* ORDERED INDEX(t1) USE_HASH(t1) INDEX(t2) */
        t2.ch_featurevalue_09_id ch_featurevalue_09_id,
        t3.elementgroup_id ch_featurevalue_02_elgr_id,
        t6.elementgroup_id pg_featurevalue_13_elgr_id,
        t5.pg_featurevalue_15_id pg_featurevalue_15_id,
        t5.pg_featurevalue_08_id pg_featurevalue_08_id,
        t4.elementgroup_id countrychannel_elgr_id,
        t5.productgroup_id productgroup_id,
        t7.elementgroup_id period_elgr_id,
        t2.outlet_id outlet_id,
        t1.project_id project_id,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)))) dnfactorsales,
        MAX(t1.pd_turnover_factor*t1.pd_projection_factor) turnoverfactor,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)) + ABS(DECODE(t1.pd_purchase_units,NULL,0,t1.pd_purchase_units)) + ABS(DECODE(t1.pd_stock_new_units,NULL,0,t1.pd_stock_new_units)))) dnfactortotal,
        MAX(t1.pd_distribution_factor) distributionfactor,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)))) dissalesflag,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)) + ABS(DECODE(t1.pd_purchase_units,NULL,0,t1.pd_purchase_units)) + ABS(DECODE(t1.pd_stock_new_units,NULL,0,t1.pd_stock_new_units)))) distotalflag,
        /* Additional Columns Begin */
        t1.project_id project_id_d, t1.period_id period_id_d, t1.outlet_id outlet_id_d
        /* Additional Columns End */
    FROM
        lu_item_293 t5,
        lu_elementgroup_rel t6,
        fact_pd_out_itm_293 t1,
        lu_elementgroup_rel t7,
        lu_outlet_293 t2,
        lu_elementgroup_rel t3,
        lu_elementgroup_rel t4
    WHERE
    /* Attribute Joins */
          ((t1.outlet_id = t2.outlet_id
    /* Customizing Begin */
      AND   t1.period_id = t2.period_id
      AND   t1.project_id = t2.project_id)
    /* Customizing End */
      AND  (t2.ch_featurevalue_02_id = t3.value_id)
      AND  (t2.country_channel_id = t4.value_id)
      AND  (t1.item_id = t5.item_id
    /* Customizing Begin */
      AND   t1.productgroup_id = t5.productgroup_id)
    /* Customizing End */
      AND  (t5.pg_featurevalue_13_id = t6.value_id)
      AND  (t1.period_id = t7.value_id)
          )
    /* Attribute Filters */
      AND ((t5.productgroup_id = 15520)
      AND  (t1.productgroup_id = 15520) /* Push Down Filters */
      AND  (t5.pg_featurevalue_08_id = 717)
      AND  (t5.pg_featurevalue_15_id IN (12425,1485))
      AND  (t2.ch_featurevalue_09_id = 7379)
      AND  (t3.elementgroup_id IN (3481,3482))
      AND  (t6.elementgroup_id IN (1952,1953))
      AND      NOT ((/* ElementGroup Subselect */
                 (
                  t5.pg_featurevalue_01_id IN
                  (SELECT g1.value_id
                   FROM   lu_elementgroup_rel g1
                   WHERE
                   /* ElementGroup Filters */
                         (g1.elementgroup_id IN (1959,1960,1961,1962))
                  )
                 )
                )
           )
      AND  (t4.elementgroup_id = 14786)
      AND  (t2.country_channel_id IN (1873,1882)) /* Resolved ElementGroup Filters */
      AND  (t1.country_channel_id IN (1873,1882)) /* Push Down Filters */
      AND  (t7.elementgroup_id = 14659)
      AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
          )
    /* Fact Filters */
      AND (t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
          )
    GROUP BY
        t2.ch_featurevalue_09_id,
        t3.elementgroup_id,
        t6.elementgroup_id,
        t5.pg_featurevalue_15_id,
        t5.pg_featurevalue_08_id,
        t4.elementgroup_id,
        t5.productgroup_id,
        t7.elementgroup_id,
        t2.outlet_id,
        t1.project_id,
        /* Additional GroupBys Begin */
        t1.project_id, t1.period_id, t1.outlet_id
        /* Additional GroupBys End */
    ) tt1
GROUP BY
    tt1.ch_featurevalue_09_id,
    tt1.ch_featurevalue_02_elgr_id,
    tt1.pg_featurevalue_13_elgr_id,
    tt1.pg_featurevalue_15_id,
    tt1.pg_featurevalue_08_id,
    tt1.countrychannel_elgr_id,
    tt1.productgroup_id,
    tt1.period_elgr_id
/
PROMPT @6 Results in 1296 Ticks



PROMPT @Statement 45  
rem #execute dbms_application_info.set_module('DWH_TEST','45');

SELECT
    'B' || tt1.ch_featurevalue_09_id ch_featurevalue_09_id,
    'G' || tt1.ch_featurevalue_02_elgr_id ch_featurevalue_02_id,
    'B' || tt1.pg_featurevalue_02_id pg_featurevalue_02_id,
    'G' || tt1.pg_featurevalue_01_elgr_id pg_featurevalue_01_id,
    'G' || tt1.countrychannel_elgr_id countrychannel_id,
    'B' || tt1.productgroup_id productgroup_id,
    'G' || tt1.period_elgr_id period_id,
    SUM(tt1.dnfactorsales*tt1.turnoverfactor) salesvalueselloutlets,
    SUM(tt1.dnfactortotal*tt1.turnoverfactor) salesvaluetotaloutlets,
    SUM(tt1.distributionfactor*tt1.dissalesflag) selloutletsavg,
    SUM(tt1.distributionfactor*tt1.distotalflag) carroutletsavg
FROM 
    --------------------------
    -- TempTable 1
    --------------------------
    ( 
    SELECT /* ORDERED INDEX(t1) USE_HASH(t1) INDEX(t2) */
        t2.ch_featurevalue_09_id ch_featurevalue_09_id,
        t3.elementgroup_id ch_featurevalue_02_elgr_id,
        t5.pg_featurevalue_02_id pg_featurevalue_02_id,
        t6.elementgroup_id pg_featurevalue_01_elgr_id,
        t4.elementgroup_id countrychannel_elgr_id,
        t5.productgroup_id productgroup_id,
        t7.elementgroup_id period_elgr_id,
        t2.outlet_id outlet_id,
        t1.project_id project_id,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)))) dnfactorsales,
        MAX(t1.pd_turnover_factor*t1.pd_projection_factor) turnoverfactor,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)) + ABS(DECODE(t1.pd_purchase_units,NULL,0,t1.pd_purchase_units)) + ABS(DECODE(t1.pd_stock_new_units,NULL,0,t1.pd_stock_new_units)))) dnfactortotal,
        MAX(t1.pd_distribution_factor) distributionfactor,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)))) dissalesflag,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)) + ABS(DECODE(t1.pd_purchase_units,NULL,0,t1.pd_purchase_units)) + ABS(DECODE(t1.pd_stock_new_units,NULL,0,t1.pd_stock_new_units)))) distotalflag,
        /* Additional Columns Begin */
        t1.project_id project_id_d, t1.period_id period_id_d, t1.outlet_id outlet_id_d
        /* Additional Columns End */
    FROM
        lu_item_293 t5,
        lu_elementgroup_rel t6,
        fact_pd_out_itm_293 t1,
        lu_elementgroup_rel t7,
        lu_outlet_293 t2,
        lu_elementgroup_rel t3,
        lu_elementgroup_rel t4
    WHERE
    /* Attribute Joins */
          ((t1.outlet_id = t2.outlet_id
    /* Customizing Begin */
      AND   t1.period_id = t2.period_id
      AND   t1.project_id = t2.project_id)
    /* Customizing End */
      AND  (t2.ch_featurevalue_02_id = t3.value_id)
      AND  (t2.country_channel_id = t4.value_id)
      AND  (t1.item_id = t5.item_id
    /* Customizing Begin */
      AND   t1.productgroup_id = t5.productgroup_id)
    /* Customizing End */
      AND  (t5.pg_featurevalue_01_id = t6.value_id)
      AND  (t1.period_id = t7.value_id)
          )
    /* Attribute Filters */
      AND ((t5.productgroup_id = 15520)
      AND  (t1.productgroup_id = 15520) /* Push Down Filters */
      AND  (t5.pg_featurevalue_02_id = 4165)
      AND  (t2.ch_featurevalue_09_id = 7379)
      AND  (t3.elementgroup_id IN (3481,3482))
      AND  (t6.elementgroup_id IN (1959,1960,1961,1962,8574))
      AND  (t4.elementgroup_id = 14786)
      AND  (t2.country_channel_id IN (1873,1882)) /* Resolved ElementGroup Filters */
      AND  (t1.country_channel_id IN (1873,1882)) /* Push Down Filters */
      AND  (t7.elementgroup_id = 14659)
      AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
          )
    /* Fact Filters */
      AND (t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
          )
    GROUP BY
        t2.ch_featurevalue_09_id,
        t3.elementgroup_id,
        t5.pg_featurevalue_02_id,
        t6.elementgroup_id,
        t4.elementgroup_id,
        t5.productgroup_id,
        t7.elementgroup_id,
        t2.outlet_id,
        t1.project_id,
        /* Additional GroupBys Begin */
        t1.project_id, t1.period_id, t1.outlet_id
        /* Additional GroupBys End */
    ) tt1
GROUP BY
    tt1.ch_featurevalue_09_id,
    tt1.ch_featurevalue_02_elgr_id,
    tt1.pg_featurevalue_02_id,
    tt1.pg_featurevalue_01_elgr_id,
    tt1.countrychannel_elgr_id,
    tt1.productgroup_id,
    tt1.period_elgr_id
/
PROMPT @10 Results in 1188 Ticks

set timing off;
-- set module info to null
execute dbms_application_info.set_module(NULL, NULL);

PROMPT we are done  
set autotrace off;
set echo on;
set termout on;
SELECT '@End', sysdate from dual;
spool off;

FIN!

