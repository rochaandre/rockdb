DEFINE vhtmlpage='list_rman_backupjob01_'
DEFINE vtitlethispage='Rman Backup Job'
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
PRO        data.addColumn('string', 'Type');;
PRO        data.addColumn('string', 'Status');;
PRO        data.addColumn('string', 'Start');;
PRO        data.addColumn('string', 'End');;
PRO        data.addColumn('string', 'Hours');;

PRO        data.addRows([


    SELECT decode(rownum,1,'[',',[') ||
           '''' ||SESSION_KEY||'''' || ','||
           '''' ||INPUT_TYPE||'''' ||','||
           '''' ||STATUS||'''' ||','||
           '''' ||start_time||'''' ||','||
           '''' ||end_time||'''' ||','||
           '''' ||hours||'''' ||
            ']'
    from (
      select SESSION_KEY, INPUT_TYPE, STATUS,
    to_char(START_TIME,'mm/dd/yy hh24:mi') start_time,
    to_char(END_TIME,'mm/dd/yy hh24:mi')   end_time,
    trunc(elapsed_seconds/3600,3) hours
    from V$RMAN_BACKUP_JOB_DETAILS
    WHERE START_time>=sysdate-8
    order by session_key
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
PRO     <div id="table_div" style="width: 1100px; height: 550px;"></div>
PRO     <p>&varhtmlspace</p>
PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
