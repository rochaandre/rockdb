DEFINE vhtmlpage='list_corruptblock_'
DEFINE vtitlethispage='Corrupted blocks'
DEFINE viconthispage='block.svg'
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
PRO        data.addColumn('string', 'Owner');;
PRO        data.addColumn('string', 'Seg Type');;
PRO        data.addColumn('string', 'Name');;
PRO        data.addColumn('string', 'Part');;
PRO        data.addColumn('string', 'File');;
PRO        data.addColumn('string', 'Startblk');;
PRO        data.addColumn('string', 'Endblk');;
PRO        data.addColumn('string', 'BlkCorrupted');;
PRO        data.addColumn('string', 'Description');;
PRO        data.addRows([


    SELECT decode(rownum,1,'[',',[') ||
          '''' ||owner||'''' ||
          ','||'''' ||segment_type||''''||
          ','||'''' ||segment_name||''''||
          ','||'''' ||partition_name||''''||
          ','||'''' ||files||''''||
          ','||'''' ||startblk||''''||
          ','||'''' ||end_block||''''||
          ','||'''' ||blocks_corrupted||''''||
          ','||'''' ||description||''''||
          ']' output
   from (
     SELECT e.owner, e.segment_type, e.segment_name, e.partition_name
         , c.file# files
         , greatest(e.block_id, c.block#) startblk
         , least(e.block_id+e.blocks-1, c.block#+c.blocks-1) end_block
         , least(e.block_id+e.blocks-1, c.block#+c.blocks-1)
           - greatest(e.block_id, c.block#) + 1 blocks_corrupted
         , null description
      FROM dba_extents e, v$database_block_corruption c
     WHERE e.file_id = c.file#
       AND e.block_id <= c.block# + c.blocks - 1
       AND e.block_id + e.blocks - 1 >= c.block#
    UNION
    SELECT s.owner, s.segment_type, s.segment_name, s.partition_name, c.file#
         , header_block corr_start_block#
         , header_block corr_end_block#
         , 1 blocks_corrupted
         , 'Segment Header' description
      FROM dba_segments s, v$database_block_corruption c
     WHERE s.header_file = c.file#
       AND s.header_block between c.block# and c.block# + c.blocks - 1
    UNION
    SELECT null owner, null segment_type, null segment_name, null partition_name, c.file#
         , greatest(f.block_id, c.block#) corr_start_block#
         , least(f.block_id+f.blocks-1, c.block#+c.blocks-1) corr_end_block#
         , least(f.block_id+f.blocks-1, c.block#+c.blocks-1)
           - greatest(f.block_id, c.block#) + 1 blocks_corrupted
         , 'Free Block' description
      FROM dba_free_space f, v$database_block_corruption c
     WHERE f.file_id = c.file#
       AND f.block_id <= c.block# + c.blocks - 1
       AND f.block_id + f.blocks - 1 >= c.block#
    order by file#, corr_start_block#
   )
   )
/
PRO        ]);;
PRO
PRO        var table = new google.visualization.Table(document.getElementById('table_div01'));
PRO
PRO var formatColor = new google.visualization.ColorFormat();
PRO    formatColor.addRange('TRUE', 'TRUE ', 'white', 'red');
PRO    formatColor.addRange(1000, 1001, 'white', 'green');
PRO    formatColor.format(data, 2);
PRO        table.draw(data, {allowHtml: true, showRowNumber: false, width: '100%', height: '100%'});
PRO      }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>
PRO     <div id="table_div01" style="width: 900px; height: 750px;"></div>
PRO  <h4> reference http://appsdbafix.blogspot.com/2013/01/how-to-identify-all-corrupted-objects.html </h4>
PRO     <p>&varhtmlspace</p>
PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
