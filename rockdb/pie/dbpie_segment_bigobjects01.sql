
SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO &var_outputfolder/dbpie_segment_bigobjects01_&var_namefile
@rockdb/sql/headerdoc.sql &var_outputfolder/dbpie_segment_bigobjects01_&var_namefile "dbpie_segment_bigobjects01_" "" ""


PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO      google.charts.load("current", {packages:["corechart"]});
PRO      google.charts.setOnLoadCallback(drawChart);
PRO      function drawChart() {
PRO        var data = google.visualization.arrayToDataTable([
PRO          ['Type', 'Objects']

  SELECT ',[' ||''''|| segment_nm||' '|| tablespace_name ||' '|| segment_type||'''' ||
  ','||      trunc(  bytes ) ||
   ']'
  from (
      SELECT
    segment_nm,
    segment_type,
    trunc(bytes/1024/1024) bytes,
    LPAD( CASE
    WHEN bytes < 1024
    THEN ROUND( bytes, 2 ) || ' B'
    WHEN bytes < POWER( 1024, 2 )
    THEN ROUND( ( bytes / 1024 ), 2 ) || ' KB'
    WHEN bytes < POWER( 1024, 3)
    THEN ROUND( ( bytes / 1024 / 1024 ), 2 ) || ' MB'
    WHEN bytes < POWER( 1024, 4 )
    THEN ROUND( ( bytes / 1024 / 1024 / 1024 ), 2 ) || ' GB'
    ELSE ROUND( ( bytes / 1024 / 1024 / 1024 / 1024 ), 2 ) || ' TB'
    END, 15 ) AS used_size,
    tablespace_name
    FROM
    (
    SELECT
    owner || '.' ||  ( segment_name ) AS segment_nm,
    segment_type,
    bytes,
    tablespace_name,
    DENSE_RANK() OVER ( ORDER BY bytes DESC ) AS dr
    FROM
    dba_segments
    where   owner not in('SYS','SYSTEM','ANONYMOUS','CTXSYS','HR','MDSYS','ODM','ODM_MTR','OE',
    'OLAPSYS','ORDPLUGINS','ORDSYS','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS',
    'QS_WS','SCOTT','SH','WKPROXY','WKSYS','WMSYS','XDB','DBSNMP','SYSMAN','MGMT_VIEW','SI_INFORMTN_SCHEMA',
    'DMSYS','DIP','OUTLN','EXFSYS','MDDATA','TSMSYS','APEX_PUBLIC_USER','FLOWS_FILES','OWBSYS','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR',
    'XS$NULL','APEX_030200','APPQOSSYS','ORDDATA','OWBSYS_AUDIT','ORACLE_OCM','UNICOM')
    )
    WHERE
     dr <= 10 /* top-10 may have more then 10 */
    ORDER BY /* lots of ordering in cases of ties */
    bytes DESC,
    dr ASC,
    segment_nm ASC
  )
/
PRO ]);
PRO
PRO         var options = {
PRO           title: 'Big Objects/Segments',
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
