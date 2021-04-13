DEFINE vhtmlpage='list_archivemb01_'
DEFINE vtitlethispage='list archives per hour MB'
DEFINE viconthispage='archive.svg'
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
PRO        data.addColumn('string', 'Hour');;
PRO        data.addColumn('string', 'thread#');;
PRO        data.addColumn('string', 'gb');;
PRO        data.addColumn('string', 'archives');;
PRO        data.addRows([

  SELECT decode(rownum,1,'[',',[') ||
         '''' ||Hour||'''' ||','||
         '''' ||thread#||'''' ||','||
         '''' ||gb||''''||
         ','||'''' ||archives||''''||
         ']' output
  from (
   select trunc(COMPLETION_TIME,'HH') Hour,thread# ,
    round(sum(BLOCKS*BLOCK_SIZE)/1024/1024/1024) GB,
    count(*) Archives from v$archived_log
    group by trunc(COMPLETION_TIME,'HH'),thread#  order by 1
  )


/
PRO        ]);;
PRO
PRO        var table = new google.visualization.Table(document.getElementById('table_div'));
PRO
PRO var formatColor = new google.visualization.ColorFormat();
PRO    formatColor.format(data, 1);
PRO        table.draw(data, {allowHtml: true, showRowNumber: true, width: '100%', height: '100%'});
PRO      }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>
PRO     <div id="table_div" style="width: 1200px; height: 900px;"></div>
PRO     <p>&varhtmlspace</p>

PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
