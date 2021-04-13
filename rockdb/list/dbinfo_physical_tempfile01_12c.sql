DEFINE vhtmlpage='dbinfo_physical_tempfile01_12c_'
DEFINE vtitlethispage='Temp files for this database'
DEFINE viconthispage='tempfile.gif'
@rockdb/sql/headerhtmlspool.sql


SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO  html/dbinfo_physical_tempfile01.html
PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
       '''' ||con_id||'''' ||
       ','||'''' ||name||''''||
       ','||'''' ||file_id||''''||
       ','||'''' ||file_name||''''||
       ','||'''' ||used||''''||
       ','||'''' ||maxsize||''''||
       ','||'''' ||AUTOEXTENSIBLE||''''||
       ']' output
from (
select con_id,
tablespace_name name,file_id,file_name, trunc(bytes/1024/1024/1024,2) used,trunc(maxbytes/1024/1024/1024,2) maxsize,AUTOEXTENSIBLE
from cdb_temp_files
ORDER BY con_id,file_id
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
