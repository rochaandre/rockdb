DEFINE vhtmlpage='list_version01_'
DEFINE vtitlethispage='List version'
DEFINE viconthispage='card-checklist.svg'
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
PRO        data.addColumn('string', '');;
PRO        data.addColumn('string', 'Banner');;
PRO        data.addRows([

  SELECT decode(rownum,1,'[',',[') ||
         '''' ||lbl||'''' ||
         ','||'''' ||banner||''''||

         ']' output
  from (
    select null lbl, banner from v$version
)
/
PRO        ]);;
PRO
PRO        var table = new google.visualization.Table(document.getElementById('table_divversion01'));
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
PRO     <div id="table_divversion01" style="width: 900px; height: 350px;"></div>
PRO     <p>&varhtmlspace</p>
PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
