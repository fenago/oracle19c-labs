set echo on

set timing on

select /* Without system stats */ count(*)
from t,z
where t.c=z.d;

set timing off

