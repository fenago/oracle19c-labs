create or replace package data_scramble_crypto_pkg
is
 function char_scramble_crypto(in_data in varchar2)
 return varchar2;
 function number_scramble_crypto(in_number in varchar2)
 return varchar2;
 function date_scramble_crypto(in_date in date)
 return date;
 function phone_scramble(in_data in varchar2)
 return varchar2;
 function ssn_scramble(in_data in varchar2)
 return varchar2;
end;
/
create or replace package body data_scramble_crypto_pkg is
function char_scramble_crypto(in_data in varchar2)
return varchar2
as
begin
   return substr((sys.dbms_crypto.hash(utl_raw.cast_to_raw(in_data),3)),1,20);
end;

function number_scramble_crypto(in_number in varchar2)
return varchar2
as
begin
  return (sys.dbms_crypto.hash(utl_raw.cast_to_raw(in_number),3));
end;

function date_scramble_crypto(in_date in date)
return date
as
begin
   return (in_date + sys.dbms_random.value(0,366));
end;


function phone_scramble(in_data in varchar2)
return varchar2
as
begin
   return (translate(in_data,
     '1234567890',
'0123456789') );
end;

function ssn_scramble(in_data in varchar2)
return varchar2
as
begin
   return (substr((sys.dbms_crypto.hash(utl_raw.cast_to_raw(in_data),3)),1,11));
end;

end;
/
