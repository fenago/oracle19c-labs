set echo on

variable sqltext varchar2(4000);

BEGIN
  :sqltext := q'# select /*+ USE_NL(s c) FULL(s) FULL(c) */
		   c.cust_id, sum(s.quantity_sold)
                  from sh.sales s, sh.customers c
                  where s.cust_id = c.cust_id
                        and c.cust_id < 2
                  group by c.cust_id
                #';
END;
/

variable spmtune   varchar2(30);

exec :spmtune := dbms_sqltune.create_tuning_task(-
			sql_text => :sqltext);

exec dbms_sqltune.execute_tuning_task(:spmtune);

