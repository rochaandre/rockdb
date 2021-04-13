
SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO html/tablespace&2.html
PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="&var_outputfolder/charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO google.charts.load('current', {
PRO   packages: ['corechart', 'bar']
PRO });
PRO google.charts.setOnLoadCallback(drawStacked);
PRO
PRO      function drawTable() {
PRO        var data = new google.visualization.DataTable();
PRO        data.addColumn('string', 'Container');;
PRO        data.addColumn('string', 'tsname');;
PRO        data.addColumn('string', 'nfrags');;
PRO        data.addColumn('string', 'mxfrag');;
PRO        data.addColumn('string', 'totsiz');;
PRO        data.addColumn('string', 'avasiz');;
PRO        data.addColumn('string', 'pctusd');;
PRO        data.addRows([
alter session set NLS_NUMERIC_CHARACTERS = '.,'
/
SELECT decode(rownum,1,'[',',[') ||
       ''''|| name||'''' || ','||
       ''''|| tsname||'''' || ','||
       '''' ||nfrags||'''' ||','||
       '''' ||mxfrag||'''' ||','||
       '''' ||totsiz||'''' ||','||
       '''' ||avasiz||'''' ||','||
       '''' ||pctusd||'''' || ']'
from (
select
  c.name ,
  total.tablespace_name                       tsname,
  count(free.bytes)                           nfrags,
  nvl(max(free.bytes)/1024,0)                 mxfrag,
  total.bytes/1024                            totsiz,
  nvl(sum(free.bytes)/1024,0)                 avasiz,
  trunc((1-nvl(sum(free.bytes),0)/total.bytes)*100,2)  pctusd
from
  cdb_data_files  total,
  cdb_free_space  free ,
  v$containers c
where
    c.con_id = total.con_id
  and total.con_id = free.con_id(+)
  and total.tablespace_name = free.tablespace_name(+)
  and total.file_id=free.file_id(+)
group by c.name,
  total.tablespace_name,
  total.bytes
)
/
PRO ]);
PRO var options = {
select   ' title: '||'''' ||''||' Tablespaces - Espaco utilizado'||''''||','
from dual
/
--PRO     chartArea: {
--PRO       width: '45%',
--PRO      height:'100%'
--PRO     },
PRO     colors: ['red', 'green'],
PRO     isStacked: true,
PRO     hAxis: {
PRO       title: 'Container - &1',
PRO       minValue: 0,
PRO     },
PRO     vAxis: {
PRO       title: ''
PRO     }
PRO   };
PRO   var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
PRO   chart.draw(data, options);
PRO }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <div id="chart_div" style="width: 900px; height: 500px;"></div>
PRO   </body>
PRO </html>

@rockdb/sql/footerhtml01
