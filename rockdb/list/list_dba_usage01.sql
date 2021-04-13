DEFINE vhtmlpage='list_dba_usage01_'
DEFINE vtitlethispage='Features used'
DEFINE viconthispage='server.svg'
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
PRO
PRO        data.addColumn('string', 'Name');;
PRO        data.addColumn('string', 'Detected usages');;
PRO        data.addColumn('string', 'first_usage_dates');;
PRO        data.addColumn('string', 'currently_used');;
PRO        data.addRows([


  SELECT decode(rownum,1,'[',',[') ||
         '''' ||name||'''' ||
         '''' ||detected_usages||'''' ||
         '''' ||first_usage_date||'''' ||
         ','||'''' ||currently_used||''''||
         ']' output
  from (
    select
       name  ,
       detected_usages  ,
       first_usage_date  ,
       currently_used
    from
       dba_feature_usage_statistics
    where
       first_usage_date is not null
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
