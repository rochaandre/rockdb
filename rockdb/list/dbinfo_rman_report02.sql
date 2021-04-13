DEFINE vhtmlpage='dbinfo_rman_report02_'
DEFINE vtitlethispage='Report rman'
DEFINE viconthispage='rman.gif'
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

PRO        data.addColumn('string', 'Stamp');;
PRO        data.addColumn('string', 'Count');;
PRO        data.addColumn('string', 'Type');;
PRO        data.addColumn('string', 'Completed');;
PRO        data.addColumn('string', 'CtrlBkp');;
PRO        data.addColumn('string', 'Piece');;
PRO        data.addColumn('string', 'Handle');;
PRO        data.addRows([

SELECT decode(rownum,1,'[',',[') ||
       '''' ||Stamp||'''' ||
       ','||'''' ||Count||''''||
       ','||'''' ||type||''''||
       ','||'''' ||CompletedAt||''''||
       ','||'''' ||Control||''''||
       ','||'''' ||piece||''''||
       ','||'''' ||handle||''''||
       ']' output
from (
select s.set_stamp stamp, s.set_count count,
   decode(s.backup_type,'L','ArchiveLog','D','Datafile','I','Incremental') type,
    s.pieces, to_char(p.start_time,'DD-MON HH24:MI') Start_At, to_char(p.completion_time,'DD-MON HH24:MI') CompletedAt,
    controlfile_included control,
    p.piece# piece, p.handle
    from v$backup_set s, v$backup_piece p
    where s.set_stamp=p.set_stamp
    and s.set_count=p.set_count
    and s.completion_time > sysdate-1
  order by s.completion_time, piece#)
/

PRO        ]);;
PRO
PRO        var table = new google.visualization.Table(document.getElementById('table_div'));
PRO
PRO var formatColor = new google.visualization.ColorFormat();
PRO    formatColor.addRange('FAILED', 'FAILED ', 'white', 'red');
PRO    formatColor.addRange(1000, 1001, 'white', 'green');
PRO    formatColor.format(data, 1);
PRO        table.draw(data, {allowHtml: true, showRowNumber: true, width: '100%', height: '100%'});
PRO      }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>

PRO     <div id="table_div" style="width: 900px; height: 500px;"></div>
PRO     <p>&varhtmlspace</p>

PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
