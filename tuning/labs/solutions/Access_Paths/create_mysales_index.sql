set echo on
alter session set container = orclpdb;
drop index mysales_prodid_idx;
create index mysales_prodid_idx on mysales(prod_id) nologging;
exit;

