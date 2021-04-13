DEFINE vhtmlpage='script_stats_db01_'
DEFINE vtitlethispage='Script statistics'
DEFINE viconthispage='icon.gif'

@report/sql/headerhtmlspool.sql
@report/sql/page_label "&vtitlethispage"


PRO <PRE>
PRO
PRO set time on timing on
PRO execute DBMS_STATS.GATHER_DATABASE_STATS;;
PRO execute DBMS_STATS.GATHER_DICTIONARY_STATS;;
PRO execute DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;;
PRO
PRO
@report/sql/page_label "Individual SCHEMAS"
PRO
SELECT DISTINCT 'EXEC DBMS_STATS.GATHER_SCHEMA_STATS('||''''|| OWNER||''''||','||  'CASCADE=>TRUE'  || ');'
FROM dba_tables
where owner NOT IN
('SYS','SYSMAN','SYSTEM','GGUSER', 'XS$NULL','ORACLE_OCM','APEX_PUBLIC_USER','DIP','DBAJOBS','SYSMAN','DBSNMP','SI_INFORMTN_SCHEMA','APEX_030200','APEX_040000','ORDPLUGINS','APPQOSSYS','XDB','WMSYS','EXFSYS','ANONYMOUS','CTXSYS','ORDSYS','ORDDATA','MDSYS','FLOWS_FILES','MGMT_VIEW','OUTLN','SH','OE','PM','BI','OLAPSYS','IX','SCOTT','HR','PM','OWBSYS','ORAINT','LBACSYS','APPQOSSYS','GSMCATUSER','MDDATA','DBSFWUSER','SYSBACKUP','REMOTE_SCHEDULER_AGENT','GGSYS','ANONYMOUS','GSMUSER','SYSRAC','CTXSYS','ORDS_PUBLIC_USER','OJVMSYS',
'DV','SI_INFORMTN_SCHEMA','DVSYS','AUDSYS','C##DBAAS_BACKUP','GSMADMIN_INTERNAL','ORDPLUGINS','DIP','LBACSYS','MDSYS','OLAPSYS','ORDDATA','SYSKM','OUTLN','SYS$UMF','ORACLE_OCM','XDB','WMSYS','ORDSYS','SYSDG','PYQSYS','C##CLOUD$SERVICE','C##ADP$SERVICE','ORDS_METADATA','C##OMLIDM','OML$MODELS','ORDS_PLSQL_GATEWAY','APEX_200200','GRAPH$METADATA','C##CLOUD_OPS','SSB','C##API','OMLMOD$PROXY','C##DV_ACCT_ADMIN','APEX_INSTANCE_ADMIN_USER','RMAN$CATALOG','C##DV_OWNER','GRAPH$PROXY_USER','OML$PROXY'
,'APEX_190200','APEX_LISTENER','APEX_REST_PUBLIC_USER'
)
order by 1
/
PRO
PRO
PRO -- CALIBRATE I/O
PRO set serveroutput on
PRO set echo on
PRO DECLARE
PRO    v_max_iops         NUMBER;;
PRO    v_max_mbps         NUMBER;;
PRO    v_actual_latency   NUMBER;;
PRO BEGIN
PRO    DBMS_RESOURCE_MANAGER.calibrate_io(
PRO         num_physical_disks => 132,
PRO         max_latency => 10,
PRO         max_iops => v_max_iops,
PRO         max_mbps => v_max_mbps,
PRO         actual_latency => v_actual_latency);
PRO    DBMS_OUTPUT.put_line('Max IOPS=' || v_max_iops);
PRO    DBMS_OUTPUT.put_line('Max MBps=' || v_max_mbps);
PRO    DBMS_OUTPUT.put_line('Latency =' || v_actual_latency);;
PRO END;;
PRO /
PRO </PRE>
PRO


@report/sql/footerhtml01
