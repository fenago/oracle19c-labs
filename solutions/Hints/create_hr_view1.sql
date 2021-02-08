CREATE OR REPLACE VIEW v1 AS
  SELECT *
  FROM   employees
  WHERE  employee_id < 150;

