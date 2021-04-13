DEFINE vhtmlpage='bar_archiveperday_'
DEFINE vtitlethispage='Archives per day'
DEFINE viconthispage='archive.svg'
@rockdb/sql/headerhtmlspool.sql

@rockdb/sql/headerloadjs.sql


PRO     google.charts.load('current', {
PRO   packages: ['corechart', 'bar']
PRO });
PRO google.charts.load('current', {packages: ['corechart', 'line']});
PRO google.charts.setOnLoadCallback(drawBackgroundColor);
PRO function drawBackgroundColor() {
PRO       var data = new google.visualization.DataTable();
PRO       data.addColumn('number', 'DIA');
PRO       data.addColumn('number', 'Log');
PRO       data.addRows([

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
