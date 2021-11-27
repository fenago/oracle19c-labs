set echo on

connect trace/trace@orclpdb

alter session set tracefile_identifier='mytraceP4';

set timing on

DECLARE
  TYPE SalesCurTyp  IS REF CURSOR;
  v_sales_cursor    SalesCurTyp;
  sales_record      sh.sales%ROWTYPE;
  v_stmt_str      VARCHAR2(200);
BEGIN
  -- Dynamic SQL statement with placeholder:
  v_stmt_str := 'select * from sh.sales where amount_sold>0';

  -- Open cursor and specify bind argument in USING clause:
  OPEN v_sales_cursor FOR v_stmt_str;

  -- Fetch rows from result set one at a time:
  LOOP
    FETCH v_sales_cursor INTO sales_record;
    EXIT WHEN v_sales_cursor%NOTFOUND;
  END LOOP;

  -- Close cursor:
  CLOSE v_sales_cursor;
END;
/


connect trace/trace@orclpdb

alter session set tracefile_identifier='mytraceS4';

set timing on

DECLARE
  TYPE SalesCurTyp  IS REF CURSOR;
  TYPE SalesList IS TABLE OF sh.sales%ROWTYPE;
  v_sales_cursor    SalesCurTyp;
  sales_List        SalesList;
  v_stmt_str      VARCHAR2(200);
BEGIN
  -- Dynamic SQL statement with placeholder:
  v_stmt_str := 'select /* S4 */ * from sh.sales where amount_sold>0';

  -- Open cursor:
  OPEN v_sales_cursor FOR v_stmt_str;

  -- Fetch rows from result set one at a time:
  LOOP
    FETCH v_sales_cursor BULK COLLECT INTO Sales_List LIMIT 10000;
    EXIT WHEN v_sales_cursor%NOTFOUND;
  END LOOP;

  -- Close cursor:
  CLOSE v_sales_cursor;
END;
/


exit;

