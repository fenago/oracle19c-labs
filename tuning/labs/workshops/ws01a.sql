DROP INDEX hr.dept_dept_id_idx2
/
CREATE INDEX hr.dept_dept_id_idx2
ON hr.dept(substr(dept_id,1, instr(dept_id,'-')-1))
NOLOGGING
COMPUTE STATISTICS
/
