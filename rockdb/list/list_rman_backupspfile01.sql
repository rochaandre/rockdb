DEFINE vhtmlpage='list_rman_backupspfile01_'
DEFINE vtitlethispage='Rman backup Spfile and Controlfile'
DEFINE viconthispage='backup.svg'
@rockdb/sql/headerhtmlspool.sql


PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="&var_outputfolder/charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO      google.charts.load('current', {'packages':['table']});
PRO      google.charts.setOnLoadCallback(drawTable);
PRO
PRO      function drawTable() {
PRO        var data  = new google.visualization.DataTable();
PRO        data.addColumn('string', 'Recid');;
PRO        data.addColumn('string', 'Spfile');;
PRO        data.addColumn('string', 'Completed');;
PRO        data.addColumn('string', 'Status');;
PRO        data.addColumn('string', 'Handle');;

PRO        data.addRows([


    SELECT decode(rownum,1,'[',',[') ||''''|| recid||'''' || ','||
           '''' ||spfile||'''' ||','||
           '''' ||completion_time||'''' ||','||
           '''' ||status||'''' ||','||
           '''' ||handle||'''' ||
           ']'
    from (
  SELECT bs.recid, sp.spfile_included spfile
  , TO_CHAR(bs.completion_time, 'dd/mm/yyyy HH24:MI:SS') completion_time
  , DECODE(status, 'A', 'Available', 'D', 'Deleted', 'X', 'Expired') status, handle
  FROM v$backup_set  bs, v$backup_piece  bp, (select distinct set_stamp, set_count, 'YES' spfile_included
   from v$backup_spfile) sp
  WHERE bs.set_stamp = bp.set_stamp
    AND bs.completion_time > sysdate -1
    AND bs.set_count = bp.set_count
    AND bp.status IN ('A', 'X')
    AND bs.set_stamp = sp.set_stamp
    AND bs.set_count = sp.set_count
  ORDER BY  bs.completion_time desc, bs.recid, piece#
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
