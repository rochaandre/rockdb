DEFINE vhtmlpage='list_tablespacedb01_'
DEFINE vtitlethispage='List size tablespace '
DEFINE viconthispage='server.svg'
@rockdb/sql/headerhtmlspool.sql


PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO      google.charts.load('current', {'packages':['table']});
PRO      google.charts.setOnLoadCallback(drawTable);
PRO
PRO      function drawTable() {
PRO        var data = new google.visualization.DataTable();
PRO        data.addColumn('string', 'Tablespaces');;
PRO        data.addColumn('string', 'Allocated');;
PRO        data.addColumn('string', 'Used');;
PRO        data.addColumn('string', 'Pct');;
PRO        data.addRows([

    SELECT decode(rownum,1,'[',',[') ||
    '''' ||tablespace_name||'''' ||
    ','||'''' ||ALLOCATEDMB||''''||
    ','||'''' ||USEDMB||''''||
    ','||'''' ||PCT||''''||
    ']' output
     FROM (
    select &&varskip_11g_column vc.name||' '||
        substr(f.tablespace_name,1,35) tablespace_name,
        round(f.tsbytes/(1024*1024),0) ALLOCATEDMB,
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
PRO        ]);;
PRO
PRO        var table = new google.visualization.Table(document.getElementById('table_divparam'));
PRO
PRO var formatColor = new google.visualization.ColorFormat();
PRO    formatColor.format(data, 1);
PRO        table.draw(data, {allowHtml: true, showRowNumber: false, width: '100%', height: '100%'});
PRO      }
PRO

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
PRO <BR>
PRO     <p>&varhtmlspace</p>
PRO     <div id="table_divparam" style="width: 900px; height: 100%;"></div>
PRO <BR>
PRO     <div id="chart_div" style="width: 900px; height: 900px;"></div>
PRO     <p>&varhtmlspace</p>
PRO <PRE>
SELECT tablespace_name, BLOCK_SIZE, status, contents, logging, encrypted, bigfile,COMPRESS_FOR
FROM dba_tablespaces
/
PRO ################
PRO # Tablespace total
PRO ################

SELECT nvl(df.tablespace_name,'Total') TABLESPACE,
    sum(df.total_space_mb) TOTAL_SPACE_MB,
    sum((df.total_space_mb - fs.free_space_mb)) USED_SPACE_MB,
    sum(fs.free_space_mb) FREE_SPACE_MB,
    DECODE(df.tablespace_name, NULL,
      ROUND(100*SUM(fs.FREE_SPACE)/SUM(df.total_space),2),
      SUM(ROUND(100 * (fs.free_space / df.total_space),2))) PERCENT_FREE
FROM (SELECT tablespace_name, SUM(bytes) TOTAL_SPACE,
   ROUND(SUM(bytes) / 1048576) TOTAL_SPACE_MB
   FROM dba_data_files
   GROUP BY tablespace_name) df,
  (SELECT tablespace_name, SUM(bytes) FREE_SPACE,
    ROUND(SUM(bytes) / 1048576) FREE_SPACE_MB
    FROM dba_free_space
    GROUP BY tablespace_name) fs
WHERE df.tablespace_name = fs.tablespace_name(+)
GROUP BY rollup(df.tablespace_name)
ORDER BY df.tablespace_name
/
PRO ################
PRO # Reduce tablespace
PRO ################


with
hwm as (
 -- get highest block id from each datafiles ( from x$ktfbue as we don't need all joins from dba_extents )
 select /*+ materialize */ ktfbuesegtsn ts#,ktfbuefno relative_fno,max(ktfbuebno+ktfbueblks-1) hwm_blocks
 from sys.v_x$ktfbue group by ktfbuefno,ktfbuesegtsn
),
hwmts as (
 -- join ts# with tablespace_name
 select name tablespace_name,relative_fno,hwm_blocks
 from hwm join v$tablespace using(ts#)
),
hwmdf as (
 -- join with datafiles, put 5M minimum for datafiles with no extents
 select file_name,nvl(hwm_blocks*(bytes/blocks),5*1024*1024) hwm_bytes,bytes,autoextensible,maxbytes
 from hwmts right join dba_data_files using(tablespace_name,relative_fno)
)
select
case when autoextensible='YES' and maxbytes>=bytes
then -- we generate resize statements only if autoextensible can grow back to current size
 '/* reclaim '||to_char(ceil((bytes-hwm_bytes)/1024/1024),999999)
  ||'M from '||to_char(ceil(bytes/1024/1024),999999)||'M */ '
  ||'alter database datafile '''||file_name||''' resize '||ceil(hwm_bytes/1024/1024)||'M;'
else -- generate only a comment when autoextensible is off
 '/* reclaim '||to_char(ceil((bytes-hwm_bytes)/1024/1024),999999)
  ||'M from '||to_char(ceil(bytes/1024/1024),999999)
  ||'M after setting autoextensible maxsize higher than current size for file '
  || file_name||' */'
end SQL
from hwmdf
where
bytes-hwm_bytes>1024*1024 -- resize only if at least 1MB can be reclaimed
order by bytes-hwm_bytes desc
/
PRO ################
PRO # Create tablespace with ASSM
PRO ################

SELECT    'CREATE '
       || DECODE (ts.bigfile, 'YES', 'BIGFILE ') --assuming smallfile is the default table space
       || 'TABLESPACE "'
       || ts.tablespace_name
       || '" DATAFILE ' ||  ''
--         || '" DATAFILE ''C:\Oracle\oradata\yourDATABASEname\'|| ts.tablespace_name || '.DBF'''
       || CHR (13)
       || CHR (10)
       || LISTAGG (
                 '  SIZE '
              || df.bytes
              || DECODE (
                     df.autoextensible,
                     'YES',    CHR (13)
                            || CHR (10)
                            || '  AUTOEXTEND ON NEXT '
                            || df.increment_by * ts.block_size
                            || ' MAXSIZE '
                            || CASE
                                   WHEN maxbytes < POWER (1024, 3) * 2
                                   THEN
                                       TO_CHAR (maxbytes)
                                   ELSE
                                          TO_CHAR (
                                              FLOOR (
                                                  maxbytes / POWER (1024, 2)))
                                       || 'M'
                               END),
              ',' || CHR (13) || CHR (10))
          WITHIN GROUP (ORDER BY df.file_id)
       || CHR (13)
       || CHR (10)
       || '  '
       || ts.logging
       || ' '
       || ts.status
       || ' BLOCKSIZE '
       || ts.block_size
           ddl
  FROM dba_tablespaces ts
       INNER JOIN dba_data_files df
           ON ts.tablespace_name = df.tablespace_name
 WHERE     ts.contents = 'PERMANENT'                --excludes UNDO and TEMP
      -- AND ts.tablespace_name IN ('YOUR_TABLESPACE LIST')
GROUP BY ts.tablespace_name,
       ts.bigfile,
       ts.logging,
       ts.status,
       ts.block_size
ORDER BY ts.tablespace_name


PRO </PRE>

PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
