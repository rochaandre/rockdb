DEFINE vhtmlpage='dbinfo_physical_tempfile01_11g_'
DEFINE vtitlethispage='Temp files for this database'
DEFINE viconthispage='tempfile.gif'
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

PRO        data.addColumn('string', 'con_id');;
PRO        data.addColumn('string', 'name');;
PRO        data.addColumn('string', 'file_id');;
PRO        data.addColumn('string', 'file_name');;
PRO        data.addColumn('string', 'used');;
PRO        data.addColumn('string', 'maxsize');;
PRO        data.addColumn('string', 'Autoextensible');;


PRO        data.addRows([

SELECT decode(rownum,1,'[',',[') ||
       ','||'''' ||name||''''||
       ','||'''' ||file_id||''''||
       ','||'''' ||file_name||''''||
       ','||'''' ||used||''''||
       ','||'''' ||maxsize||''''||
       ','||'''' ||AUTOEXTENSIBLE||''''||
       ']' output
from (
select
tablespace_name name,file_id,file_name, trunc(bytes/1024/1024/1024,2) used,trunc(maxbytes/1024/1024/1024,2) maxsize,AUTOEXTENSIBLE
from dba_temp_files
ORDER BY  file_id
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

PRO     <div id="table_div" style="width: 950px; height: 200px;"></div>
PRO     <p>&varhtmlspace</p>

PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
