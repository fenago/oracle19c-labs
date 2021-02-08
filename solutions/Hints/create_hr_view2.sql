CREATE OR REPLACE VIEW v2 AS
  SELECT v1.employee_id employee_id, departments.department_id department_id
  FROM   v1, departments
  WHERE  v1.department_id = departments.department_id;

