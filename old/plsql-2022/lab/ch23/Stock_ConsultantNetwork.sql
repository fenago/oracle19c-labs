CREATE TABLE stocks
(time      DATE, 
 name      VARCHAR2(20),
 price     NUMBER(12,5), 
 CONSTRAINT stocks_pk PRIMARY KEY (time,name)
);
INSERT INTO stocks VALUES ('07-AUG-15','Consultant Network',25);
INSERT INTO stocks VALUES ('08-AUG-15','Consultant Network',15);
INSERT INTO stocks VALUES ('09-AUG-15','Consultant Network',14);
INSERT INTO stocks VALUES ('10-AUG-15','Consultant Network',11);
INSERT INTO stocks VALUES ('11-AUG-15','Consultant Network',15);
INSERT INTO stocks VALUES ('12-AUG-15','Consultant Network',30);
INSERT INTO stocks VALUES ('13-AUG-15','Consultant Network',12);
INSERT INTO stocks VALUES ('14-AUG-15','Consultant Network',13);
INSERT INTO stocks VALUES ('15-AUG-15','Consultant Network',15);
INSERT INTO stocks VALUES ('16-AUG-15','Consultant Network',18);
INSERT INTO stocks VALUES ('17-AUG-15','Consultant Network',20);
INSERT INTO stocks VALUES ('18-AUG-15','Consultant Network',25);
INSERT INTO stocks VALUES ('19-AUG-15','Consultant Network',32);
INSERT INTO stocks VALUES ('20-AUG-15','Consultant Network',19);
INSERT INTO stocks VALUES ('21-AUG-15','Consultant Network',17);
INSERT INTO stocks VALUES ('22-AUG-15','Consultant Network',12);
INSERT INTO stocks VALUES ('23-AUG-15','Consultant Network',10);
INSERT INTO stocks VALUES ('24-AUG-15','Consultant Network',9);
INSERT INTO stocks VALUES ('25-AUG-15','Consultant Network',25);
INSERT INTO stocks VALUES ('26-AUG-15','Consultant Network',35);
COMMIT;

