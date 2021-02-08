set echo on

select /*LOAD_AUTO*/ * from sh.sales 
where quantity_sold > 40 order by prod_id;

