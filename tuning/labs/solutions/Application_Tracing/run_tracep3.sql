set echo on

connect trace/trace@orclpdb

alter session set tracefile_identifier='mytraceP3';

update sales set amount_sold=20000 where prod_id=13 and cust_id=987;

commit;


connect trace/trace@orclpdb

create index sales_prod_cust_indx on sales(prod_id,cust_id);

connect trace/trace@orclpdb

alter session set tracefile_identifier='mytraceS3';

update sales set amount_sold=30000 where prod_id=13 and cust_id=987;

commit;

connect trace/trace@orclpdb

drop index sales_prod_cust_indx;


exit;

