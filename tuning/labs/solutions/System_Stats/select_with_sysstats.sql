set timing on

select /* With system stats */ count(*)
from t,z
where t.c=z.d;

set timing off

