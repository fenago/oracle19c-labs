set echo on

create index mysales_prodid_idx on mysales(prod_id) 
nologging compute statistics;

