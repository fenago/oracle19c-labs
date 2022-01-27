create or replace procedure chng_phoneno
 (v_phone_no in out varchar2(8))
is
begin
  v_phone_no := substr(v_phone_no,1,3)||'-'||
                 substr(v_phone_no,4,4);
end chng_phoneno;
/
