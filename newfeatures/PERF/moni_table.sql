set echo on
DROP TABLE moni.moni_test PURGE;
CREATE TABLE moni.moni_test(c number, d varchar2(500));
GRANT select ON moni.moni_test TO sqldev;

begin
for i in 1..200000 loop
insert into moni.moni_test values(1,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
end loop;
commit;
end;
/

CREATE INDEX moni.moni_test_c_indx on moni.moni_test(c);

GRANT SELECT ON moni.moni_test TO sqldev;
EXIT