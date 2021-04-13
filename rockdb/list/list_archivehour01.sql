DEFINE vhtmlpage='list_archivehour01_'
DEFINE vtitlethispage='list archives per hour'
DEFINE viconthispage='archive.svg'
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
PRO        data.addColumn('string', 'Thread');;
PRO        data.addColumn('string', 'YYYYMMDD');;
PRO        data.addColumn('string', 'DAY');;
PRO        data.addColumn('string', 'H00');;
PRO        data.addColumn('string', 'H01');;
PRO        data.addColumn('string', 'H02');;
PRO        data.addColumn('string', 'H03');;
PRO        data.addColumn('string', 'H04');;
PRO        data.addColumn('string', 'H05');;
PRO        data.addColumn('string', 'H06');;
PRO        data.addColumn('string', 'H07');;
PRO        data.addColumn('string', 'H08');;
PRO        data.addColumn('string', 'H09');;
PRO        data.addColumn('string', 'H10');;
PRO        data.addColumn('string', 'H11');;
PRO        data.addColumn('string', 'H12');;
PRO        data.addColumn('string', 'H13');;
PRO        data.addColumn('string', 'H14');;
PRO        data.addColumn('string', 'H15');;
PRO        data.addColumn('string', 'H16');;
PRO        data.addColumn('string', 'H17');;
PRO        data.addColumn('string', 'H18');;
PRO        data.addColumn('string', 'H19');;
PRO        data.addColumn('string', 'H20');;
PRO        data.addColumn('string', 'H21');;
PRO        data.addColumn('string', 'H22');;
PRO        data.addColumn('string', 'H23');;
PRO        data.addColumn('string', 'TotGB');;
PRO        data.addColumn('string', 'CNT');;
PRO        data.addColumn('string', 'AvgGB');;
PRO        data.addRows([

SELECT decode(rownum,1,'[',',[') ||
       '''' ||THREAD#||'''' ||','||
       '''' ||YYYYMMDD||'''' ||','||
       '''' ||DAY||''''||
       ','||'''' ||H00||''''||
       ','||'''' ||H01||''''||
       ','||'''' ||H02||''''||
       ','||'''' ||H03||''''||
       ','||'''' ||H04||''''||
       ','||'''' ||H05||''''||
       ','||'''' ||H06||''''||
       ','||'''' ||H07||''''||
       ','||'''' ||H08||''''||
       ','||'''' ||H09||''''||
       ','||'''' ||H10||''''||
       ','||'''' ||H11||''''||
       ','||'''' ||H12||''''||
       ','||'''' ||H13||''''||
       ','||'''' ||H14||''''||
       ','||'''' ||H15||''''||
       ','||'''' ||H16||''''||
       ','||'''' ||H17||''''||
       ','||'''' ||H18||''''||
       ','||'''' ||H19||''''||
       ','||'''' ||H20||''''||
       ','||'''' ||H21||''''||
       ','||'''' ||H22||''''||
       ','||'''' ||H23||''''||
       ','||'''' ||TOT_GB||''''||
       ','||'''' ||CNT||''''||
       ','||'''' ||AVG_GB||''''||
       ']' output
from (
WITH
log AS (
SELECT /*+  MATERIALIZE NO_MERGE  */
       --DISTINCT
       thread#,
       sequence#,
       first_time,
       blocks,
       block_size
  FROM v$archived_log
 WHERE first_time IS NOT NULL
),
log_denorm AS (
SELECT /*+  MATERIALIZE NO_MERGE  */
      thread#,
      ''|| TO_CHAR(TRUNC(first_time), 'YYYYMMDD') yyyymmdd,
      ''|| TO_CHAR(TRUNC(first_time), 'Dy') day,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '00', 1, 0)),1,3) h00,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '01', 1, 0)),1,3) h01,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '02', 1, 0)),1,3) h02,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '03', 1, 0)),1,3) h03,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '04', 1, 0)),1,3) h04,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '05', 1, 0)),1,3) h05,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '06', 1, 0)),1,3) h06,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '07', 1, 0)),1,3) h07,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '08', 1, 0)),1,3) h08,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '09', 1, 0)),1,3) h09,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '10', 1, 0)),1,3) h10,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '11', 1, 0)),1,3) h11,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '12', 1, 0)),1,3) h12,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '13', 1, 0)),1,3) h13,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '14', 1, 0)),1,3) h14,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '15', 1, 0)),1,3) h15,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '16', 1, 0)),1,3) h16,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '17', 1, 0)),1,3) h17,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '18', 1, 0)),1,3) h18,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '19', 1, 0)),1,3) h19,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '20', 1, 0)),1,3) h20,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '21', 1, 0)),1,3) h21,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '22', 1, 0)),1,3) h22,
      ''|| substr(SUM(DECODE(TO_CHAR(first_time, 'HH24'), '23', 1, 0)),1,3) h23,
      ''||  ROUND(SUM(blocks * block_size) / POWER(10,9), 1)  TOT_GB,
      ''|| substr(COUNT(*),1,2) cnt,
      ''||  ROUND(SUM(blocks * block_size) / POWER(10,9) / COUNT(*), 1) AVG_GB
  FROM log
 GROUP BY
       thread#,
       TRUNC(first_time)
 ORDER BY
       thread#,
       TRUNC(first_time) DESC
),
ordered_log AS (
SELECT /*+  MATERIALIZE NO_MERGE  */
       ROWNUM row_num_noprint, log_denorm.*
  FROM log_denorm
),
min_set AS (
SELECT /*+  MATERIALIZE NO_MERGE  */
       thread#,
       MIN(row_num_noprint) min_row_num
  FROM ordered_log
 GROUP BY
       thread#
)
SELECT /*+  NO_MERGE  */
       log.*
  FROM ordered_log log,
       min_set ms
 WHERE log.thread# = ms.thread#
   AND log.row_num_noprint < ms.min_row_num + 14
 ORDER BY
       log.thread#,
       log.yyyymmdd DESC)
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
PRO     <div id="table_div" style="width: 1200px; height: 900px;"></div>
PRO     <p>&varhtmlspace</p>

PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
