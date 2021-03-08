select count(*)
from (select name from old union all select name from new);

