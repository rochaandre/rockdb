
SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO &var_outputfolder/dbpie_segment_maxtable01_&var_namefile
@rockdb/sql/headerdoc.sql &var_outputfolder/dbpie_shared_pool01_&var_namefile "dbpie_shared_pool01_" "" ""


PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="&var_outputfolder/charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO      google.charts.load("current", {packages:["corechart"]});
PRO      google.charts.setOnLoadCallback(drawChart);
PRO      function drawChart() {
PRO        var data = google.visualization.arrayToDataTable([

PRO          ['Type', 'Objects']

  SELECT ',[' ||''''|| segment_name||'''' || ','||
         gb|| ']'
  from (
    WITH
    segment_order AS
    (
    SELECT  owner,
     SEGMENT_NAME, trunc(BYTES/1024/1024/1024) GB
     from
     dba_segments
     where   owner not in('SYS','SYSTEM','ANONYMOUS','CTXSYS','HR','MDSYS','ODM','ODM_MTR','OE',
     'OLAPSYS','ORDPLUGINS','ORDSYS','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS',
     'QS_WS','SCOTT','SH','WKPROXY','WKSYS','WMSYS','XDB','DBSNMP','SYSMAN','MGMT_VIEW','SI_INFORMTN_SCHEMA',
     'DMSYS','DIP','OUTLN','EXFSYS','MDDATA','TSMSYS','APEX_PUBLIC_USER','FLOWS_FILES','OWBSYS','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR',
     'XS$NULL','APEX_030200','APPQOSSYS','ORDDATA','OWBSYS_AUDIT','ORACLE_OCM','UNICOM')
     AND  trunc(BYTES/1024/1024/1024)>0
     AND (SEGMENT_TYPE LIKE '%TABLE%' OR SEGMENT_TYPE LIKE '%LOB%' )
     order by 3 desc
    ),
    segment_top AS
    (
    SELECT  owner,
     SEGMENT_NAME,  GB
     from segment_order
     WHERE      rownum<=15
    )
    SELECT owner||'.'||segment_name segment_name,gb
    FROM segment_top
  )
/
PRO ]);
PRO
PRO         var options = {
PRO           title: 'Big tables',
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
