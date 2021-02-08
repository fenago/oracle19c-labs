Rem
Rem $Header: psh_v2.sql 29-aug-2002.11:51:38 hyeh Exp $
Rem
Rem psh_v2.sql
Rem
Rem Copyright (c) 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      psh_v2.sql - <one-line expansion of the name>
Rem
Rem    DESCRIPTION
Rem      <short description of component this file declares/defines>
Rem
Rem    NOTES
Rem      <other useful comments, qualifications, etc.>
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    hyeh        08/29/02 - hyeh_mv_comschema_to_rdbms
Rem    ahunold     08/15/02 - Created
Rem

SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100

PROMPT creating indexes ...
@?/demo/schema/sales_history/sh_idx.sql

PROMPT adding constraints ...
@?/demo/schema/sales_history/sh_cons.sql

PROMPT creating dimensions and hierarchies ...
@?/demo/schema/sales_history/sh_hiera.sql

PROMPT creating materialized views ...
@?/demo/schema/sales_history/sh_cremv.sql     

PROMPT adding comments ...
@?/demo/schema/sales_history/sh_comnt.sql

PROMPT creating PLAN_TABLE ...
@?/rdbms/admin/utlxplan.sql

PROMPT creating REWRITE_TABLE ...
@?/rdbms/admin/utlxrw.sql

PROMPT creating MV_CAPABILITIES_TABLE ...
@?/rdbms/admin/utlxmv.sql

PROMPT gathering statistics ...
@?/demo/schema/sales_history/sh_analz.sql   

COMMIT;  
