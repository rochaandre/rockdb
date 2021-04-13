
SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO &var_outputfolder/dbgauge_outstandingalerts_&var_namefile

@rockdb/sql/headerdoc.sql &var_outputfolder/dbgauge_usedspace&var_namefile "outstandingalert" "outstandingalert" "outstandingalert"

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

SELECT decode(rownum,1,'[',',[') ||
       '''' ||'OustandAlerts'||'''' ||
       ','||total||
       ']'output
from (
SELECT  count(*) total
from dba_outstanding_alerts
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
  SELECT decode(count(*),0,20  ,count(*)-20) total
  from dba_outstanding_alerts
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
