DEFINE vhtmlpage='dbinfo01_'
DEFINE vtitlethispage='Info of database'
DEFINE viconthispage='server.svg'
@rockdb/sql/headerhtmlspool.sql


PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO      google.charts.load('current', {'packages':['table']});
PRO      google.charts.setOnLoadCallback(drawTable);
PRO
PRO      function drawTable() {
PRO        var data = new google.visualization.DataTable();
PRO        data.addColumn('string', 'Description');;
PRO        data.addColumn('string', 'Properties');;
PRO        data.addRows([
SELECT decode(rownum,1,'[',',[') ||
       '''' ||label||'''' ||
       ','||'''' ||text||''''||
       ']' output
from (
SELECT   label, text FROM (
WITH
rac AS (SELECT /*+  MATERIALIZE NO_MERGE  */ COUNT(*) instances, CASE COUNT(*) WHEN 1 THEN 'Single-instance' ELSE COUNT(*)||'-node RAC cluster' END db_type FROM gv$instance),
mem AS (SELECT /*+  MATERIALIZE NO_MERGE  */ SUM(value) target FROM gv$system_parameter2 WHERE name = 'memory_target'),
sga AS (SELECT /*+  MATERIALIZE NO_MERGE  */ SUM(value) target FROM gv$system_parameter2 WHERE name = 'sga_target'),
pga AS (SELECT /*+  MATERIALIZE NO_MERGE  */ SUM(value) target FROM gv$system_parameter2 WHERE name = 'pga_aggregate_target'),
db_block AS (SELECT /*+  MATERIALIZE NO_MERGE  */ value bytes FROM v$system_parameter2 WHERE name = 'db_block_size'),
data AS (SELECT /*+  MATERIALIZE NO_MERGE  */ SUM(bytes) bytes, COUNT(*) files, COUNT(DISTINCT ts#) tablespaces FROM v$datafile),
temp AS (SELECT /*+  MATERIALIZE NO_MERGE  */ SUM(bytes) bytes FROM v$tempfile),
log AS (SELECT /*+  MATERIALIZE NO_MERGE  */ SUM(bytes) * MAX(members) bytes FROM v$log),
control AS (SELECT /*+  MATERIALIZE NO_MERGE  */ SUM(block_size * file_size_blks) bytes FROM v$controlfile),
 cell AS (SELECT /*+  MATERIALIZE NO_MERGE  */ COUNT(DISTINCT cell_name) cnt FROM v$cell_state),
core AS (SELECT /*+  MATERIALIZE NO_MERGE  */ SUM(value) cnt FROM gv$osstat WHERE stat_name = 'NUM_CPU_CORES'),
cpu AS (SELECT /*+  MATERIALIZE NO_MERGE  */ SUM(value) cnt FROM gv$osstat WHERE stat_name = 'NUM_CPUS'),
pmem AS (SELECT /*+  MATERIALIZE NO_MERGE  */ SUM(value) bytes FROM gv$osstat WHERE stat_name = 'PHYSICAL_MEMORY_BYTES'),
dbopen AS (select  d.force_logging,  d.db_unique_name,d.name, d.database_role,d.platform_name, d.open_mode, v.version db_version,
substr(p.value,1,15) db_compatible, v.status db_status, d.log_mode
from gv$database d, gv$instance v, gv$parameter p
where p.name = 'compatible'
and d.inst_id=v.inst_id and v.inst_id = p.inst_id),
inst AS (select  INSTANCE_ROLE,host_name,instance_name,   version db_version, status, to_char(startup_time,'DD-MON-YYYY HH24:MI ') Startuptime,logins
from v$instance a)
SELECT /*+  NO_MERGE  */
       'Database name:' label, name text FROM dbopen
UNION ALL
SELECT 'DB ROLE' ,database_role FROM dbopen
UNION all
SELECT 'DB status' ,db_status FROM dbopen
UNION all
SELECT 'Open Mode',open_mode FROM dbopen
UNION all
SELECT 'Version',db_version FROM dbopen
UNION all
SELECT 'Log mode',log_mode FROM dbopen
UNION all
SELECT 'Force Logging',force_logging FROM dbopen
UNION all
SELECT 'DB Unique Name',DB_UNIQUE_NAME FROM dbopen
UNION all
SELECT 'Login Allowed',logins FROM inst
UNION all
SELECT 'Instance Role',INSTANCE_ROLE FROM inst
UNION all
SELECT 'Host Name',host_name FROM inst
UNION all
SELECT 'Instance Name',instance_name FROM inst
UNION all
SELECT 'Startup time',Startuptime FROM inst
UNION all
&&varskip_11g_column SELECT 'Container ID', (SELECT TO_CHAR(con_id) FROM v$containers) FROM dual
&&varskip_11g_column UNION all
&&varskip_11g_column SELECT 'Container Name', (SELECT name FROM v$containers) FROM dual
&&varskip_11g_column UNION all
SELECT 'Logins', logins FROM inst
UNION all
&&varskip_11g_column  SELECT '    pdb:'||name, 'Open Mode:'||open_mode FROM v$pdbs -- need 12c flag
&&varskip_11g_column   UNION ALL
SELECT 'Oracle Database version:',  db_version FROM inst
 UNION ALL
SELECT 'Database block size:', TRIM(TO_CHAR(db_block.bytes / POWER(2,10), '90'))||' KB' FROM db_block
 UNION ALL
SELECT 'Database size:', TRIM(TO_CHAR(ROUND((data.bytes + temp.bytes + log.bytes + control.bytes) / POWER(10,12), 3), '999,999,990.000'))||' TB'
  FROM dbopen db, data, temp, log, control
 UNION ALL
SELECT 'Datafiles:', data.files||' (on '||data.tablespaces||' tablespaces)' FROM data
 UNION ALL
SELECT 'Database configuration:', rac.db_type FROM rac
 UNION ALL
SELECT 'Database memory:',
CASE WHEN mem.target > 0 THEN 'MEMORY '||TRIM(TO_CHAR(ROUND(mem.target / POWER(2,30), 1), '999,990.0'))||' GB, ' END||
CASE WHEN sga.target > 0 THEN 'SGA '   ||TRIM(TO_CHAR(ROUND(sga.target / POWER(2,30), 1), '999,990.0'))||' GB, ' END||
CASE WHEN pga.target > 0 THEN 'PGA '   ||TRIM(TO_CHAR(ROUND(pga.target / POWER(2,30), 1), '999,990.0'))||' GB, ' END||
CASE WHEN mem.target > 0 THEN 'AMM' ELSE CASE WHEN sga.target > 0 THEN 'ASMM' ELSE 'MANUAL' END END
  FROM mem, sga, pga
 UNION ALL
 SELECT 'Hardware:', CASE WHEN cell.cnt > 0 THEN 'Engineered System '||
 CASE WHEN 'Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz' LIKE '%5675%' THEN 'X2-2 ' END||
 CASE WHEN 'Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz' LIKE '%2690%' THEN 'X3-2 ' END||
 CASE WHEN 'Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz' LIKE '%2697%' THEN 'X4-2 ' END||
 CASE WHEN 'Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz' LIKE '%2699%' THEN 'X5-2 ' END||
 CASE WHEN 'Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz' LIKE '%8870%' THEN 'X3-8 ' END||
 CASE WHEN 'Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz' LIKE '%8895%' THEN 'X4-8 or X5-8 ' END||
 'with '||cell.cnt||' storage servers'
 ELSE 'Unknown' END FROM cell
  UNION ALL
SELECT 'Processor:', 'Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz' FROM DUAL
 UNION ALL
SELECT 'Physical CPUs:', core.cnt||' cores'||CASE WHEN rac.instances > 0 THEN ', on '||rac.db_type END FROM rac, core
 UNION ALL
SELECT 'Oracle CPUs:', cpu.cnt||' CPUs (threads)'||CASE WHEN rac.instances > 0 THEN ', on '||rac.db_type END FROM rac, cpu
 UNION ALL
SELECT 'Physical RAM:', TRIM(TO_CHAR(ROUND(pmem.bytes / POWER(2,30), 1), '999,990.0'))||' GB'||CASE WHEN rac.instances > 0 THEN ', on '||rac.db_type END FROM rac, pmem
 UNION ALL
SELECT 'Operating system:', db.platform_name FROM dbopen db
UNION all
SELECT 'Encrypted Tablespaces' lbl,  decode(total,0,'NO','YES') value
FROM (
SELECT count(*) total
FROM dba_tablespaces
WHERE encrypted ='YES'
)
UNION all
SELECT 'Encrypted Columns' lbl,  decode(total,0,'NO','YES') value
FROM (
SELECT count(*) total
FROM dba_encrypted_columns
)
UNION all
select 'Wallet' lbl, WRL_TYPE || ' '  || WRL_PARAMETER || ' Status '|| status value
FROM v$encryption_wallet
union all
SELECT  'Database Size' label,
ROUND((SUM(USED.BYTES) / 1024 / 1024/ 1024 ),2) || ' GB' status
FROM    (SELECT BYTES FROM V$DATAFILE
UNION ALL
SELECT BYTES FROM V$TEMPFILE
UNION ALL
SELECT BYTES FROM V$LOG) USED
)
)
/
PRO        ]);;
PRO
PRO        var table = new google.visualization.Table(document.getElementById('table_div01'));
PRO
PRO var formatColor = new google.visualization.ColorFormat();
PRO    formatColor.addRange('FAILED', 'FAILED ', 'white', 'red');
PRO    formatColor.addRange(1000, 1001, 'white', 'green');
PRO    formatColor.format(data, 1);
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
PRO
 PRO
 PRO +-------------------------------------------------------+
 PRO | Resource limit                                        |
 PRO +-------------------------------------------------------+
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
select 'alter system set '||name ||'='||  trim(value)/1024/1024 ||'M'||  ' scope=spfile;' label
from v$parameter
where name in ( 'sga_max_size','sga_target','memory_max_target','memory_target',
'pga_aggregate_target')
and  value <>'0'
union all
select 'alter system set '||name ||'='||  to_char(value)  ||''||  ' scope=spfile;'
from v$parameter where name in (
  'sessions','session_cached_cursors','open_cursors','open_links','undo_retention'
  ,'smtp_out_server','shared_pool_size'
  ,'resource_limit','optimizer_features_enable'
  ,'db_writer_processes')
  and value is not null
/
PRO
PRO </PRE>
PRO   </body>
PRO </html>

@rockdb/sql/footerhtml01
