DEFINE vhtmlpage='list_checklist_'
DEFINE vtitlethispage='Check list'
DEFINE viconthispage='check.svg'
@report/sql/headerhtmlspool.sql


PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO      google.charts.load('current', {'packages':['table']});
PRO      google.charts.setOnLoadCallback(drawTable);
PRO
PRO      function drawTable() {
PRO        var data = new google.visualization.DataTable();
PRO        data.addColumn('string', 'Description');;
PRO        data.addColumn('string', 'Value');;
PRO        data.addColumn('string', 'Alert');;
PRO        data.addColumn('string', 'Message');;
PRO        data.addRows([


  SELECT decode(rownum,1,'[',',[') ||
        '''' ||label||'''' ||
        ','||'''' ||value||''''||
        ','||'''' ||alert||''''||
        ','||'''' ||COMM||''''||
        ']' output
 from (
 SELECT   *  FROM (
   WITH
   alert_tbsdt AS (SELECT LOGGING,COMPRESS_FOR,ENCRYPTED FROM DBA_TABLESPACES ),
   alert_tbsnol AS (select 'Tablespace NOLOGGING' label, LOGGING value  , decode(LOGGING,'NOLOGGING','TRUE','TRUE')   alert,
   'Tablespace NOLOGGING was set' comm  from alert_tbsdt where  LOGGING='NOLOGGING'  AND rownum<=1),
   alert_tbscom AS (select 'Tablespace COMPRESS' label, COMPRESS_FOR value  ,  nvl(COMPRESS_FOR,'FALSE')  alert,
   'Tablespace was compressed' comm  from alert_tbsdt where  COMPRESS_FOR IS NOT NULL AND rownum<=1),
   alert_tbsENC AS (select 'Tablespace ENCRYPTED' label, ENCRYPTED value ,  decode(ENCRYPTED,'NO','FALSE','TRUE')  alert,
   'Tablespace was ENCRYPTED' comm  from alert_tbsdt where  COMPRESS_FOR IS NOT NULL AND rownum<=1),
   alert_aclli AS (    select ' Total ACL in this database..: '  label, to_char(total_acl) value, 'FALSE' alert, '' comm from (SELECT count(*) total_acl FROM   dba_network_acls a JOIN dba_network_acl_privileges b ON a.acl = b.acl)),
   alert_invobj AS (    select ' Total invalid objects..: '  label, to_char(total) value, decode( to_char(total),'0','FALSE','TRUE')  alert, '' comm from ( select count(*) total from dba_invalid_objects where owner NOT IN
   ('SYS','SYSMAN','SYSTEM','GGUSER', 'XS$NULL','ORACLE_OCM','APEX_PUBLIC_USER','DIP','DBAJOBS','SYSMAN','DBSNMP','SI_INFORMTN_SCHEMA','APEX_030200','APEX_040000','ORDPLUGINS','APPQOSSYS','XDB','WMSYS','EXFSYS','ANONYMOUS','CTXSYS','ORDSYS','ORDDATA','MDSYS','FLOWS_FILES','MGMT_VIEW','OUTLN','SH','OE','PM','BI','OLAPSYS','IX','SCOTT','HR','PM','OWBSYS','ORAINT','LBACSYS','APPQOSSYS','GSMCATUSER','MDDATA','DBSFWUSER','SYSBACKUP','REMOTE_SCHEDULER_AGENT','GGSYS','ANONYMOUS','GSMUSER','SYSRAC','CTXSYS','ORDS_PUBLIC_USER','OJVMSYS',
    'DV','SI_INFORMTN_SCHEMA','DVSYS','AUDSYS','C##DBAAS_BACKUP','GSMADMIN_INTERNAL','ORDPLUGINS','DIP','LBACSYS','MDSYS','OLAPSYS','ORDDATA','SYSKM','OUTLN','SYS$UMF','ORACLE_OCM','XDB','WMSYS','ORDSYS','SYSDG','PYQSYS','C##CLOUD$SERVICE','C##ADP$SERVICE','ORDS_METADATA','C##OMLIDM','OML$MODELS','ORDS_PLSQL_GATEWAY','APEX_200200','GRAPH$METADATA','C##CLOUD_OPS','SSB','C##API','OMLMOD$PROXY','C##DV_ACCT_ADMIN','APEX_INSTANCE_ADMIN_USER','RMAN$CATALOG','C##DV_OWNER','GRAPH$PROXY_USER','OML$PROXY')     )),
    alert_vdata AS (select  * FROM v$database),
    alert_vinst AS (select  * FROM v$instance),
   alert_vparm AS (select name label, value FROM v$parameter where isdefault = 'FALSE' ),
   alert_audit AS (select label, value  , decode(value,'NONE','FALSE','TRUE') alert, 'Auditing set check audit rules' comm from alert_vparm where  label='audit_trail'),
   alert_dguar AS (select label, value  , value alert, 'Dataguard set - cannot be used dbclone or pdbclone' comm  from alert_vparm where  label='dg_broker_start'),
   alert_ddllg AS (select label, value  , value alert, 'DDL logging was set' comm from alert_vparm where label='enable_ddl_logging'),
   alert_ggate AS (select label, value  , value alert, 'Golden gate in use' comm from alert_vparm where label='enable_goldengate_replication'),
   alert_block AS (select label, value  , decode(value,'8192','FALSE','TRUE') alert, 'db_block_size greater than 8192' comm from alert_vparm where label='db_block_size'),
   alert_ccach AS (select label, value  , decode(value,'50','FALSE','TRUE') alert, 'Cache Cursor was set superior than default' comm from alert_vparm where label='session_cached_cursors'),
   alert_secca AS (select label, value  , decode(value,'FALSE','FALSE','TRUE') alert, 'Case sensitive logon is set' comm from alert_vparm where label='sec_case_sensitive_logon'),
   alert_recyc AS (select label, value  , decode(value,'OFF','TRUE','FALSE') alert, 'recyclebin is off' comm from alert_vparm where label='recyclebin'),
   alert_ocurs AS (select label, value  , decode(value,'50','TRUE','FALSE')  alert, 'open_cursors is not default' comm from alert_vparm where label='open_cursors'),
   alert_invix AS (select label, value  , decode(value,'TRUE','TRUE','FALSE')  alert, 'Invisible index is set' comm from alert_vparm where label='optimizer_use_invisible_indexes'),
   alert_undor AS (select label, value  ,  decode(value,'900','TRUE','FALSE') alert, 'Undo retention was set high' comm from alert_vparm where label='undo_retention'),
   alert_compa AS (select label, value  , decode(value,(select  value FROM v$parameter WHERE name='optimizer_features_enable'),'FALSE','TRUE') alert , 'Optimizer was set different from Compatible' comm FROM alert_vparm where  label =  'compatible' ),
   alert_cursh AS (select label, value  , decode(value,'EXACT','FALSE','TRUE') alert, 'Cursor sharing - non default !' comm from alert_vparm where label='cursor_sharing'),
   alert_redot AS (select label, value , decode(value,NULL,'FALSE','TRUE') alert, 'redo_transport_user in use' comm from alert_vparm where label='redo_transport_user'),
   alert_ddlti AS (select label, value  ,  decode(value,'0','FALSE','TRUE') alert, 'ddl_lock_timeout was set' comm from alert_vparm where label='ddl_lock_timeout'),
   alert_ammta AS (select label, value  ,  decode(value,'0','FALSE','TRUE') alert, 'memory_max_target was set' comm from alert_vparm where label='memory_max_target'),
   alert_opmod AS (select label, value  ,  decode(value,'ALL_ROWS','FALSE','TRUE') alert, 'optimizer_mode non default' comm from alert_vparm where label='optimizer_mode'),
   alert_rlimi AS (select label, value  ,  decode(value,'TRUE','FALSE','TRUE') alert, 'resource_limit was non default' comm from alert_vparm where label='resource_limit'),
   alert_cdbin AS (select label, value  ,   value alert, 'enable_pluggable_database is TRUE' comm from alert_vparm where label='enable_pluggable_database'),
   alert_smtpe AS (select label, value  ,  decode(value,NULL,'FALSE','TRUE') alert, 'smtp_out_server was set' comm from alert_vparm where label='smtp_out_server'),
   alert_ploca AS (select label, value  ,  value  alert, 'parallel_force_local was non default' comm from alert_vparm where label='parallel_force_local'),
   alert_stata AS (select label, value  ,  value  alert, 'optimizer_adaptive_statistics was non default' comm from alert_vparm where label='optimizer_adaptive_statistics'),
   alert_osaut AS (select label, value  ,  decode(value,NULL,'FALSE','TRUE')   alert, 'os_authent_prefix was non default' comm from alert_vparm where label='os_authent_prefix'),
   alert_stare AS (select label, value  ,   value alert, 'star_transformation_enabled was set' comm from alert_vparm where label='star_transformation_enabled'),
   alert_destl AS (select label, value  , value alert, 'Dataguard set - cannot be used dbclone or pdbclone' comm from alert_vparm where label='log_archive_dest_state_2'),
   alert_dbdet AS (
   SELECT 'Force logging' label, force_logging value, decode(force_logging,'YES','TRUE','FALSE') alert, '' comm  FROM alert_vdata
   UNION all
   SELECT 'DB ID' label, to_char(dbid) value, to_char(dbid) aler, '' comm  FROM alert_vdata
   UNION all
   SELECT 'Log mode' label, log_mode value,  decode(log_mode,'NOARCHIVELOG','TRUE','FALSE')  aler, '' comm  FROM alert_vdata
   UNION all
   SELECT 'Open Mode' label, open_mode value, 'FALSE' aler, '' comm  FROM alert_vdata
   UNION all
   SELECT 'DB Unique' label, DB_UNIQUE_NAME value, 'FALSE' aler, '' comm  FROM alert_vdata
   UNION all
   SELECT 'Login allowed' label, logins value, decode(logins,'ALLOWED', 'FALSE','TRUE') alert, '' comm  FROM alert_vinst
   UNION all
   SELECT 'Instance Role' label, INSTANCE_ROLE value, decode(INSTANCE_ROLE,'PRIMARY_INSTANCE', 'FALSE','TRUE') alert, '' comm  FROM alert_vinst),
   alert_reidx AS (
   select
      CASE
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) > 0.75 THEN  'PRO VALUE ABOVE 0.75'
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) between 0.5 AND 0.75  THEN  'PRO VALUE BETWEEN 0.5 AND 0.75'
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) <0.5  THEN  'PRO VALUE LOWER THAN 0.5'
      END label,
      to_char(count(*)) value,
      CASE
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) > 0.75 THEN  'FALSE'
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) between 0.5 AND 0.75  THEN  'TRUE'
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) <0.5  THEN  'TRUE'
      END alert,
      CASE
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) > 0.75 THEN  'DOES NOT REQUIRE REORG'
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) between 0.5 AND 0.75  THEN  'REORG IS RECOMMENDED'
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) <0.5  THEN  'IT IS HIGHLY RECOMMENDED TO REORG'
      END comm
     FROM dba_indexes di, dba_tables dt, dba_constraints dc
    WHERE di.table_name = dt.table_name
      AND dt.table_name = dc.table_name
      AND di.index_name = dc.index_name
      AND di.owner = dc.OWNER
      AND dt.OWNER = dc.OWNER
      AND dc.CONSTRAINT_TYPE = 'P'
      AND  dt.blocks >0
      AND di.clustering_factor>0
     GROUP BY
     CASE
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) > 0.75 THEN  'PRO VALUE ABOVE 0.75'
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) between 0.5 AND 0.75  THEN  'PRO VALUE BETWEEN 0.5 AND 0.75'
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) <0.5  THEN  'PRO VALUE LOWER THAN 0.5'
      END ,
      CASE
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) > 0.75 THEN  'FALSE'
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) between 0.5 AND 0.75  THEN  'TRUE'
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) <0.5  THEN  'TRUE'
      END ,
      CASE
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) > 0.75 THEN  'DOES NOT REQUIRE REORG'
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) between 0.5 AND 0.75  THEN  'REORG IS RECOMMENDED'
       WHEN  trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) <0.5  THEN  'IT IS HIGHLY RECOMMENDED TO REORG'
      END  ),
   alert_chits AS (
     select 'cursor_cache_hits '|| to_char(100 * sess / calls, '999999999990.00') || '%' label,
        'soft parse '||to_char(100 * (calls - sess - hard) / calls, '999990.00') || '%' value,
       'hard parse '|| to_char(100 * hard / calls, '999990.00') || '%' alert, to_char(NULL) comm
       from   (select value calls from v$sysstat where name = 'parse count (total)'),
       (select value hard  from v$sysstat where name = 'parse count (hard)'),
       (select value sess  from v$sysstat where name = 'session cursor cache hits')
    ),
   alert_curso AS (
   SELECT PARAMETER label, value, USAGE alert, NULL comm
   FROM (
   select 'session_cached_cursors in use'  parameter,lpad(value, 10)  value, decode(value, 0, '  n/a', to_char(100 * used / value, '999990') || '%')  usage
   from   (select max(s.value)  used
   from   v$statname  n,v$sesstat  s
   where  n.name = 'session cursor cache count'
   and    s.statistic# = n.statistic#),
   (select value from   v$parameter where  name = 'session_cached_cursors')
   union all
   select 'open_cursors in use',lpad(value, 10),to_char(100 * used / value,  '99990') || '%'
   from   (select max(sum(s.value))  used
   from   v$statname  n,
   v$sesstat  s
   where  n.name in ('opened cursors current', 'session cursor cache count')
   and    s.statistic# = n.statistic#
   group by s.sid),
   (select value from   v$parameter where  name = 'open_cursors'))
   )
   SELECT label, value, alert , COMM FROM alert_audit UNION ALL
   SELECT label, value, alert , COMM FROM alert_dguar UNION ALL
   SELECT label, value, alert , COMM FROM alert_ddllg UNION ALL
   SELECT label, value, alert , COMM FROM alert_ggate UNION ALL
   SELECT label, value, alert , COMM FROM alert_block UNION ALL
   SELECT label, value, alert , COMM FROM alert_ccach UNION ALL
   SELECT label, value, alert , COMM FROM alert_secca UNION ALL
   SELECT label, value, alert , COMM FROM alert_recyc UNION ALL
   SELECT label, value, alert , COMM FROM alert_ocurs UNION ALL
   SELECT label, value, alert , COMM FROM alert_invix UNION ALL
   SELECT label, value, alert , COMM FROM alert_undor UNION ALL
   SELECT label, value, alert , COMM FROM alert_compa UNION ALL
   SELECT label, value, alert , COMM FROM alert_cursh UNION ALL
   SELECT label, value, alert , COMM FROM alert_redot UNION ALL
   SELECT label, value, alert , COMM FROM alert_ddlti UNION ALL
   SELECT label, value, alert , COMM FROM alert_ammta UNION ALL
   SELECT label, value, alert , COMM FROM alert_opmod UNION ALL
   SELECT label, value, alert , COMM FROM alert_rlimi UNION ALL
   SELECT label, value, alert , COMM FROM alert_cdbin UNION ALL
   SELECT label, value, alert , COMM FROM alert_smtpe UNION ALL
   SELECT label, value, alert , COMM FROM alert_ploca UNION ALL
   SELECT label, value, alert , COMM FROM alert_stata UNION ALL
   SELECT label, value, alert , COMM FROM alert_invobj UNION ALL
   SELECT label, value, alert , COMM FROM alert_tbsnol UNION ALL
   SELECT label, value, alert , COMM FROM alert_tbscom UNION ALL
   SELECT label, value, alert , COMM FROM alert_tbsenc UNION ALL
   SELECT label, value, alert , COMM FROM alert_osaut
    UNION ALL
   SELECT label, value, alert , COMM FROM alert_stare
  UNION ALL
  SELECT label, value, alert , COMM FROM alert_reidx
   UNION ALL
    SELECT label, value, alert , COMM FROM alert_chits
    union all
  SELECT label, value, alert , COMM FROM  alert_curso
  UNION ALL
  SELECT label, value, alert , COMM FROM alert_dbdet
  UNION ALL
  SELECT label, value, alert , COMM FROM alert_aclli
 )
 )
