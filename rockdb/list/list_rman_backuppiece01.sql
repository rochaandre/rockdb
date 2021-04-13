DEFINE vhtmlpage='list_rman_backuppiece01_'
DEFINE vtitlethispage='Rman backuppiece'
DEFINE viconthispage='backup.svg'
@rockdb/sql/headerhtmlspool.sql



PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO      google.charts.load('current', {'packages':['table']});
PRO      google.charts.setOnLoadCallback(drawTable);
PRO
PRO      function drawTable() {
PRO        var data = new google.visualization.DataTable();
PRO        data.addColumn('string', 'Recid');;
PRO        data.addColumn('string', 'status');;
PRO        data.addColumn('string', 'handle');;
PRO        data.addColumn('string', 'Start');;
PRO        data.addColumn('string', 'End');;
PRO        data.addColumn('string', 'Elapsed');;

PRO        data.addRows([


    SELECT decode(rownum,1,'[',',[') ||''''|| recid||'''' || ','||
           '''' ||status||'''' ||','||
           '''' ||handle||'''' ||','||
           '''' ||start_time||'''' ||','||
           '''' ||end_time||'''' ||','||
           '''' ||ELAPSED||'''' ||
           ']'
    from (
    SELECT bs.recid,
  DECODE(   bp.status, 'A', 'Available', 'D', 'Deleted', 'X', 'Expired') status , bp.handle
  handle, TO_CHAR(bp.start_time, 'dd/mm/yyyy HH24:MI:SS') start_time
  , TO_CHAR(bp.completion_time, 'dd/mm/yyyy HH24:MI:SS') end_time, bp.elapsed_seconds   ELAPSED
  FROM
      v$backup_set bs JOIN v$backup_piece bp USING (set_stamp,set_count)
  WHERE
      bp.status IN ('A', 'X') AND bp.completion_time > sysdate-8
  ORDER BY bp.completion_time desc, bs.recid, bp.piece#
    )
/

PRO        ]);;
PRO
PRO        var table  = new google.visualization.Table(document.getElementById('table_div'));
PRO
PRO var formatColor = new google.visualization.ColorFormat();
PRO    formatColor.addRange('FAILED', 'FAILED', 'white', 'red');
PRO    formatColor.addRange(1000, 1001, 'white', 'green');
PRO    formatColor.format(data , 1);
PRO        table.draw(data , {allowHtml: true, showRowNumber: true, width: '100%', height: '100%'});
PRO      }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>
PRO     <div id="table_div" style="width: 1100px; height: 550px;"></div>
PRO     <p>&varhtmlspace</p>
PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
