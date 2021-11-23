
set pages 999 
set lines 92


spool keep_syn.lst

drop table t1;

create table t1 as
select
   o.owner          owner,
   o.object_name    object_name,
   o.subobject_name subobject_name,
   o.object_type    object_type,
   count(distinct file# || block#)         num_blocks
from
   dba_objects  o,
   v$bh         bh
where
   o.data_object_id  = bh.objd
and
   o.owner not in ('SYS','SYSTEM')
and
   bh.status != 'free'
group by
   o.owner,
   o.object_name,
   o.subobject_name,
   o.object_type
order by
   count(distinct file# || block#) desc
;

select
   'alter '||s.segment_type||' '||t1.owner||'.'||s.segment_name||' storage (buffer_pool keep);'
from
   t1,
   dba_segments s
where
   s.segment_name = t1.object_name
and
   s.owner = t1.owner
and
   s.segment_type = t1.object_type
and
   nvl(s.partition_name,'-') = nvl(t1.subobject_name,'-')
and
   buffer_pool <> 'KEEP'
and
   object_type in ('TABLE','INDEX') 
group by
   s.segment_type,
   t1.owner,
   s.segment_name
having
   (sum(num_blocks)/greatest(sum(blocks), .001))*100 > 80
;


spool off;




alter TABLE BOM.BOM_DELETE_SUB_ENTITIES storage (buffer_pool keep);
alter TABLE BOM.BOM_OPERATIONAL_ROUTINGS storage (buffer_pool keep);
alter INDEX BOM.CST_ITEM_COSTS_U1 storage (buffer_pool keep);
alter TABLE APPLSYS.FND_CONCURRENT_PROGRAMS storage (buffer_pool keep);
alter TABLE APPLSYS.FND_CONCURRENT_REQUESTS storage (buffer_pool keep);
alter TABLE GL.GL_JE_BATCHES storage (buffer_pool keep);
alter INDEX GL.GL_JE_BATCHES_U2 storage (buffer_pool keep);
alter TABLE GL.GL_JE_HEADERS storage (buffer_pool keep);
alter TABLE INV.MTL_DEMAND_INTERFACE storage (buffer_pool keep);
alter INDEX INV.MTL_DEMAND_INTERFACE_N10 storage (buffer_pool keep);
alter TABLE INV.MTL_ITEM_CATEGORIES storage (buffer_pool keep);
alter TABLE INV.MTL_ONHAND_QUANTITIES storage (buffer_pool keep);
alter TABLE INV.MTL_SUPPLY_DEMAND_TEMP storage (buffer_pool keep);
alter TABLE PO.PO_REQUISITION_LINES_ALL storage (buffer_pool keep);
alter TABLE AR.RA_CUSTOMER_TRX_ALL storage (buffer_pool keep);
alter TABLE AR.RA_CUSTOMER_TRX_LINES_ALL storage (buffer_pool keep);
alter INDEX WIP.WIP_REQUIREMENT_OPERATIONS_N3 storage (buffer_pool keep);
