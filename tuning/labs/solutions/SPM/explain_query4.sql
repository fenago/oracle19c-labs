set echo on

explain plan for
select /*SPM_USE*/ * from sh.sales 
where quantity_sold > 40 order by prod_id;

select * from table(dbms_xplan.display(null,null,'basic'));

