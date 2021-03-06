DEFINE vhtmlpage='dbperf_waits_withsql_'
DEFINE vtitlethispage='Waits with sql'
DEFINE viconthispage='person-lines-fill.svg'
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
PRO        data.addColumn('string', 'Sid');;
PRO        data.addColumn('string', 'serial');;
PRO        data.addColumn('string', 'Event');;
PRO        data.addColumn('string', 'Seconds');;
PRO        data.addColumn('string', 'SQL text');;
PRO        data.addRows([
alter session set NLS_NUMERIC_CHARACTERS = '.,'
/
SELECT decode(rownum,1,'[',',[') ||
       '''' ||sid||'''' ||
       ','||'''' ||serial||''''||
       ','||'''' ||event||''''||
       ','||'''' ||SECONDS_IN_WAIT||''''||
       ','||'''' ||SQL_TEXT||''''||
       ']' output
from (
SELECT s.SID,s.serial# serial, W.EVENT, W.SECONDS_IN_WAIT, SQL.SQL_TEXT
FROM GV$SESSION_WAIT W,
GV$SESSION S,
GV$PROCESS P,
GV$SQLTEXT SQL
WHERE W.SID = S.SID
AND S.PADDR = P.ADDR
AND SQL.ADDRESS = S.SQL_ADDRESS
AND SQL.HASH_VALUE = S.SQL_HASH_VALUE
AND W.WAIT_CLASS != 'Idle'
AND W.INST_ID = S.INST_ID
AND W.INST_ID = P.INST_ID
AND W.INST_ID = SQL.INST_ID
ORDER BY W.SECONDS_IN_WAIT, W.SID, SQL.PIECE
)
/
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
