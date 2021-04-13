DEFINE vhtmlpage='list_redolog01_'
DEFINE vtitlethispage='List redo log group'
DEFINE viconthispage='archive.svg'
@rockdb/sql/headerhtmlspool.sql

PRO <html>
PRO   <head>

report/thirdparty/chart

PRO     <script type="text/javascript" src="charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO      google.charts.load('current', {'packages':['table']});
PRO      google.charts.setOnLoadCallback(drawTable);
PRO
PRO      function drawTable() {
PRO        var data = new google.visualization.DataTable();
PRO        data.addColumn('string', 'Thread');;
PRO        data.addColumn('string', 'Group');;
PRO        data.addColumn('string', 'Member');;
PRO        data.addColumn('string', 'Size');;
PRO        data.addColumn('string', 'Status');;
PRO        data.addColumn('string', 'Archived');;
PRO        data.addColumn('string', 'Type');;
PRO        data.addColumn('string', 'Sequence');;
PRO        data.addRows([

  SELECT decode(rownum,1,'[',',[') ||
          '''' ||THREAD||''''||
         ','||'''' ||group1||''''||
         ','||'''' ||member||''''||
         ','||'''' ||size_mb||''''||
         ','||'''' ||status||''''||
         ','||'''' ||archived||''''||
         ','||'''' ||type||''''||
         ','||'''' ||sequence||''''||
         ']' output
  from (
  SELECT l.thread# thread,
         lf.group# group1,
         lf.member,
         TRUNC(l.bytes/1024/1024) AS size_mb,
         l.status,
         l.archived,
         lf.type,
         l.sequence#  sequence
  FROM   v$logfile lf
         JOIN v$log l ON l.group# = lf.group#
  ORDER BY l.thread#,lf.group#, lf.MEMBER
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
PRO     <div id="table_div" style="width: 1000px; height: 300px;"></div>
PRO     <p>&varhtmlspace</p>
PRO <PRE>
PRO ALTER DATABASE ADD LOGFILE GROUP 4 ('/u02/oradata/ORACLE/redo04a.log') SIZE 200M;
PRO ALTER DATABASE ADD LOGFILE GROUP 5 ('/u02/oradata/ORACLE/redo05a.log') SIZE 200M;
PRO ALTER DATABASE ADD LOGFILE GROUP 6 ('/u02/oradata/ORACLE/redo06a.log') SIZE 200M;
PRO alter system switch logfile;
PRO alter system switch logfile;
PRO alter system switch logfile;
PRO alter system checkpoint;
PRO
PRO ALTER DATABASE DROP LOGFILE GROUP 1;
PRO ALTER DATABASE DROP LOGFILE GROUP 2;
PRO ALTER DATABASE DROP LOGFILE GROUP 3;
PRO ALTER DATABASE ADD LOGFILE GROUP 1 ('/u02/oradata/ORACLE/redo01a.log') SIZE 200M;
PRO ALTER DATABASE ADD LOGFILE GROUP 2 ('/u02/oradata/ORACLE/redo02a.log') SIZE 200M;
PRO ALTER DATABASE ADD LOGFILE GROUP 3 ('/u02/oradata/ORACLE/redo03a.log') SIZE 200M;

column group# format 99999;
column status format a10;
column mb format 99999;
select group#, status, bytes/1024/1024 mb from v$log
/
PRO </PRE>
PRO     <p>&varhtmlspace</p>
PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
