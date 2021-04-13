DEFINE vhtmlpage='donut__archiveperday_'
DEFINE vtitlethispage='Archives per day'
DEFINE viconthispage='archive.gif'
@rockdb/sql/headerhtmlspool.sql

@sql/headerloadjs.sql


PRO       google.charts.load("current", {packages:["corechart"]});
PRO       google.charts.setOnLoadCallback(drawChart);
PRO       function drawChart() {

PRO         var data = google.visualization.arrayToDataTable([
PRO           ['Task', 'Hours per Day'],
PRO           ['Work',     11],
PRO           ['Eat',      2],
PRO           ['Commute',  2],
PRO           ['Watch TV', 2],
PRO           ['Sleep',    7]
PRO         ]);


  PRO
  PRO         var options = {
  PRO           title: '&vhtmlpage',
  PRO           pieHole: 0.4,
  PRO         };
  PRO
  PRO         var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
  PRO         chart.draw(data, options);
  PRO       }
  PRO     </script>


SELECT decode(rownum,1,'[',',[') ||
        day  || ','||
        --thread#  ||','||
        Archives_Generated
       ||']'
from (
select to_char(COMPLETION_TIME,'DD') Day, thread#,
round(sum(BLOCKS*BLOCK_SIZE)/1024/1024/1024) GB,
count(*) Archives_Generated from v$archived_log
group by to_char(COMPLETION_TIME,'DD'),thread# order by 1
)
/
PRO ]);
PRO var options = {
--select   ' title: '||'''' ||''||' Tablespaces - Espaco utilizado'||''''||','
--from dual
--/
--PRO     chartArea: {
--PRO       width: '45%',
--PRO      height:'100%'
--PRO     },
PRO    title: 'Archives generated per day',
PRO     colors: ['red', 'green'],
PRO     isStacked: true,
PRO     hAxis: {
PRO       title: 'Archives',
PRO       minValue: 0
PRO     },
PRO     vAxis: {
PRO       title: ''
PRO     }
PRO   };
PRO      var chart = new google.visualization.LineChart(document.getElementById('chart_div'));;
PRO   chart.draw(data, options);;
PRO }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <div id="chart_div" style="width: 900px; height: 500px;"></div>
PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01




PRO
PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO   </head>
PRO   <body>
PRO     <div id="donutchart" style="width: 900px; height: 500px;"></div>
PRO   </body>
PRO </html>
PRO
