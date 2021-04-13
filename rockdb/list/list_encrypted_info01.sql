DEFINE vhtmlpage='list_encrypted_info01_'
DEFINE vtitlethispage='List of encrypt'
DEFINE viconthispage='shield-check.svg'
@report/sql/headerhtmlspool.sql


PRO <html>
PRO   <head>
PRO     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
PRO     <script type="text/javascript">
PRO      google.charts.load('current', {'packages':['table']});
PRO      google.charts.setOnLoadCallback(drawTable);
PRO
PRO      function drawTable() {
PRO        var data = new google.visualization.DataTable();
PRO        data.addColumn('string', 'Description');;
PRO        data.addColumn('string', 'Properties');;
PRO        data.addRows([

SELECT decode(rownum,1,'[',',[') ||
       '''' ||label||'''' ||
       ','||'''' ||value||''''||
       ']' output
from (
  SELECT 'Encrypted Tablespaces' label,  decode(total,0,'NO','YES') value
 FROM (
 SELECT count(*) total
 FROM dba_tablespaces
 WHERE encrypted ='YES'
 )
 UNION all
 SELECT 'Encrypted Columns' lbl,  decode(total,0,'NO','YES') value
 FROM (
 SELECT count(*) total
 FROM dba_encrypted_columns
 )
 UNION all
 select 'Wallet' lbl, WRL_TYPE || ' '  || WRL_PARAMETER || ' Status '|| status value
 FROM v$encryption_wallet
 UNION ALL
 SELECT 'Encrypted tablespace ' lbl, tablespace_name value
 FROM dba_tablespaces
 WHERE encrypted ='YES'
 UNION ALL
 SELECT 'Table column encrypted ' lbl, table_name ||' ' ||  COLUMN_name value
 FROM dba_encrypted_columns
union all
select * from (
 SELECT a.acl,
                    a.host ||' ' ||
                    a.lower_port ||' ' ||
                    a.upper_port ||' ' ||
                    b.principal ||' ' ||
                    b.privilege ||' ' ||
                    b.is_grant ||' ' ||
                    b.start_date ||' ' ||
                    b.end_date
             FROM   dba_network_acls a
                    JOIN dba_network_acl_privileges b ON a.acl = b.acl
             ORDER BY a.acl, a.host, a.lower_port, a.upper_port
  )
)
/
PRO        ]);;
PRO
PRO        var table = new google.visualization.Table(document.getElementById('table_div'));
PRO
PRO var formatColor = new google.visualization.ColorFormat();
PRO    formatColor.addRange('FAILED', 'FAILED ', 'white', 'red');
PRO    formatColor.addRange(1000, 1001, 'white', 'green');
PRO    formatColor.format(data, 1);
PRO        table.draw(data, {allowHtml: true, showRowNumber: false, width: '100%', height: '100%'});
PRO      }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>
PRO     <div id="table_div" style="width: 900px; height: 450px;"></div>
PRO     <p>&varhtmlspace</p>
PRO   </body>
PRO </html>
@report/sql/footerhtml01
