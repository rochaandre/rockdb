DEFINE vhtmlpage='bar_tablespace_'
DEFINE vtitlethispage='Tablespace'
DEFINE viconthispage='tablespace.gif'
@rockdb/sql/headerhtmlspool.sql


 
PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO google.charts.load('current', {
PRO   packages: ['corechart', 'bar']
PRO });
PRO google.charts.setOnLoadCallback(drawStacked);
PRO
PRO function drawStacked() {
PRO  var data = google.visualization.arrayToDataTable([
PRO ['Tablespaces', 'Utilizado', 'Livre']


SELECT ',['||''''|| tablespace_name||'''' || ','||
      ALLOCATEDMB||','||
      USEDMB|| ']'
 FROM (
select &&varskip_11g_column vc.name||' '||
    substr(f.tablespace_name,1,35) tablespace_name,
    round(f.tsbytes/(1024*1024),0) "ALLOCATEDMB",
    round(nvl(s.segbytes,0)/(1024*1024),0) "USEDMB",
    round((nvl(s.segbytes,0)/f.tsbytes)*100,2) PCT
      &&varskip_11g_column ,lower(vc.name) as container
from
    (select   &&varskip_11g_column con_id,
      tablespace_name,sum(bytes) tsbytes from
    &&varskip_11g_column cdb_data_files
    &&varskip_12c_column &&varskip_18c_column &&varskip_20c_column dba_data_files
    group by &&varskip_11g_column con_id,
    tablespace_name) f,
   (select   &&varskip_11g_column con_id,
     tablespace_name,sum(bytes) segbytes from
   &&varskip_11g_column cdb_segments
   &&varskip_12c_column &&varskip_18c_column &&varskip_20c_column dba_segments
   group by &&varskip_11g_column con_id,
   tablespace_name) s
   &&varskip_11g_column  ,v$containers vc
where 1=1
&&varskip_11g_column  and f.con_id=s.con_id(+)
 and f.tablespace_name=s.tablespace_name(+)
&&varskip_11g_column  and f.con_id=vc.con_id
order by &&varskip_11g_column  container,
tablespace_name)
/

PRO ]);
PRO var options = {
select   ' title: '||'''' ||''||' Tablespaces - Espaco utilizado'||''''||','
from dual
/
--PRO     chartArea: {
--PRO       width: '45%',
--PRO      height:'100%'
--PRO     },
PRO     colors: ['red', 'green'],
PRO     isStacked: true,
PRO     hAxis: {
PRO       title: 'Container - &1',
PRO       minValue: 0,
PRO     },
PRO     vAxis: {
PRO       title: ''
PRO     }
PRO   };
PRO   var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
PRO   chart.draw(data, options);
PRO }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <div id="chart_div" style="width: 900px; height: 900px;"></div>
PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
