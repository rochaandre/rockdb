DEFINE vhtmlpage='dbinfo_physical_redo01_'
DEFINE vtitlethispage='Redo files for this database'
DEFINE viconthispage='redofile.gif'
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

PRO        data.addColumn('string', 'inst_id');;
PRO        data.addColumn('string', 'Group');;
PRO        data.addColumn('string', 'Thread');;
PRO        data.addColumn('string', 'sequence');;
PRO        data.addColumn('string', 'archived');;
PRO        data.addColumn('string', 'Status');;
PRO        data.addColumn('string', 'file Name');;
PRO        data.addColumn('string', 'Size');;

PRO        data.addRows([

SELECT decode(rownum,1,'[',',[') ||
       '''' ||inst_id||'''' ||
       ','||'''' ||groupredo||''''||
       ','||'''' ||thread||''''||
       ','||'''' ||sequence||''''||
       ','||'''' ||ARCHIVED||''''||
       ','||'''' ||STATUS||''''||
       ','||'''' ||FILE_NAME||''''||
       ','||'''' ||SIZE_MB||''''||
       ']' output
from (
    SELECT a.inst_id ,
    a.GROUP# groupredo,
    a.THREAD# thread,
    a.SEQUENCE# sequence,
    a.ARCHIVED,
    a.STATUS,
    b.MEMBER AS FILE_NAME,
    (a.BYTES/1024/1024) AS SIZE_MB
    FROM gv$log a
    JOIN gv$logfile b ON a.Group#=b.Group#
    where a.inst_id =  b.inst_id
    ORDER BY b.inst_id, a.GROUP#
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

PRO     <div id="table_div" style="width: 800px; height: 200px;"></div>
PRO     <p>&varhtmlspace</p>

PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
