set echo on

connect trace/trace@TRACESERV

alter session set tracefile_identifier='mytraceP7';

declare
   c number := dbms_sql.open_cursor;
   custid  number;
   amount  number;
   ignore integer;
begin
   dbms_sql.parse(c,'select cust_id, sum(amount_sold) from sales where cust_id=2 group by cust_id order by cust_id' , dbms_sql.native); -- use bind var
   dbms_sql.define_column(c, 1, custid);
   dbms_sql.define_column(c, 2, amount);
   ignore := dbms_sql.execute(c);
   if dbms_sql.fetch_rows(c)>0 then 
     dbms_sql.column_value(c, 1, custid);
     dbms_sql.column_value(c, 2, amount);
   end if;
end;
/

connect trace/trace

create index sales_cust_indx on sales(cust_id);

exit;

