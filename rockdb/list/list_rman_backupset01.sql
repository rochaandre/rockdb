DEFINE vhtmlpage='list_rman_backupset01_'
DEFINE vtitlethispage='Rman backupset'
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
PRO        data.addColumn('string', 'Backup type');;
PRO        data.addColumn('string', 'Type');;
PRO        data.addColumn('string', 'Controlfile');;
PRO        data.addColumn('string', 'Spfile');;
PRO        data.addColumn('string', 'L');;
PRO        data.addColumn('string', 'Start');;
PRO        data.addColumn('string', 'End');;
PRO        data.addColumn('string', 'Elapsed');;
PRO        data.addColumn('string', 'Tag');;

PRO        data.addColumn('string', 'Block');;
PRO        data.addRows([


    SELECT decode(rownum,1,'[',',[') ||''''|| recid||'''' || ','||
           '''' ||backup_type||'''' ||','||
           '''' ||type||'''' ||','||
           '''' ||controlfile||'''' ||','||
           '''' ||spfile||'''' ||','||
           '''' ||L||'''' ||','||
           '''' ||start_time||'''' ||','||
           '''' ||end_time||'''' ||','||
           '''' ||ELAPSED||'''' ||','||
           '''' ||tag||'''' ||','||
           '''' ||BLOCK||'''' ||
            ']'
    from (
    SELECT  to_char(bs.recid) recid ,
    DECODE(backup_type, 'L', 'Archived Logs', 'D', 'Datafile Full', 'I', 'Incremental') backup_type,
    device_type  type , DECODE(bs.controlfile_included, 'NO', null, bs.controlfile_included) controlfile,
    sp.spfile_included spfile, bs.incremental_level L,TO_CHAR(bs.start_time, 'dd/mm/yyyy HH24:MI:SS') start_time,
    TO_CHAR(bs.completion_time, 'dd/mm/yyyy HH24:MI:SS')  end_time, bs.elapsed_seconds "ELAPSED",
    bp.tag, bs.block_size "BLOCK"
    FROM  v$backup_set  bs, (select distinct set_stamp, set_count, tag, device_type from v$backup_piece where status in ('A', 'X'))  bp,
     (select distinct set_stamp, set_count, 'YES' spfile_included from v$backup_spfile) sp
  WHERE completion_time > sysdate -1
    AND bs.set_stamp = bp.set_stamp
    AND bs.set_count = bp.set_count
    AND bs.set_stamp = sp.set_stamp (+)
    AND bs.set_count = sp.set_count (+)
  ORDER BY  completion_time desc, bs.recid
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
