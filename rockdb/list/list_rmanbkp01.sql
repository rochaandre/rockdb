DEFINE vhtmlpage='list_rmanbkp01_'
DEFINE vtitlethispage='List rman bkp'
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
PRO        data.addColumn('string', 'Type');;
PRO        data.addColumn('string', 'Status');;
PRO        data.addColumn('string', 'Start');;
PRO        data.addColumn('string', 'Finish');;
PRO        data.addColumn('string', 'Spent');;
PRO        data.addColumn('string', 'Need attention');;
PRO        data.addRows([


  SELECT decode(rownum,1,'[',',[') ||''''|| INPUT_TYPE||'''' || ','||
         '''' ||STATUS||'''' ||','||
         '''' ||START_TIME||'''' ||','||
         '''' ||END_TIME||'''' ||','||
         '''' ||HRS||'''' ||','||
         '''' ||ATTENTION||'''' ||
         ']'
  from (
  SELECT SESSION_KEY,
  INPUT_TYPE, STATUS,
  TO_CHAR(START_TIME,'DD/MM/YYYY HH24:MI') START_TIME,
  TO_CHAR(END_TIME,'DD/MM/YYYY HH24:MI') END_TIME,
  trunc(ELAPSED_SECONDS/3600,2) HRS,
   decode(STATUS,'FAILED','TRUE','FALSE') ATTENTION
   FROM V$RMAN_BACKUP_JOB_DETAILS
  WHERE  INPUT_TYPE='DB FULL'
  UNION all
  SELECT SESSION_KEY,
  INPUT_TYPE, STATUS,
  TO_CHAR(START_TIME,'DD/MM/YYYY HH24:MI') START_TIME,
  TO_CHAR(END_TIME,'DD/MM/YYYY HH24:MI') END_TIME,
  trunc(ELAPSED_SECONDS/3600,2) HRS,
   decode(STATUS,'FAILED','TRUE','FALSE') ATTENTION
   FROM V$RMAN_BACKUP_JOB_DETAILS
  WHERE INPUT_TYPE='DB INCR'
  UNION all
  SELECT SESSION_KEY,
  INPUT_TYPE, STATUS,
  TO_CHAR(START_TIME,'DD/MM/YYYY HH24:MI') START_TIME,
  TO_CHAR(END_TIME,'DD/MM/YYYY HH24:MI') END_TIME,
  trunc(ELAPSED_SECONDS/3600,2) HRS,
   decode(STATUS,'FAILED','TRUE','FALSE') ATTENTION
   FROM V$RMAN_BACKUP_JOB_DETAILS
  WHERE INPUT_TYPE not in ('ARCHIVE','DB FULL')
  ORDER BY SESSION_KEY
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
PRO
PRO <PRE>
PRO if necessary to uncatalog database backups from type
select 'Change backuppiece TAG='''|| TAG || ''' Uncatalog ; '
from v$backup_piece
where device_type = 'SBT_TAPE'
/
PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
