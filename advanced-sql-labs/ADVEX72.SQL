select s.name,s.salary,'emp salary >',m.salary,m.name,m.dept
from staff s,staff m
where s.salary>m.salary AND m.dept=s.dept and m.job='MGR' 
/
