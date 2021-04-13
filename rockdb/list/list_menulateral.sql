DEFINE vhtmlpage='list_menulateral_'
DEFINE vtitlethispage='Menu Lateral'
DEFINE viconthispage='menu.gif'
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
PRO        data.addColumn('string', 'Menu');;

PRO        data.addRows([

  data.addRows([
  ['Dashboard','WE8MSWIN1252']
  ,['NLS_NCHAR_CHARACTERSET','AL16UTF16']
  ,['NLS_RDBMS_VERSION','11.2.0.4.0']
  ]);

PRO        ]);;
PRO
PRO        var table = new google.visualization.Table(document.getElementById('table_div01'));
PRO
PRO var formatColor = new google.visualization.ColorFormat();
PRO    formatColor.addRange('TRUEx', 'TRUEx ', 'white', 'red');
PRO    formatColor.addRange(1000, 1001, 'white', 'green');
PRO    formatColor.format(data, 1);
PRO        table.draw(data, {allowHtml: true,sort: enable, alternatingRowStyle: false, showRowNumber: false, width: '100%', height: '100%'});
PRO      }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>
PRO     <div id="table_div01" style="width: 900px; height: 550px;"></div>
PRO     <p>&varhtmlspace</p>
PRO   </body>
PRO </html>
@report/sql/footerhtml01
