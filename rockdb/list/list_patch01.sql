DEFINE vhtmlpage='list_patch01_'
DEFINE vtitlethispage='Check Patch already applied'
DEFINE viconthispage='patch.svg'
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
PRO        data.addColumn('string', 'Action_time');;
PRO        data.addColumn('string', 'Action');;
PRO        data.addColumn('string', 'Namespace');;
PRO        data.addColumn('string', 'Version');;
PRO        data.addColumn('string', 'Comments');;
PRO        data.addColumn('string', 'Patch ID');;
PRO        data.addColumn('string', 'Bundle_series');;
PRO        data.addRows([

  SELECT decode(rownum,1,'[',',[') ||
        '''' ||action_time||'''' ||
        ','||'''' ||action||''''||
        ','||'''' ||namespace_STATUS||''''||
        ','||'''' ||description_version||''''||
        ','||'''' ||comments_version||''''||
        ','||'''' ||patch_id||''''||
        ','||'''' ||bundle_series||''''||
        ']' output
 from (
   SELECT TO_CHAR(action_time, 'DD-MON-YYYY HH24:MI:SS') AS action_time,
          action,
          namespace namespace_STATUS,
          version description_version,
          comments comments_version,
          ID patch_id,
          bundle_series
   FROM   sys.registry$history
   ORDER by action_time
 )
 &varskip_11g_column UNION ALL
 &varskip_11g_column SELECT decode(rownum,1,'[',',[') ||
 &varskip_11g_column      '''' ||action_time||'''' ||
 &varskip_11g_column      ','||'''' ||action||''''||
 &varskip_11g_column      ','||'''' ||namespace_STATUS||''''||
 &varskip_11g_column      ','||'''' ||description||''''||
 &varskip_11g_column      ','||'''' ||version||''''||
 &varskip_11g_column      ','||'''' ||bundle_series||''''||
 &varskip_11g_column      ']' output  from (
 &varskip_11g_column SELECT TO_CHAR(action_time, 'DD-MON-YYYY HH24:MI:SS') AS action_time,  action, status namespace_STATUS,
 &varskip_11g_column description|| ' '||version comments_version, patch_id, bundle_series FROM   sys.dba_registry_sqlpatch ORDER by action_time )

/
PRO        ]);;
PRO


PRO        var table = new google.visualization.Table(document.getElementById('table_div01'));
 PRO
PRO var formatColor = new google.visualization.ColorFormat();
PRO    formatColor.addRange('TRUE', 'TRUE ', 'white', 'red');
PRO    formatColor.addRange(1000, 1001, 'white', 'green');
PRO    formatColor.format(data, 2);
PRO     table.draw(data, {allowHtml: true, showRowNumber: false, width: '100%', height: '100%'});
PRO      }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>
PRO     <div id="table_div01" style="width: 900px; height: 350px;"></div>
PRO     <p>&varhtmlspace</p>

PRO     <p>&varhtmlspace</p>

PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
