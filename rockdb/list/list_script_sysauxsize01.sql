DEFINE vhtmlpage='list_script_sysauxsize01_'
DEFINE vtitlethispage='Script check sysaux'
DEFINE viconthispage='card-list.svg'
@report/sql/headerhtmlspool.sql

PRO <PRE>

col SEGMENT_NAME for a30
col owner for a30

PRO
PRO +------------------------------------------------------------------------------+
PRO |            SYSAUX CHECK                                                      |
PRO +------------------------------------------------------------------------------+
PRO

select * from
(select owner,segment_name, segment_type,bytes/1024/1024/1024 G from dba_segments
where tablespace_name='SYSAUX'
order by bytes desc)
where rownum<=10;


PRO
PRO +------------------------------------------------------------------------------+
PRO |            Scripts to run with enteprise/permission                          |
PRO +------------------------------------------------------------------------------+
PRO

pro exec dbms_stats.purge_stats(sysdate-50);
pro select min(savtime) from wri$_optstat_histgrm_history;
PRO
PRO
pro set timing on
pro select name from v\$database;
pro exec dbms_stats.purge_stats(sysdate-35);
pro exec dbms_stats.purge_stats(sysdate-30);
pro
pro -- use this only if you have performance tunning option/license
pro select count(*) from wri$_optstat_histgrm_history;
pro
pro select dbms_stats.get_stats_history_retention from dual;
pro
pro run this only if you have performance tunning option:
pro
pro  @?/rdbms/admin/awrinfo.sql
PRO begin
PRO for i in reverse 31..100
PRO loop
PRO dbms_stats.purge_stats(sysdate-i);
PRO end loop;
PRO end;
PRO /

PRO </PRE>
PRO     <p>&varhtmlspace</p>


@report/sql/footerhtml01
