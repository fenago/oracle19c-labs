set echo on

select /*SPM_USE*/ * from sh.sales 
where quantity_sold > 40 order by prod_id;

