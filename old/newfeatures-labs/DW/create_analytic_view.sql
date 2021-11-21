set echo on
CREATE OR REPLACE ANALYTIC VIEW av.sales_av
USING sales_fact
DIMENSION BY
  (time_attr_dim
    KEY month_id REFERENCES month_id
    HIERARCHIES ( time_hier DEFAULT),
   product_attr_dim
    KEY category_id REFERENCES category_id
    HIERARCHIES ( product_hier DEFAULT),
   geography_attr_dim
    KEY state_province_id REFERENCES state_province_id
    HIERARCHIES ( geography_hier DEFAULT)
   )
MEASURES
 (sales FACT sales,
  units FACT units
  )
DEFAULT MEASURE SALES;
exit
