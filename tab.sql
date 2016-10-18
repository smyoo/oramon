/***********************************************
List up TABLE information
- input param 1 : table name
************************************************/

@env

define _t_name = &_table_name

select a.TABLE_NAME, a.OWNER, a.TABLESPACE_NAME, a.IOT_TYPE, a.LOGGING, a.DEGREE, a.PARTITIONED, a.COMPRESSION, seg.bytes/1024/1024 as size_mb, tc.comments
from dba_tables a, dba_tab_comments tc,
     (select owner, segment_name, sum(bytes) as bytes
      from dba_segments
      where segment_name like '%'||upper('&_t_name')||'%' and segment_type like 'TABLE%'
      group by owner, segment_name
      ) seg
where a.owner=tc.owner(+) and a.table_name=tc.table_name(+)
and a.owner=seg.owner(+) and a.table_name=seg.segment_name(+)
and a.table_name like '%'||upper('&_t_name')||'%'
order by a.TABLE_NAME, a.OWNER
/
