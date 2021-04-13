DEFINE vhtmlpage='list_purge_recyclebin01_'
DEFINE vtitlethispage='List of itens in dba_recyclebin'
DEFINE viconthispage='trash.svg'
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


PRO        data.addColumn('string', 'Name');;
PRO        data.addColumn('string', 'Original Name');;
PRO        data.addColumn('string', 'Type');;
PRO        data.addColumn('string', 'Undo');;
PRO        data.addColumn('string', 'Purge');;
PRO        data.addColumn('string', 'Droptime');;
PRO        data.addRows([

SELECT decode(rownum,1,'[',',[') ||
'''' || OBJECT_NAME     ||'''' ||','||
'''' ||ORIGINAL_NAME||'''' ||','||
'''' ||type||'''' ||','||
'''' ||und||'''' ||','||
'''' ||pur||'''' ||','||
'''' ||DROPTIME     ||'''' ||
       ']'
from (
select object_name, original_name, type, can_undrop as "UND", can_purge as "PUR", droptime from recyclebin
)

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
PRO   <body>PRO
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>
PRO     <div id="table_div" style="width: 400px; height: 500px;"></div>
PRO     <p>&varhtmlspace</p>
PRO
PRO
PRO     <h2>  Purge commands </h2>
PRO
PRO <PRE>
PRO
PRO PURGE DBA_RECYCLEBIN;

PRO -- From current session:
PRO Show recyclebin
PRO
PRO select * from user_recyclebin;
PRO
PRO --From SYSDBA user
PRO Select * from dba_recyclebin;
PRO
PRO Purge the recyclebin from current session
PRO
PRO --Remove only one object from current user:
PRO PURGE TABLE test;
PRO
PRO -- Remove all objects from current user:
PRO PURGE RECYCLEBIN;
PRO
PRO Purge all dropped object from recycle-bin for all user with SYSDBA
PRO
PRO PURGE DBA_RECYCLEBIN;
PRO


PRO alter system set recyclebin=off scope=spfile;
PRO --shutdown immediate
PRO -- startup
PRO purge recyclebin;
PRO purge dba_recyclebin;
PRO show recyclebin
PRO show dba_recyclebin
PRO select count(*) from sys.RECYCLEBIN$;
PRO select OBJ#,OWNER#,SPACE,ORIGINAL_NAME,PURGEOBJ from sys.RECYCLEBIN$;
PRO truncate table sys.RECYCLEBIN$;
PRO execute dbms_stats.gather_table_stats('SYS','RECYCLEBIN$');
PRO show recyclebin
PRO show dba_recyclebin
PRO select count(*) from sys.RECYCLEBIN$;
PRO select OBJ#,OWNER#,SPACE,ORIGINAL_NAME,PURGEOBJ from sys.RECYCLEBIN$;
PRO purge recyclebin;
PRO purge dba_recyclebin;
PRO show recyclebin
PRO show dba_recyclebin
PRO select count(*) from sys.RECYCLEBIN$;
PRO select OBJ#,OWNER#,SPACE,ORIGINAL_NAME,PURGEOBJ from sys.RECYCLEBIN$;
PRO alter system set recyclebin=on scope=spfile;
PRO shutdown immediate
PRO startup
PRO spool off
PRO
PRO </PRE>
PRO <p>&varhtmlspace</p>

@report/sql/footerhtml01
