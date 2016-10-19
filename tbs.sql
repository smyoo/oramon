/***********************************************
<<Desciption>>
Check TABLESPACE usage

<<Usage>>
SQL> @tbs PART_OF_NAME
************************************************/

@env

define __tbs = &part_of_tablespace_name

select a.tablespace_name, a.mbytes "total(MB)", a.mbytes-b.mbytes "used(MB)", b.mbytes "free(MB)",
 case when b.mbytes/a.mbytes < 0.05 and b.mbytes/1024 < 2 then to_char(trunc(b.mbytes*100/a.mbytes,2))||' <-- Caution!!' else to_char(trunc(b.mbytes*100/a.mbytes,2))
 end as free_pct
from
(select nvl(tablespace_name,'[[Total]]') as tablespace_name, sum(bytes)/1024/1024 Mbytes from dba_data_files
where tablespace_name like upper('%&__tbs%')
group by rollup(tablespace_name)) A,
(select nvl(tablespace_name,'[[Total]]') as tablespace_name, sum(bytes)/1024/1024 Mbytes from dba_free_space
where tablespace_name like upper('%&__tbs%')
group by rollup(tablespace_name)) B
where a.tablespace_name=b.tablespace_name(+)
order by a.tablespace_name
/
