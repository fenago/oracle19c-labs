SET ECHO ON
CREATE TABLE schema_app1.tab3 (COL1 number, Description VARCHAR2(10));
INSERT INTO schema_app1.tab3 VALUES (1,'Desc1');
COMMIT;
DROP USER hr CASCADE;
CREATE USER hr IDENTIFIED BY Welcome_1;
GRANT create session, create table, unlimited tablespace TO hr;
CREATE TABLE hr.departments
    ( department_id    NUMBER(4)
    , department_name  VARCHAR2(30)
        CONSTRAINT  dept_name_nn  NOT NULL
    , manager_id       NUMBER(6)
    , location_id      NUMBER(4)
    ) ;
INSERT INTO hr.departments VALUES
        ( 10
        , 'Administration'
        , 200
        , 1700
        );

INSERT INTO hr.departments VALUES
        ( 20
        , 'Marketing'
        , 201
        , 1800
        );

INSERT INTO hr.departments VALUES
        ( 30
        , 'Purchasing'
        , 114
        , 1700
        );

INSERT INTO hr.departments VALUES
        ( 40
        , 'Human Resources'
        , 203
        , 2400
        );

INSERT INTO hr.departments VALUES
        ( 50
        , 'Shipping'
        , 121
        , 1500
        );

INSERT INTO hr.departments VALUES
        ( 60
        , 'IT'
        , 103
        , 1400
        );

INSERT INTO hr.departments VALUES
        ( 70
        , 'Public Relations'
        , 204
        , 2700
        );

INSERT INTO hr.departments VALUES
        ( 80
        , 'Sales'
        , 145
        , 2500
        );

INSERT INTO hr.departments VALUES
        ( 90
        , 'Executive'
        , 100
        , 1700
        );

INSERT INTO hr.departments VALUES
        ( 100
        , 'Finance'
        , 108
        , 1700
        );

INSERT INTO hr.departments VALUES
        ( 110
        , 'Accounting'
        , 205
        , 1700
        );

INSERT INTO hr.departments VALUES
        ( 120
        , 'Treasury'
        , NULL
        , 1700
        );
INSERT INTO hr.departments VALUES
        ( 130
        , 'Corporate Tax'
        , NULL
        , 1700
        );

INSERT INTO hr.departments VALUES
        ( 140
        , 'Control And Credit'
        , NULL
        , 1700
        );

INSERT INTO hr.departments VALUES
        ( 150
        , 'Shareholder Services'
        , NULL
        , 1700
        );

INSERT INTO hr.departments VALUES
        ( 160
        , 'Benefits'
        , NULL
        , 1700
        );

INSERT INTO hr.departments VALUES
        ( 170
        , 'Manufacturing'
        , NULL
        , 1700
        );

INSERT INTO hr.departments VALUES
        ( 180
        , 'Construction'
        , NULL
        , 1700
        );

INSERT INTO hr.departments VALUES
        ( 270
        , 'Payroll'
        , NULL
        , 1700
        );

COMMIT;
SELECT * FROM HR.departments;

