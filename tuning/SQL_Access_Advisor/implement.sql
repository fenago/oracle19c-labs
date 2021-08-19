Rem SQL Access Advisor: Version 11.1.0.6.0 - Production
Rem
Rem Username: SH
Rem Task: MY_SQLACCESS_TASK
Rem Execution date:
Rem

Rem
Rem Repartitioning table "SH"."CUSTOMERS"
Rem

SET SERVEROUTPUT ON
SET ECHO ON

Rem
Rem Creating new partitioned table
Rem
CREATE TABLE "SH"."CUSTOMERS1"
(    "CUST_ID" NUMBER,
    "CUST_FIRST_NAME" VARCHAR2(20),
    "CUST_LAST_NAME" VARCHAR2(40),
    "CUST_GENDER" CHAR(1),
    "CUST_YEAR_OF_BIRTH" NUMBER(4,0),
    "CUST_MARITAL_STATUS" VARCHAR2(20),
    "CUST_STREET_ADDRESS" VARCHAR2(40),
    "CUST_POSTAL_CODE" VARCHAR2(10),
    "CUST_CITY" VARCHAR2(30),
    "CUST_CITY_ID" NUMBER,
    "CUST_STATE_PROVINCE" VARCHAR2(40),
    "CUST_STATE_PROVINCE_ID" NUMBER,
    "COUNTRY_ID" NUMBER,
    "CUST_MAIN_PHONE_NUMBER" VARCHAR2(25),
    "CUST_INCOME_LEVEL" VARCHAR2(30),
    "CUST_CREDIT_LIMIT" NUMBER,
    "CUST_EMAIL" VARCHAR2(30),
    "CUST_TOTAL" VARCHAR2(14),
    "CUST_TOTAL_ID" NUMBER,
    "CUST_SRC_ID" NUMBER,
    "CUST_EFF_FROM" DATE,
    "CUST_EFF_TO" DATE,
    "CUST_VALID" VARCHAR2(1)
) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
TABLESPACE "EXAMPLE"
PARTITION BY RANGE ("CUST_ID") INTERVAL( 3000) ( PARTITION VALUES LESS THAN (3000)
);

Rem
Rem Copying comments to new partitioned table
Rem
COMMENT ON COLUMN "SH"."CUSTOMERS1"."CUST_ID" IS 'primary key';

COMMENT ON COLUMN "SH"."CUSTOMERS1"."CUST_FIRST_NAME" IS 'first name of the customer';

COMMENT ON COLUMN "SH"."CUSTOMERS1"."CUST_LAST_NAME" IS 'last name of the customer';

COMMENT ON COLUMN "SH"."CUSTOMERS1"."CUST_GENDER" IS 'gender; low cardinality attribute';

COMMENT ON COLUMN "SH"."CUSTOMERS1"."CUST_YEAR_OF_BIRTH" IS 'customer year of birth';

COMMENT ON COLUMN "SH"."CUSTOMERS1"."CUST_MARITAL_STATUS" IS 'customer marital status; low cardinality attribute';

COMMENT ON COLUMN "SH"."CUSTOMERS1"."CUST_STREET_ADDRESS" IS 'customer street address';

COMMENT ON COLUMN "SH"."CUSTOMERS1"."CUST_POSTAL_CODE" IS 'postal code of the customer';


COMMENT ON COLUMN "SH"."CUSTOMERS1"."CUST_CITY" IS 'city where the customer lives';

COMMENT ON COLUMN "SH"."CUSTOMERS1"."CUST_STATE_PROVINCE" IS 'customer geography: state or province';

COMMENT ON COLUMN "SH"."CUSTOMERS1"."COUNTRY_ID" IS 'foreign key to the countries table (snowflake)';

COMMENT ON COLUMN "SH"."CUSTOMERS1"."CUST_MAIN_PHONE_NUMBER" IS 'customer main phone number';

COMMENT ON COLUMN "SH"."CUSTOMERS1"."CUST_INCOME_LEVEL" IS 'customer income level';

COMMENT ON COLUMN "SH"."CUSTOMERS1"."CUST_CREDIT_LIMIT" IS 'customer credit limit';

COMMENT ON COLUMN "SH"."CUSTOMERS1"."CUST_EMAIL" IS 'customer email id';

COMMENT ON TABLE "SH"."CUSTOMERS1" IS 'dimension table';

Rem
Rem Copying constraints to new partitioned table
Rem
ALTER TABLE "SH"."CUSTOMERS1" ADD CONSTRAINT "CUSTOMERS_PK1" PRIMARY KEY ("CUST_ID")
USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS
TABLESPACE "EXAMPLE" ENABLE NOVALIDATE;

