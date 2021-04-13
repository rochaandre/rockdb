SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO &var_outputfolder/dbgauges10_&var_namefile

@rockdb/sql/headerdoc.sql &var_outputfolder/dbgauges_usedspace&var_namefile "Ued space" "" ""


PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="&var_outputfolder/charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO       google.charts.load('current', {'packages':['gauge']});
PRO       google.charts.setOnLoadCallback(drawChart);
PRO
PRO       function drawChart() {
PRO
PRO         var data = google.visualization.arrayToDataTable([
PRO           ['Label', 'Value'],
 

host free -g | grep Mem | awk '{print $2"']"}'

SELECT decode(rownum,1,'[',',[') ||
       '''' ||'Total GB'||'''' ||
       ','||mb_used||
       ']'output
from (
SELECT  D.mb_used,
SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_used,
D.mb_total - SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_free
FROM v$sort_segment A,
(SELECT c.con_id, B.name, C.block_size, SUM (C.bytes) / 1024 / 1024 mb_total
FROM v$tablespace B, v$tempfile C, cdb_tablespaces d
WHERE B.ts#= C.ts# (+)
AND b.name = d.tablespace_name
AND b.con_id = d.con_id
AND d.contents = 'TEMPORARY'
-- and b.name like 'TEMP%'
AND b.con_id = c.con_id
GROUP BY c.con_id, B.name, C.block_size) D,   v$containers cdb
WHERE A.tablespace_name (+) = D.name
AND a.con_id =  d.con_id
AND a.con_id = cdb.con_id
GROUP by  D.mb_total
)
/
PRO         ]);;
PRO
PRO         var options = {
PRO           width: 400, height: 200,
select        ' max:' ||total|| ','
 || ' redFrom: ' ||total*.85|| ','
 || ' redTo: ' ||total || ','
 || ' yellowFrom: ' ||total*.75|| ','
 || ' yellowTo: ' ||total*.85|| ','
FROM (
SELECT  D.mb_total total,
SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_used,
D.mb_total - SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_free
FROM v$sort_segment A,
(SELECT c.con_id, B.name, C.block_size, SUM (C.bytes) / 1024 / 1024 mb_total
FROM v$tablespace B, v$tempfile C, cdb_tablespaces d
WHERE B.ts#= C.ts# (+)
AND b.name = d.tablespace_name
AND b.con_id = d.con_id
AND d.contents = 'TEMPORARY'
-- and b.name like 'TEMP%'
AND b.con_id = c.con_id
GROUP BY c.con_id, B.name, C.block_size) D,   v$containers cdb
WHERE A.tablespace_name (+) = D.name
AND a.con_id =  d.con_id
AND a.con_id = cdb.con_id
GROUP by  D.mb_total
)
/
PRO           minorTicks: 5
PRO         };
PRO
PRO         var chart = new google.visualization.Gauge(document.getElementById('chart_div'));
PRO
PRO         chart.draw(data, options);
PRO         }
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <div id="chart_div" style="width: 200px; height: 200px;"></div>
PRO   </body>
PRO </html>
SPO OFF;
SET HEA ON LIN 80 NEWP 1 PAGES 14 FEED ON ECHO OFF VER ON LONG 80 LONGC 80 WRA ON TRIMS OFF TRIM OFF TI OFF TIMI OFF ARRAY 15 NUM 10 NUMF "" SQLBL OFF BLO ON RECSEP WR;
