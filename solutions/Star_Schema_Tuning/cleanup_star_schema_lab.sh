sqlplus /nolog <<-FIN
connect sh/sh
set echo on

set timing off
set autotrace off

drop index sales_c_state_bjix;

alter table customers enable novalidate constraint customers_pk;

exit;
FIN