Rem
Rem Copying referential constraints to new partitioned table
Rem
ALTER TABLE "SH"."CUSTOMERS1" ADD CONSTRAINT "CUSTOMERS_COUNTRY_FK1" FOREIGN KEY ("COUNTRY_ID")
     REFERENCES "SH"."COUNTRIES" ("COUNTRY_ID") ENABLE NOVALIDATE;

Rem
Rem Copying indexes to new partitioned table
Rem
CREATE BITMAP INDEX "SH"."CUSTOMERS_GENDER_BIX1" ON "SH"."CUSTOMERS1" ("CUST_GENDER")
PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS
TABLESPACE "EXAMPLE" LOCAL;

Rem
Rem Copying object grants to new partitioned table
Rem
GRANT SELECT ON "SH"."CUSTOMERS1" TO "BI";

Rem
Rem Populating new partitioned table with data from original table
Rem
INSERT /*+ APPEND */ INTO "SH"."CUSTOMERS1"
SELECT * FROM "SH"."CUSTOMERS";
COMMIT;

begin
dbms_stats.gather_table_stats('"SH"', '"CUSTOMERS1"', NULL, dbms_stats.auto_sample_size);
end;
/

Rem
Rem Renaming tables to give new partitioned table the original table name
Rem
ALTER TABLE "SH"."CUSTOMERS" RENAME TO "CUSTOMERS11";
ALTER TABLE "SH"."CUSTOMERS1" RENAME TO "CUSTOMERS";

Rem
Rem Revalidating dimensions for use with new partitioned table
Rem
ALTER DIMENSION "SH"."CUSTOMERS_DIM" COMPILE;


CREATE MATERIALIZED VIEW LOG ON
"SH"."CUSTOMERS"
WITH ROWID, SEQUENCE("CUST_ID","CUST_CITY","CUST_STATE_PROVINCE")
INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON
"SH"."CHANNELS"
WITH ROWID, SEQUENCE("CHANNEL_ID","CHANNEL_DESC","CHANNEL_CLASS")
INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON
"SH"."TIMES"
WITH ROWID, SEQUENCE("TIME_ID","CALENDAR_QUARTER_DESC")
INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON
"SH"."SALES"
WITH ROWID, SEQUENCE("CUST_ID","TIME_ID","CHANNEL_ID","AMOUNT_SOLD")
INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW "SH"."MV_01DF0000"
REFRESH FAST WITH ROWID
ENABLE QUERY REWRITE
AS SELECT SH.CUSTOMERS.CUST_STATE_PROVINCE C1, SH.CUSTOMERS.CUST_CITY C2, SH.CHANNELS.CHANNEL_CLASS
C3, SH.CHANNELS.CHANNEL_DESC C4, SH.TIMES.CALENDAR_QUARTER_DESC C5, SUM("SH"."SALES"."AMOUNT_SOLD")
M1, COUNT("SH"."SALES"."AMOUNT_SOLD") M2, COUNT(*) M3 FROM SH.CUSTOMERS,
SH.CHANNELS, SH.TIMES, SH.SALES WHERE SH.SALES.CHANNEL_ID = SH.CHANNELS.CHANNEL_ID
AND SH.SALES.TIME_ID = SH.TIMES.TIME_ID AND SH.SALES.CUST_ID = SH.CUSTOMERS.CUST_ID
AND (SH.TIMES.CALENDAR_QUARTER_DESC IN ('1999-04', '1999-03', '1999-02'
, '1999-01')) AND (SH.CHANNELS.CHANNEL_DESC IN ('Internet', 'Catalog'
)) AND (SH.CUSTOMERS.CUST_STATE_PROVINCE = 'CA') GROUP BY SH.CUSTOMERS.CUST_STATE_PROVINCE,
SH.CUSTOMERS.CUST_CITY, SH.CHANNELS.CHANNEL_CLASS, SH.CHANNELS.CHANNEL_DESC,
SH.TIMES.CALENDAR_QUARTER_DESC;

begin
dbms_stats.gather_table_stats('"SH"','"MV_01DF0000"',NULL,dbms_stats.auto_sample_size);
end;
/

CREATE BITMAP INDEX "SH"."CUSTOMERSJFV_IDX_01DF0000"
ON "SH"."CUSTOMERSJFV"
("CUST_STATE_PROVINCE")
COMPUTE STATISTICS;

CREATE INDEX "SH"."TEMPJFV_IDX_01DF0001"
ON "SH"."TEMPJFV"
(ABS("C"))
COMPUTE STATISTICS;

CREATE INDEX "SH"."CUSTOMERS_IDX_01DF0002"
ON "SH"."CUSTOMERS"
("COUNTRY_ID","CUST_CITY","CUST_LAST_NAME")
COMPUTE STATISTICS;

