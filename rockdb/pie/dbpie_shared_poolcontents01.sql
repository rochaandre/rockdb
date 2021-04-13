DEFINE vhtmlpage='dbpie_shared_poolcontents01_'
DEFINE vtitlethispage='Shared Pool - internal schemas'
DEFINE viconthispage='shared.gif'


SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO &var_outputfolder/&vhtmlpage&var_namefile
@rockdb/sql/headerdoc.sql &var_outputfolder/&vhtmlpage&var_namefile "&vhtmlpage" "" ""

PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO      google.charts.load("current", {packages:["corechart"]});
PRO      google.charts.setOnLoadCallback(drawChart);
PRO      function drawChart() {
PRO        var data = google.visualization.arrayToDataTable([
PRO          ['Name', 'Value']
SELECT ',['
||''''|| name ||'''' || ','||
       value|| ']'
from (
  select owner || '.' || name ||' '|| TYPE name
--   , to_char(sharable_mem/1024,'9,999.9') SPACE
  -- , loads
  , executions value
  --, kept
  from v$db_object_cache
  where type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE')
  AND executions>0
  and owner in ('SYS','SYSTEM','ANONYMOUS','CTXSYS','HR','MDSYS','ODM','ODM_MTR','OE',
  'OLAPSYS','ORDPLUGINS','ORDSYS','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS',
  'QS_WS','SCOTT','SH','WKPROXY','WKSYS','WMSYS','XDB','DBSNMP','SYSMAN','MGMT_VIEW','SI_INFORMTN_SCHEMA',
  'DMSYS','DIP','OUTLN','EXFSYS','MDDATA','TSMSYS','APEX_PUBLIC_USER','FLOWS_FILES','OWBSYS','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR',
  'XS$NULL','APEX_030200','APPQOSSYS','ORDDATA','OWBSYS_AUDIT','ORACLE_OCM','UNICOM')
  order by executions DESC , kept, owner, name
)
WHERE ROWNUM <=20
/
PRO ]);
PRO
PRO         var options = {
PRO           title: '&vtitlethispage',
PRO           is3D: true,
PRO         };
PRO
PRO         var chart = new google.visualization.PieChart(document.getElementById('piechart'));
PRO         chart.draw(data, options);
PRO       }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <div id="piechart" style="width: 450px; height: 450px;"></div>
PRO   </body>
PRO </html>
SPO OFF;
SET HEA ON LIN 80 NEWP 1 PAGES 14 FEED ON ECHO OFF VER ON LONG 80 LONGC 80 WRA ON TRIMS OFF TRIM OFF TI OFF TIMI OFF ARRAY 15 NUM 10 NUMF "" SQLBL OFF BLO ON RECSEP WR;
