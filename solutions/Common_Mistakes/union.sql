--Execute as cm
select count(*)
from (select name from old union select name from new);

