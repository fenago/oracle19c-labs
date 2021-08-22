  create tablespace jerry
datafile /u01/app/oracle/jerdat01.dbf size 100m;
CREATE TABLE        BIG
       		(BIGNO       NUMBER(6),
        		BNAME       VARCHAR2(20))
        	tablespace jerry;  --See cr8big.sql
/
