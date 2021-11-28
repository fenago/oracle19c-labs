select department_name, d.location_id, l.location_id, l.street_address
from departments d, locations l
where d.location_id = l.location_id and department_name like 'S%';
