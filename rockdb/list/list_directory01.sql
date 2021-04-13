DEFINE vhtmlpage='list_directory01_'
DEFINE vtitlethispage='List of Directories'
DEFINE viconthispage='directory.svg'
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
PRO        data.addColumn('string', 'owner');;
PRO        data.addColumn('string', 'directory_name');;
PRO        data.addColumn('string', 'directory_path');;
PRO        data.addColumn('string', 'created');;
PRO        data.addRows([

SELECT decode(rownum,1,'[',',[') ||
       '''' || owner     ||'''' ||','||
       '''' ||directory_name||'''' ||','||
       '''' ||directory_path||'''' ||','||
       '''' ||created     ||'''' ||
       ']'
from (
SELECT a.owner,a.directory_name, a.directory_path , created
FROM DBA_OBJECTS b, dba_directories a
WHERE a.owner = b.owner
AND a.directory_name = b.object_name
ORDER BY created
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
PRO        table.draw(data, {allowHtml: true, showRowNumber: true, width: '100%', height: '100%'});
PRO      }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>
PRO     <div id="table_div" style="width: 900px; height: 500px;"></div>
PRO   <PRE>
PRO   </PRE>
PRO   <BR>
PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
