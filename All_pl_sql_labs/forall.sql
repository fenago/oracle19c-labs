create table tester
(num_tab varchar2(30),
 vc_tab varchar2(20));
declare
  type num_type is table of number index by binary_integer;
  type vc_type is table of varchar2(32) index by binary_integer;
  num_tab num_type;
  vc_tab vc_type;
begin
 num_tab(1) := 2;
 vc_tab(1) := 'abcd';
 num_tab(2) := 3;
 vc_tab(2) := 'qwerty';
 forall i in 1..num_tab.count
  insert into tester values (num_tab(i),vc_tab(i));
end;
/


select * from tester;