/
PRO        ]);;
PRO
PRO        var table = new google.visualization.Table(document.getElementById('table_div01'));
PRO
PRO var formatColor = new google.visualization.ColorFormat();
PRO    formatColor.addRange('TRUE', 'TRUE ', 'white', 'red');
PRO    formatColor.addRange(1000, 1001, 'white', 'green');
PRO    formatColor.format(data, 2);
PRO        table.draw(data, {allowHtml: true, showRowNumber: false, width: '100%', height: '100%'});
PRO      }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>
PRO     <div id="table_div01" style="width: 900px; height: 750px;"></div>
PRO     <p>&varhtmlspace</p>
PRO <PRE>
PRO -- Parameter to be set
SELECT  'alter system set '||label||'='|| '''' ||  trim(value) || '''' ||' scope=spfile;'
        value
 from (
 SELECT   *  FROM (
   WITH
   alert_tbsdt AS (SELECT LOGGING,COMPRESS_FOR,ENCRYPTED FROM DBA_TABLESPACES ),
   alert_vdata AS (select  * FROM v$database),
   alert_vinst AS (select  * FROM v$instance),
   alert_vparm AS (select name label, value FROM v$parameter where isdefault = 'FALSE' ),
   alert_audit AS (select label, value  , decode(value,'NONE','FALSE','TRUE') alert, 'Auditing set check audit rules' comm from alert_vparm where  label='audit_trail'),
   alert_dguar AS (select label, value  , value alert, 'Dataguard set - cannot be used dbclone or pdbclone' comm  from alert_vparm where  label='dg_broker_start'),
   alert_ddllg AS (select label, value  , value alert, 'DDL logging was set' comm from alert_vparm where label='enable_ddl_logging'),
   alert_ggate AS (select label, value  , value alert, 'Golden gate in use' comm from alert_vparm where label='enable_goldengate_replication'),
   alert_block AS (select label, value  , decode(value,'8192','FALSE','TRUE') alert, 'db_block_size greater than 8192' comm from alert_vparm where label='db_block_size'),
   alert_ccach AS (select label, value  , decode(value,'50','FALSE','TRUE') alert, 'Cache Cursor was set superior than default' comm from alert_vparm where label='session_cached_cursors'),
   alert_secca AS (select label, value  , decode(value,'FALSE','FALSE','TRUE') alert, 'Case sensitive logon is set' comm from alert_vparm where label='sec_case_sensitive_logon'),
   alert_recyc AS (select label, value  , decode(value,'OFF','TRUE','FALSE') alert, 'recyclebin is off' comm from alert_vparm where label='recyclebin'),
   alert_ocurs AS (select label, value  , decode(value,'50','TRUE','FALSE')  alert, 'open_cursors is not default' comm from alert_vparm where label='open_cursors'),
   alert_invix AS (select label, value  , decode(value,'TRUE','TRUE','FALSE')  alert, 'Invisible index is set' comm from alert_vparm where label='optimizer_use_invisible_indexes'),
   alert_undor AS (select label, value  ,  decode(value,'900','TRUE','FALSE') alert, 'Undo retention was set high' comm from alert_vparm where label='undo_retention'),
   alert_cursh AS (select label, value  , decode(value,'EXACT','FALSE','TRUE') alert, 'Cursor sharing - non default !' comm from alert_vparm where label='cursor_sharing'),
   alert_redot AS (select label, value , decode(value,NULL,'FALSE','TRUE') alert, 'redo_transport_user in use' comm from alert_vparm where label='redo_transport_user'),
   alert_ddlti AS (select label, value  ,  decode(value,'0','FALSE','TRUE') alert, 'ddl_lock_timeout was set' comm from alert_vparm where label='ddl_lock_timeout'),
   alert_ammta AS (select label, value  ,  decode(value,'0','FALSE','TRUE') alert, 'memory_max_target was set' comm from alert_vparm where label='memory_max_target'),
   alert_opmod AS (select label, value  ,  decode(value,'ALL_ROWS','FALSE','TRUE') alert, 'optimizer_mode non default' comm from alert_vparm where label='optimizer_mode'),
   alert_rlimi AS (select label, value  ,  decode(value,'TRUE','FALSE','TRUE') alert, 'resource_limit was non default' comm from alert_vparm where label='resource_limit'),
   alert_cdbin AS (select label, value  ,   value alert, 'enable_pluggable_database is TRUE' comm from alert_vparm where label='enable_pluggable_database'),
   alert_smtpe AS (select label, value  ,  decode(value,NULL,'FALSE','TRUE') alert, 'smtp_out_server was set' comm from alert_vparm where label='smtp_out_server'),
   alert_ploca AS (select label, value  ,  value  alert, 'parallel_force_local was non default' comm from alert_vparm where label='parallel_force_local'),
   alert_stata AS (select label, value  ,  value  alert, 'optimizer_adaptive_statistics was non default' comm from alert_vparm where label='optimizer_adaptive_statistics'),
   alert_osaut AS (select label, value  ,  decode(value,NULL,'FALSE','TRUE')   alert, 'os_authent_prefix was non default' comm from alert_vparm where label='os_authent_prefix'),
   alert_stare AS (select label, value  ,   value alert, 'star_transformation_enabled was set' comm from alert_vparm where label='star_transformation_enabled'),
   alert_destl AS (select label, value  , value alert, 'Dataguard set - cannot be used dbclone or pdbclone' comm from alert_vparm where label='log_archive_dest_state_2'),
   alert_chits AS (
     select 'cursor_cache_hits '|| to_char(100 * sess / calls, '999999999990.00') || '%' label,
        'soft parse '||to_char(100 * (calls - sess - hard) / calls, '999990.00') || '%' value,
       'hard parse '|| to_char(100 * hard / calls, '999990.00') || '%' alert, to_char(NULL) comm
       from   (select value calls from v$sysstat where name = 'parse count (total)'),
       (select value hard  from v$sysstat where name = 'parse count (hard)'),
       (select value sess  from v$sysstat where name = 'session cursor cache hits')
    ),
   alert_curso AS (
   SELECT PARAMETER label, value, USAGE alert, NULL comm
   FROM (
   select 'session_cached_cursors in use'  parameter,lpad(value, 10)  value, decode(value, 0, '  n/a', to_char(100 * used / value, '999990') || '%')  usage
   from   (select max(s.value)  used
   from   v$statname  n,v$sesstat  s
   where  n.name = 'session cursor cache count'
   and    s.statistic# = n.statistic#),
   (select value from   v$parameter where  name = 'session_cached_cursors')
   union all
   select 'open_cursors in use',lpad(value, 10),to_char(100 * used / value,  '99990') || '%'
   from   (select max(sum(s.value))  used
   from   v$statname  n,
   v$sesstat  s
   where  n.name in ('opened cursors current', 'session cursor cache count')
   and    s.statistic# = n.statistic#
   group by s.sid),
   (select value from   v$parameter where  name = 'open_cursors'))
   )
   SELECT label, value, alert , COMM FROM alert_audit UNION ALL
   SELECT label, value, alert , COMM FROM alert_dguar UNION ALL
   SELECT label, value, alert , COMM FROM alert_ddllg UNION ALL
   SELECT label, value, alert , COMM FROM alert_ggate UNION ALL
   SELECT label, value, alert , COMM FROM alert_block UNION ALL
   SELECT label, value, alert , COMM FROM alert_ccach UNION ALL
   SELECT label, value, alert , COMM FROM alert_secca UNION ALL
   SELECT label, value, alert , COMM FROM alert_recyc UNION ALL
   SELECT label, value, alert , COMM FROM alert_ocurs UNION ALL
   SELECT label, value, alert , COMM FROM alert_invix UNION ALL
   SELECT label, value, alert , COMM FROM alert_undor UNION ALL
   SELECT label, value, alert , COMM FROM alert_cursh UNION ALL
   SELECT label, value, alert , COMM FROM alert_redot UNION ALL
   SELECT label, value, alert , COMM FROM alert_ddlti UNION ALL
   SELECT label, value, alert , COMM FROM alert_ammta UNION ALL
   SELECT label, value, alert , COMM FROM alert_opmod UNION ALL
   SELECT label, value, alert , COMM FROM alert_rlimi UNION ALL
   SELECT label, value, alert , COMM FROM alert_cdbin UNION ALL
   SELECT label, value, alert , COMM FROM alert_smtpe UNION ALL
   SELECT label, value, alert , COMM FROM alert_ploca UNION ALL
   SELECT label, value, alert , COMM FROM alert_stata UNION ALL
   SELECT label, value, alert , COMM FROM alert_osaut
    UNION ALL
   SELECT label, value, alert , COMM FROM alert_stare
    union all
  SELECT label, value, alert , COMM FROM  alert_curso
 )
 )
 /
PRO
PRO -- Max resource used
PRO
   SELECT  'alter system set '||label||'='|| '''' ||  trim(value) || '''' ||' scope=spfile;'
        value
 from (
  select RESOURCE_NAME label, MAX_UTILIZATION value
  from v$resource_limit
  WHERE max_utilization >0
  AND CURRENT_UTILIZATION >0
  ORDER BY 2
  )
/
PRO </PRE>
PRO     <p>&varhtmlspace</p>

PRO   </body>
PRO </html>
@report/sql/footerhtml01
