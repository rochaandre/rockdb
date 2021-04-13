DEFINE vhtmlpage='dbperf_cpu_topquery_'
DEFINE vtitlethispage='Cpu top query'
DEFINE viconthispage='cpu.svg'
@rockdb/sql/headerhtmlspool.sql

PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="&var_outputfolder/charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO      google.charts.load('current', {'packages':['table']});
PRO      google.charts.setOnLoadCallback(drawTable);
PRO
PRO      function drawTable() {
PRO        var data = new google.visualization.DataTable();
PRO        data.addColumn('string', 'Sid');;
PRO        data.addColumn('string', 'serial');;
PRO        data.addColumn('string', 'Event');;
PRO        data.addColumn('string', 'Seconds');;
PRO        data.addColumn('string', 'SQL text');;
PRO        data.addRows([
alter session set NLS_NUMERIC_CHARACTERS = '.,'
/
SELECT decode(rownum,1,'[',',[') ||
       '''' ||rank||'''' ||
       ','||'''' ||sid||''''||
       ','||'''' ||serial||''''||
       ','||'''' ||program||''''||
       ','||'''' ||CPUMins||''''||
       ']' output
from (
select rownum as rank, a.*
from (
SELECT v.sid,sess.Serial# serial,program, trunc(v.value / (100 * 60),3) CPUMins
FROM v$statname s , v$sesstat v, v$session sess
WHERE s.name = 'CPU used by this session'
and sess.sid = v.sid
and v.statistic#=s.statistic#
and v.value>0
ORDER BY v.value DESC) a
where rownum < 11
)
/
/* https://smarttechways.com/2021/02/24/find-top-cpu-consuming-session-or-sqls-query-in-oracle/ */
PRO        ]);;
PRO
PRO        var table = new google.visualization.Table(document.getElementById('table_div'));
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

PRO     <div id="table_div" style="width: 1000px; height: 50px;"></div>
PRO     <p>&varhtmlspace</p>

PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
