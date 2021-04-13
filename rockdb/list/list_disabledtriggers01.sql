DEFINE vhtmlpage='list_disabledtriggers01_'
DEFINE vtitlethispage='List of disabled triggers'
DEFINE viconthispage='server.svg'
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
PRO        data.addColumn('string', 'owner');;
PRO        data.addColumn('string', 'Name');;
PRO        data.addColumn('string', 'Type');;
PRO        data.addColumn('string', 'Table owner');;
PRO        data.addColumn('string', 'Table name');;
PRO        data.addColumn('string', 'Event');;
PRO        data.addRows([

SELECT decode(rownum,1,'[',',[') ||
'''' || owner     ||'''' ||','||
'''' ||trigger_name||'''' ||','||
'''' ||trigger_type||'''' ||','||
'''' ||table_owner||'''' ||','||
'''' ||table_name||'''' ||','||
'''' ||TRIGGERING_EVENT     ||'''' ||
       ']'
from (
  SELECT owner, trigger_name, trigger_type, table_owner, table_name, TRIGGERING_EVENT
  from dba_triggers
  where status ='DISABLED'
order by 1
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
PRO        table.draw(data, {allowHtml: true, showRowNumber: true, width: '100%', height: '100%'});
PRO      }
PRO
PRO     </script>
PRO   </head>
PRO   <body>
PRO <p>&varhtmlspace</p>
PRO
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>
PRO     <div id="table_div" style="width: 900px; height: 500px;"></div>
PRO
PRO
PRO
PRO
PRO     <h2>  Disabled triggers Total </h2>
PRO
PRO <PRE>
SELECT  owner, count(*) total
from dba_triggers
where status ='DISABLED'
GROUP BY  owner
/
PRO
PRO <PRE>
PRO
@report/sql/footerhtml01
