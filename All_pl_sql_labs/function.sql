create or replace function spell_number
(dept_no number)
return varchar2 
is 
tmp varchar2(30);
begin
 if dept_no < 30 then
  return null;
 else 
  select to_char(to_date(lpad(to_char(dept_no),4,'0'),'YYYY'),'Year')
   into tmp
    from dual;
 return tmp;
 end if;
 end;
 /
 
 select spell_number(40) from dual;