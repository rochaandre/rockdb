DEFINE vhtmlpage='list_outstandalerts01_'
DEFINE vtitlethispage='List outstandalerts '
DEFINE viconthispage='server.svg'
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
PRO        data.addColumn('string', 'reason');;
PRO        data.addColumn('string', 'message_level');;
PRO        data.addColumn('string', 'ALERT_LEVEL');;
PRO        data.addColumn('string', 'SUGGESTED_ACTION');;
PRO        data.addColumn('string', 'Spent');;
PRO        data.addColumn('boolean', 'Need attention');;
PRO        data.addRows([

SELECT decode(rownum,1,'[',',[') ||''''|| reason||'''' || ','||
       '''' ||message_level||'''' ||','||
       '''' ||ALERT_LEVEL||'''' ||','||
       '''' ||SUGGESTED_ACTION||''''|| ']'
from (
SELECT reason, message_level, DECODE(message_level, 5, 'WARNING', 1, 'CRITICAL') ALERT_LEVEL,
SUGGESTED_ACTION
FROM dba_outstanding_alerts)
/
PRO        ]);;
PRO
PRO        var table = new google.visualization.Table(document.getElementById('table_div'));
PRO
PRO var formatColor = new google.visualization.ColorFormat();
PRO    formatColor.addRange('FAILED', 'FAILED ', 'white', 'red');
PRO    formatColor.addRange(1000, 1001, 'white', 'green');
PRO    formatColor.format(data, 1);
PRO        table.draw(data, {allowHtml: true, showRowNumber: true, width: '100%', height: '100%'});
PRO      }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>
PRO     <div id="table_div" style="width: 900px; height: 300px;"></div>
PRO     <p>&varhtmlspace</p>
PRO   </body>
PRO </html>
@report/sql/footerhtml01
