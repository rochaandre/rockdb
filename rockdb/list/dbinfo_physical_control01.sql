DEFINE vhtmlpage='dbinfo_physical_control01_'
DEFINE vtitlethispage='Controlfile from this database'
DEFINE viconthispage='controlfile.gif'
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

PRO        data.addColumn('string', 'inst_id');;
PRO        data.addColumn('string', 'name');;
PRO        data.addColumn('string', 'block_size');;
PRO        data.addColumn('string', 'con_id');;

PRO        data.addRows([


SELECT decode(rownum,1,'[',',[') ||
       '''' ||inst_id||'''' ||
       ','||'''' ||name||''''||
       ','||'''' ||block_size||''''||
       ','||'''' ||con_id||''''||
       ']' output
from (
    SELECT a.inst_id ,
    a.name,
    a.block_size,
    a.con_id
    FROM GV$CONTROLFILE a
    ORDER BY a.con_id
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

PRO     <div id="table_div" style="width: 800px; height: 150px;"></div>
PRO     <p>&varhtmlspace</p>

PRO   </body>
PRO </html>
@report/sql/footerhtml01
