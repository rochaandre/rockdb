SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO &var_outputfolder/dbinfo03_&var_namefile
@rockdb/sql/headerdoc.sql &var_outputfolder/dbinfo03_&var_namefile "Info of database" "May differ for RAC" "" ""
PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO      google.charts.load('current', {'packages':['table']});
PRO      google.charts.setOnLoadCallback(drawTable);
PRO
PRO      function drawTable() {
PRO        var data = new google.visualization.DataTable();
PRO        data.addColumn('string', 'db_unique_name');;
PRO        data.addColumn('string', 'database_role');;
PRO        data.addColumn('string', 'open_mode');;
PRO        data.addColumn('string', 'db_version');;
PRO        data.addColumn('string', 'db_compatible');;
PRO        data.addColumn('string', 'db_status');;
PRO        data.addRows([
alter session set NLS_NUMERIC_CHARACTERS = '.,'
/
SELECT decode(rownum,1,'[',',[') ||
       '''' ||db_unique_name||'''' ||
       ','||'''' ||database_role||''''||
       ','||'''' ||open_mode||''''||
       ','||'''' ||db_version||''''||
       ','||'''' ||db_compatible||''''||
       ','||'''' ||db_status||''''||
       ']' output
from (
select d.db_unique_name, d.database_role, d.open_mode, v.version db_version,
substr(p.value,1,15) db_compatible, v.status db_status
from gv$database d, gv$instance v, gv$parameter p
where p.name = 'compatible'
and d.inst_id=v.inst_id and v.inst_id = p.inst_id
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

PRO     <div id="table_div" style="width: 900px; height: 50px;"></div>
PRO     <p>&varhtmlspace</p>

PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
