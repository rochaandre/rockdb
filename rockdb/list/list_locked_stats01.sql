DEFINE vhtmlpage='list_locked_stats01_'
DEFINE vtitlethispage='List locked objects'
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
PRO        data.addColumn('string', 'Table name');;
PRO        data.addColumn('string', 'Locked');;

PRO        data.addRows([

 SELECT decode(rownum,1,'[',',[') ||
        '''' ||owner||'''' ||
        ','||'''' ||table_name||''''||
        ','||'''' ||stattype_locked||''''||
        ']' output
 from (
select owner, table_name, stattype_locked
from dba_tab_statistics
where stattype_locked is not null
AND owner NOT IN
('SYS','SYSMAN','SYSTEM','GGUSER', 'XS$NULL','ORACLE_OCM','APEX_PUBLIC_USER','DIP','DBAJOBS','SYSMAN','DBSNMP','SI_INFORMTN_SCHEMA','APEX_030200','APEX_040000','ORDPLUGINS','APPQOSSYS','XDB','WMSYS','EXFSYS','ANONYMOUS','CTXSYS','ORDSYS','ORDDATA','MDSYS','FLOWS_FILES','MGMT_VIEW','OUTLN','SH','OE','PM','BI','OLAPSYS','IX','SCOTT','HR','PM','OWBSYS','ORAINT','LBACSYS','APPQOSSYS','GSMCATUSER','MDDATA','DBSFWUSER','SYSBACKUP','REMOTE_SCHEDULER_AGENT','GGSYS','ANONYMOUS','GSMUSER','SYSRAC','CTXSYS','ORDS_PUBLIC_USER','OJVMSYS',
'DV','SI_INFORMTN_SCHEMA','DVSYS','AUDSYS','C##DBAAS_BACKUP','GSMADMIN_INTERNAL','ORDPLUGINS','DIP','LBACSYS','MDSYS','OLAPSYS','ORDDATA','SYSKM','OUTLN','SYS$UMF','ORACLE_OCM','XDB','WMSYS','ORDSYS','SYSDG','PYQSYS','C##CLOUD$SERVICE','C##ADP$SERVICE','ORDS_METADATA','C##OMLIDM','OML$MODELS','ORDS_PLSQL_GATEWAY','APEX_200200','GRAPH$METADATA','C##CLOUD_OPS','SSB','C##API','OMLMOD$PROXY','C##DV_ACCT_ADMIN','APEX_INSTANCE_ADMIN_USER','RMAN$CATALOG','C##DV_OWNER','GRAPH$PROXY_USER','OML$PROXY')
union all
select owner, table_name, stattype_locked
from dba_tab_statistics
where stattype_locked is not null
AND owner  IN
('SYS','SYSMAN','SYSTEM','GGUSER', 'XS$NULL','ORACLE_OCM','APEX_PUBLIC_USER','DIP','DBAJOBS','SYSMAN','DBSNMP','SI_INFORMTN_SCHEMA','APEX_030200','APEX_040000','ORDPLUGINS','APPQOSSYS','XDB','WMSYS','EXFSYS','ANONYMOUS','CTXSYS','ORDSYS','ORDDATA','MDSYS','FLOWS_FILES','MGMT_VIEW','OUTLN','SH','OE','PM','BI','OLAPSYS','IX','SCOTT','HR','PM','OWBSYS','ORAINT','LBACSYS','APPQOSSYS','GSMCATUSER','MDDATA','DBSFWUSER','SYSBACKUP','REMOTE_SCHEDULER_AGENT','GGSYS','ANONYMOUS','GSMUSER','SYSRAC','CTXSYS','ORDS_PUBLIC_USER','OJVMSYS',
  'DV','SI_INFORMTN_SCHEMA','DVSYS','AUDSYS','C##DBAAS_BACKUP','GSMADMIN_INTERNAL','ORDPLUGINS','DIP','LBACSYS','MDSYS','OLAPSYS','ORDDATA','SYSKM','OUTLN','SYS$UMF','ORACLE_OCM','XDB','WMSYS','ORDSYS','SYSDG','PYQSYS','C##CLOUD$SERVICE','C##ADP$SERVICE','ORDS_METADATA','C##OMLIDM','OML$MODELS','ORDS_PLSQL_GATEWAY','APEX_200200','GRAPH$METADATA','C##CLOUD_OPS','SSB','C##API','OMLMOD$PROXY','C##DV_ACCT_ADMIN','APEX_INSTANCE_ADMIN_USER','RMAN$CATALOG','C##DV_OWNER','GRAPH$PROXY_USER','OML$PROXY')
 )
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
PRO     </script>
PRO   </head>
PRO   <body>
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>
PRO     <div id="table_divparam" style="width: 900px; height: 100%;"></div>
PRO     <p>&varhtmlspace</p>
PRO   </body>
PRO </html>
@report/sql/footerhtml01
