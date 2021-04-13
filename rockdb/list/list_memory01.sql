DEFINE vhtmlpage='list_memory01_'
DEFINE vtitlethispage='Memory configuration'
DEFINE viconthispage='segmented-nav.svg'
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
PRO        data.addColumn('string', 'inst_id');;
PRO        data.addColumn('string', 'Name');;
PRO        data.addColumn('string', 'Value GB');;
PRO        data.addRows([
  SELECT decode(rownum,1,'[',',[') ||
         ''''      ||inst_id||'''' ||
         ','||'''' ||name||''''||
         ','||'''' ||
         nvl(spfile_giga,'0'||spfile_mega)
         ||''''||
         ']' OUTPUT
  from (
    WITH
  system_parameter AS (
  SELECT inst_id,
         name,
         value
    FROM gv$system_parameter2
   WHERE name IN
  ( 'memory_max_target'
  , 'memory_target'
  , 'pga_aggregate_target'
  , 'sga_max_size'
  , 'sga_target'
  , 'db_cache_size'
  , 'shared_pool_size'
  , 'shared_pool_reserved_size'
  , 'large_pool_size'
  , 'java_pool_size'
  , 'streams_pool_size'
  , 'result_cache_max_size'
  , 'db_keep_cache_size'
  , 'db_recycle_cache_size'
  , 'db_32k_cache_size'
  , 'db_16k_cache_size'
  , 'db_8k_cache_size'
  , 'db_4k_cache_size'
  , 'db_2k_cache_size'
  )),
  spparameter_inst AS (
  SELECT i.inst_id,
         p.name,
         p.display_value
    FROM v$spparameter p,
         gv$instance i
   WHERE p.isspecified = 'TRUE'
     AND p.sid <> '*'
     AND i.instance_name = p.sid
  ),
  spparameter_all AS (
  SELECT p.name,
         p.display_value
    FROM v$spparameter p
   WHERE p.isspecified = 'TRUE'
     AND p.sid = '*'
  )
  SELECT s.name,
         s.inst_id,
         CASE WHEN i.name IS NOT NULL THEN TO_CHAR(i.inst_id) ELSE (CASE WHEN a.name IS NOT NULL THEN '*' END) END spfile_sid,
         NVL(i.display_value, a.display_value) spfile_value,
         substr(NVL(i.display_value, a.display_value), 1,instr(NVL(i.display_value, a.display_value),'M')-1)/1024 spfile_mega,
         substr(NVL(i.display_value, a.display_value), 1,instr(NVL(i.display_value, a.display_value),'G')-1) spfile_giga,
         CASE s.value WHEN '0' THEN '0' ELSE TRIM(TO_CHAR(ROUND(TO_NUMBER(s.value)/POWER(2,30),3),'9990.000'))||'G' END current_gb,
         NULL recommended_gb
    FROM system_parameter s,
         spparameter_inst i,
         spparameter_all  a
   WHERE i.inst_id(+) = s.inst_id
     AND i.name(+)    = s.name
     AND a.name(+)    = s.name
     AND  NVL(i.display_value, a.display_value) IS NOT null
   ORDER BY
         CASE s.name
         WHEN 'memory_max_target'         THEN  1
         WHEN 'memory_target'             THEN  2
         WHEN 'pga_aggregate_target'      THEN  3
         WHEN 'sga_max_size'              THEN  4
         WHEN 'sga_target'                THEN  5
         WHEN 'db_cache_size'             THEN  6
         WHEN 'shared_pool_size'          THEN  7
         WHEN 'shared_pool_reserved_size' THEN  8
         WHEN 'large_pool_size'           THEN  9
         WHEN 'java_pool_size'            THEN 10
         WHEN 'streams_pool_size'         THEN 11
         WHEN 'result_cache_max_size'     THEN 12
         WHEN 'db_keep_cache_size'        THEN 13
         WHEN 'db_recycle_cache_size'     THEN 14
         WHEN 'db_32k_cache_size'         THEN 15
         WHEN 'db_16k_cache_size'         THEN 16
         WHEN 'db_8k_cache_size'          THEN 17
         WHEN 'db_4k_cache_size'          THEN 18
         WHEN 'db_2k_cache_size'          THEN 19
         END,
         s.inst_id
  )
/
PRO        ]);;
PRO
PRO        var table = new google.visualization.Table(document.getElementById('table_divparam'));
PRO
PRO var formatColor = new google.visualization.ColorFormat();
PRO    formatColor.addRange('FAILED', 'FAILED ', 'white', 'red');
PRO    formatColor.addRange(1000000000000000000, 1000000000000000001, 'white', 'green');
PRO    formatColor.format(data, 1);
PRO        table.draw(data, {allowHtml: true, showRowNumber: false, width: '100%', height: '100%'});
PRO      }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>
PRO     <div id="table_divparam" style="width: 900px; height: 100%;"></div>

PRO <table>
PRO     <tbody>

PRO     <tr>
PRO     <td>
PRO       <iframe src="dbpie_shared_pool01_&var_namefile" height="380" width="450"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_large_pool01_&var_namefile" height="380" width="450"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     </tr>
PRO </table>
PRO     </tbody>
PRO     <p>&varhtmlspace</p>
PRO   </body>
PRO </html>
@report/sql/footerhtml01
