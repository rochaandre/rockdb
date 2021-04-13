SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO &var_outputfolder/dbpie_shared_pool01_&var_namefile
@rockdb/sql/headerdoc.sql &var_outputfolder/dbpie_shared_pool01_&var_namefile "dbpie_shared_pool01_" "" ""

PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO      google.charts.load("current", {packages:["corechart"]});
PRO      google.charts.setOnLoadCallback(drawChart);
PRO      function drawChart() {
PRO        var data = google.visualization.arrayToDataTable([
PRO          ['Sga', 'GB']
SELECT ',[' ||''''|| name||'''' || ','||
       GB|| ']'
from (
select name , trunc(bytes/1024/1024) GB
from v$sgainfo
where name not in ( 'Maximum SGA Size','Free SGA Memory Available','Startup overhead in Shared Pool',
'Granule Size','Shared IO Pool Size','Data Transfer Cache Size')
)
/
PRO ]);
PRO
PRO         var options = {
PRO           title: 'Shared Pool',
PRO           is3D: true,
PRO         };
PRO
PRO         var chart = new google.visualization.PieChart(document.getElementById('piechart'));
PRO         chart.draw(data, options);
PRO       }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <div id="piechart" style="width: 450px; height: 450px;"></div>
PRO   </body>
PRO </html>
SPO OFF;
SET HEA ON LIN 80 NEWP 1 PAGES 14 FEED ON ECHO OFF VER ON LONG 80 LONGC 80 WRA ON TRIMS OFF TRIM OFF TI OFF TIMI OFF ARRAY 15 NUM 10 NUMF "" SQLBL OFF BLO ON RECSEP WR;
