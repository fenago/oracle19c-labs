-- As orclpdb1_system

drop user ernesto cascade;
drop user procowner cascade;
drop user procuser;

create user ernesto identified by fenago;
grant unlimited tablespace to ernesto;
grant connect,create table to ernesto;
grant create procedure to ernesto;
create user procowner identified by oracle1;
create user procuser identified by oracle2;


grant connect, create procedure to procowner;
grant create session to procuser;

drop table ernesto.tbl;

create table ernesto.tbl(a number, b varchar2(40));
insert into ernesto.tbl values(1, 'old_value');
commit;
grant select on ernesto.tbl to procuser;
grant all on ernesto.tbl to procowner;
-- AS procowner
CREATE OR REPLACE PROCEDURE procowner.UpdateTbl (x IN number,y IN varchar2)
AUTHID DEFINER AS 
BEGIN
UPDATE ERNESTO.TBL 
SET b = y
WHERE a = x;
END;
/
grant execute on procowner.UpdateTbl to procuser;

-- As Procuser


UPDATE ERNESTO.TBL SET B = 'value1' WHERE A = 1;
EXEC procowner.UpdateTbl(1, 'new_value');

