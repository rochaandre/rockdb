DEFINE vhtmlpage='list_nls_characters01_'
DEFINE vtitlethispage='List nls characters'
DEFINE viconthispage='server.svg'
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
PRO        data.addColumn('string', 'Description');;
PRO        data.addColumn('string', 'Properties');;
PRO        data.addRows([

  SELECT decode(rownum,1,'[',',[') ||
         '''' ||name||'''' ||
         ','||'''' ||value||''''||
         ']' output
  from (
    select PROPERTY_NAME name, PROPERTY_VALUE  value from database_properties where PROPERTY_NAME in ('NLS_CHARACTERSET', 'NLS_NCHAR_CHARACTERSET')
    union all
    SELECT parameter,value FROM NLS_DATABASE_PARAMETERS
  )
/
PRO        ]);;
PRO
PRO        var table = new google.visualization.Table(document.getElementById('table_divparam'));
PRO
PRO var formatColor = new google.visualization.ColorFormat();
PRO    formatColor.format(data, 1);
PRO        table.draw(data, {allowHtml: true, showRowNumber: false, width: '100%', height: '100%'});
PRO      }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>
PRO     <div id="table_divparam" style="width: 900px; height: 100%;"></div>
PRO     <p>&varhtmlspace</p>
PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
