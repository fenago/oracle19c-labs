set echo on
COL table_name format A27
COL partition_name format A21
col high_value format A43
INSERT INTO sh.sales_by_region_and_channel VALUES (10, 'ACCOUNTING', 100, 'WA','D');
INSERT INTO sh.sales_by_region_and_channel VALUES (20, 'RD', 150, 'OR','W') ;
INSERT INTO sh.sales_by_region_and_channel VALUES (50, 'SYSTEMS ENGINEERING', 10, 'CA','D') ;
INSERT INTO sh.sales_by_region_and_channel VALUES (50, 'SYSTEMS ENGINEERING', 10, 'CA','I') ;
INSERT INTO sh.sales_by_region_and_channel VALUES (30, 'SALES', 100, 'FL',NULL);
INSERT INTO sh.sales_by_region_and_channel VALUES (40, 'HR', 10, 'TX','W') ;
INSERT INTO sh.sales_by_region_and_channel VALUES (50, 'HR', 20, null,'W') ;
COMMIT;
