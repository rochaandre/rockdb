
SET LONG 20000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO &var_outputfolder/statistics_script_create01_&var_namefile..txt

@rockdb/sql/headertxt.sql "Create prepared statistics scripts" "&var_outputfolder/statistics_script_create01_&var_namefile..txt"

PRO
PRO Statistics
PRO
PRO set time on timing on
PRO EXEC DBMS_STATS.gather_dictionary_stats;
PRO EXEC DBMS_STATS.gather_database_stats(estimate_percent => 35, cascade => TRUE);
PRO exec dbms_stats.gather_fixed_objects_stats;
PRO exec dbms_stats.gather_system_stats('EXADATA');
PRO

PRO
PRO +------------------------------------------------------------------------------+
PRO |            STATISTICS                                                        |
PRO +------------------------------------------------------------------------------+
PRO
PRO col owner for a20
PRO col total for 9999999
PRO select owner, count(*) total from dba_tables group by owner
PRO /
PRO col coleta for a120
PRO select ' EXEC DBMS_STATS.GATHER_SCHEMA_STATS('||''''||OWNER||''''||', estimate_percent=> 10); ' coleta
PRO from dba_tables
PRO where owner in (select username from dba_users where username not in
PRO  ('SYS','SYSMAN','XS$NULL','ORACLE_OCM','APEX_PUBLIC_USER','DIP','DBAJOBS','SYSMAN','DBSNMP','SI_INFORMTN_SCHEMA',
PRO   'APEX_030200','APEX_040000','ORDPLUGINS','APPQOSSYS','XDB','WMSYS','EXFSYS','ANONYMOUS','CTXSYS','ORDSYS','ORDDATA','MDSYS',
PRO   'FLOWS_FILES','MGMT_VIEW','OUTLN','SH','OE','PM','BI','OLAPSYS','IX','SCOTT','HR','PM','OWBSYS','ORAINT','LBACSYS','APPQOSSYS',
PRO   'GSMCATUSER','MDDATA','DBSFWUSER','SYSBACKUP','REMOTE_SCHEDULER_AGENT','GGSYS','ANONYMOUS','GSMUSER','SYSRAC','CTXSYS',
PRO   'ORDS_PUBLIC_USER','OJVMSYS','DVF','SI_INFORMTN_SCHEMA','DVSYS','AUDSYS','C##DBAAS_BACKUP','GSMADMIN_INTERNAL','ORDPLUGINS',
PRO   'DIP','LBACSYS','MDSYS','OLAPSYS','ORDDATA','SYSKM','OUTLN','SYS$UMF','ORACLE_OCM','XDB','WMSYS','ORDSYS','SYSDG',
PRO   'PYQSYS','C##CLOUD$SERVICE','C##ADP$SERVICE','ORDS_METADATA','C##OMLIDM','OML$MODELS','ORDS_PLSQL_GATEWAY','APEX_200200',
PRO   'GRAPH$METADATA','C##CLOUD_OPS','SSB','C##API','OMLMOD$PROXY','C##DV_ACCT_ADMIN','APEX_INSTANCE_ADMIN_USER',
PRO   'RMAN$CATALOG','C##DV_OWNER','GRAPH$PROXY_USER','OML$PROXY')
PRO group by owner
PRO /
PRO
PRO -- calibrate_io
PRO
PRO DECLARE
PRO    v_max_iops         NUMBER;
PRO    v_max_mbps         NUMBER;
PRO    v_actual_latency   NUMBER;
PRO BEGIN
PRO    DBMS_RESOURCE_MANAGER.calibrate_io(
PRO         num_physical_disks => 132,
PRO         max_latency => 10,
PRO         max_iops => v_max_iops,
PRO         max_mbps => v_max_mbps,
PRO         actual_latency => v_actual_latency);
PRO    DBMS_OUTPUT.put_line('Max IOPS=' || v_max_iops);
PRO    DBMS_OUTPUT.put_line('Max MBps=' || v_max_mbps);
PRO    DBMS_OUTPUT.put_line('Latency =' || v_actual_latency);
PRO END;
PRO /


SPO OFF;
SET HEA ON LIN 80 NEWP 1 PAGES 14 FEED ON ECHO OFF VER ON LONG 80 LONGC 80 WRA ON TRIMS OFF TRIM OFF TI OFF TIMI OFF ARRAY 15 NUM 10 NUMF "" SQLBL OFF BLO ON RECSEP WR;
