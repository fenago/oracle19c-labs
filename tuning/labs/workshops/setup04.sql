DROP TABLE sh.sales1 PURGE
/
CREATE TABLE sh.sales1(
   sales_id number primary key,
   prod_id number,
   yyyy char(4),
   mm char(2),
   dd char(2),
   amount_sold number(10,2)
 )
/
DROP SEQUENCE sh.sales_id_seq
/
CREATE SEQUENCE sh.sales_id_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE
/

INSERT INTO sh.sales1
SELECT sales_id_seq.nextval, prod_id,to_char(time_id, 'YYYY'), to_char(time_id, 'MM'), to_char(time_id, 'DD'),amount_sold
FROM  sh.sales
/

COMMIT
/

DROP TABLE sh.prod1 PURGE
/
CREATE TABLE sh.prod1 AS SELECT * FROM sh.products
/

DROP INDEX sh.time_idx
/
CREATE INDEX sh.time_idx 
ON sh.sales1(YYYY, MM, DD, sales_id)
NOLOGGING
COMPUTE STATISTICS
/

exec DBMS_STATS.GATHER_TABLE_STATS('SH','SALES1', METHOD_OPT => 'FOR ALL INDEXED COLUMNS',CASCADE => TRUE)
/
exec DBMS_STATS.GATHER_TABLE_STATS('SH','PROD1', METHOD_OPT => 'FOR ALL INDEXED COLUMNS',CASCADE => TRUE)
/	

DESC sh.sales1
DESC sh.prod1
