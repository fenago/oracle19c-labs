select (sum(decode(name,'sorts (memory)',value,0)) /
(sum(decode(name,'sorts (memory)',value,0)) +
sum (decode(name,'sorts (disk)', value,0)))) *100
memory_hit_ratio
from V$sysstat
where name like 'sort%'
/
