set echo off
alter session set workarea_size_policy=manual;
alter session set sort_area_size=50000;

alter system flush shared_pool;
alter system flush buffer_cache;