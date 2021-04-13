DEFINE vhtmlpage='list_rman_backupsize01_'
DEFINE vtitlethispage='Rman backup Size'
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
  PRO        data.addColumn('string', 'Date');;
  PRO        data.addColumn('string', 'Size');;
  PRO        data.addColumn('string', 'Increase');;

  PRO        data.addRows([


    SELECT decode(rownum,1,'[',',[') ||
          ''''|| datafile||'''' || ','||
          ''''|| BACKUP_DATE||'''' || ','||
          ''''||   tam ||'''' || ','||
          ''''||   Increase ||'''' ||
            ']'
   from (
  SELECT datafile,BACKUP_DATE, tam ,
  decode((LEAD( tam , 1, 0) OVER (ORDER BY BACKUP_DATE desc) -  tam ) * -1 ,
  tam,0,(LEAD( tam , 1, 0) OVER (ORDER BY BACKUP_DATE desc) -  tam ) * -1)
  Increase
  FROM (
  select 'Datafile' datafile, trunc(completion_time) "BACKUP_DATE", trunc(sum(blocks*block_size)/1024/1024) tam
  from v$backup_datafile
  WHERE completion_time > sysdate - 8
  group by trunc(completion_time)
  )
  UNION all
  SELECT datafile,BACKUP_DATE, tam ,
  decode((LEAD( tam , 1, 0) OVER (ORDER BY BACKUP_DATE desc) -  tam ) * -1 ,
  tam,0,(LEAD( tam , 1, 0) OVER (ORDER BY BACKUP_DATE desc) -  tam ) * -1)
  Increase
  FROM (
  SELECT 'Archive' datafile,trunc(first_time) "BACKUP_DATE",  trunc(sum(blocks*block_size)/1024/1024 )  tam
  from v$backup_redolog
  WHERE first_time > sysdate-8
  group by 'Archive'  ,trunc(first_time))
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
