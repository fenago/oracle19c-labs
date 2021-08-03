load data 
infile '/home/oracle/labs/PERF/lineorder2.tbl'
badfile 'lineorder2.bad'
discardfile 'lineorder2.disc'
append
into table oe.lineorder fields terminated by '|'
nullif = blanks
(LO_ORDERKEY ,
LO_LINENUMBER ,
LO_CUSTKEY ,
LO_PARTKEY ,
LO_SUPPKEY ,
LO_ORDERDATE ,
LO_ORDERPRIORITY ,
LO_SHIPPRIORITY ,
LO_QUANTITY ,
LO_EXTENDEDPRICE ,
LO_ORDTOTALPRICE ,
LO_DISCOUNT ,
LO_REVENUE ,
LO_SUPPLYCOST ,
LO_TAX ,
LO_COMMITDATE ,
LO_SHIPMODE )

