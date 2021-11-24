set echo on
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
SELECT lo_shipmode, sum(lo_quantity) as sum_qty, 
            sum(lo_extendedprice) as sum_base_price,
            sum(lo_extendedprice * (1 - lo_discount)) 
                as sum_disc_price,
            sum(lo_extendedprice*(1-lo_discount)*(1+lo_tax)) 
                as charge,
            avg(lo_quantity) as avg_qty, 
            avg(lo_extendedprice) as avg_price, 
            avg(lo_discount) as avg_disc,
            count(*) as count_order
     FROM   oe.lineorder l , oe.date_dim d
     WHERE  l.lo_orderdate = d.d_datekey
     AND    to_date(d.d_datekey , 'YYYY-MM-DD') 
             <= to_date('1998-12-31','YYYY-MM-DD')-90
     GROUP BY lo_shippriority, lo_shipmode
     ORDER BY lo_shippriority, lo_shipmode;
SELECT * FROM oe.test;
