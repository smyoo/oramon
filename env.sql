-- # common settings
set lines 300
set pages 100
set underline =
set verify off

-- # for tab.sql column format
col owner for a15
col table_name for a35
col tablespace_name for a35
col comments for a80
col size_mb for 999,999,999,999

-- # for tbs.sql column format
col tablespace_name for a35
col "total(MB)" for 999,999,999,999
col "used(MB)" for 999,999,999,999
col "free(MB)" for 999,999,999,999
col free_pct   for a20