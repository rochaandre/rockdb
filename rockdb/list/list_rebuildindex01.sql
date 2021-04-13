DEFINE vhtmlpage='list_rebuildindex01_'
DEFINE vtitlethispage='List of candidates index to rebuild'
DEFINE viconthispage='bookshelf.svg'
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



PRO        data.addColumn('string', 'Owner');;
PRO        data.addColumn('string', 'Index name');;
PRO        data.addColumn('string', 'factor');;
PRO        data.addRows([

SELECT decode(rownum,1,'[',',[') ||
       '''' || OWNER     ||'''' ||','||
       '''' || index_name     ||'''' ||','||
       '''' ||factor     ||'''' ||
       ']'
from (

  SELECT di.OWNER , di.index_name,
       trunc((dt.num_rows / di.clustering_factor) /
             (dt.num_rows / dt.blocks),2) factor,
             'alter index ' ||  dt.owner ||'.'|| di.INDEX_NAME ||' rebuild tablespace '|| di.TABLESPACE_NAME ||' online;' rebuild
  FROM dba_indexes di, dba_tables dt, dba_constraints dc
 WHERE di.table_name = dt.table_name
   AND dt.table_name = dc.table_name
   AND di.index_name = dc.index_name
   AND di.owner = dc.OWNER
   AND dt.OWNER = dc.OWNER
   AND dc.CONSTRAINT_TYPE = 'P'
   AND  dt.blocks >0
   AND di.clustering_factor>0
   AND trunc((dt.num_rows / di.clustering_factor) /
             (dt.num_rows / dt.blocks),2) <= 0.75
   AND dt.owner NOT IN
   ('SYS','SYSMAN','SYSTEM','GGUSER', 'XS$NULL','ORACLE_OCM','APEX_PUBLIC_USER','DIP','DBAJOBS','SYSMAN','DBSNMP','SI_INFORMTN_SCHEMA','APEX_030200','APEX_040000','ORDPLUGINS','APPQOSSYS','XDB','WMSYS','EXFSYS','ANONYMOUS','CTXSYS','ORDSYS','ORDDATA','MDSYS','FLOWS_FILES','MGMT_VIEW','OUTLN','SH','OE','PM','BI','OLAPSYS','IX','SCOTT','HR','PM','OWBSYS','ORAINT','LBACSYS','APPQOSSYS','GSMCATUSER','MDDATA','DBSFWUSER','SYSBACKUP','REMOTE_SCHEDULER_AGENT','GGSYS','ANONYMOUS','GSMUSER','SYSRAC','CTXSYS','ORDS_PUBLIC_USER','OJVMSYS',
   'DV','SI_INFORMTN_SCHEMA','DVSYS','AUDSYS','C##DBAAS_BACKUP','GSMADMIN_INTERNAL','ORDPLUGINS','DIP','LBACSYS','MDSYS','OLAPSYS','ORDDATA','SYSKM','OUTLN','SYS$UMF','ORACLE_OCM','XDB','WMSYS','ORDSYS','SYSDG','PYQSYS','C##CLOUD$SERVICE','C##ADP$SERVICE','ORDS_METADATA','C##OMLIDM','OML$MODELS','ORDS_PLSQL_GATEWAY','APEX_200200','GRAPH$METADATA','C##CLOUD_OPS','SSB','C##API','OMLMOD$PROXY','C##DV_ACCT_ADMIN','APEX_INSTANCE_ADMIN_USER','RMAN$CATALOG','C##DV_OWNER','GRAPH$PROXY_USER','OML$PROXY')
   ORDER BY factor  )
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
PRO     <p>&varhtmlspace</p>
PRO     <h1> &vtitlethispage </h1>
PRO     <div id="table_div" style="width: 900px; height: 500px;"></div>
PRO     <h2>  Criteria </h2>
PRO <PRE>
PRO VALUE ABOVE 0.75           - DOES NOT REQUIRE REORG
PRO VALUE BETWEEN 0.5 AND 0.75 - REORG IS RECOMMENDED
PRO VALUE LOWER THAN 0.5       - IT IS HIGHLY RECOMMENDED TO REORG
PRO
PRO
PRO To gather table stats with 100% sampling:
PRO
PRO exec dbms_stats.gather_table_stats('owner','Table_Name',estimate_percent => 100, cascade=>true, method_opt=>'for all columns size AUTO');
PRO
PRO Oracle 10g and 11g : "FOR ALL COLUMNS SIZE AUTO" - This setting means that DBMS_STATS decides which columns to add histogram to where it believes that they may help to produce a better plan.
PRO
PRO
PRO Gathering statistics for all objects in a schema:
PRO
PRO exec dbms_stats.gather_schema_stats(ownname => 'schema_name ',cascade => TRUE,method_opt => 'FOR ALL COLUMNS SIZE AUTO' );
PRO
PRO Ref: Oracle support Doc ID : 1587179.1
PRO



select distinct 'exec dbms_stats.gather_schema_stats(ownname => '||''''|| owner ||''''||
  ',cascade => TRUE,method_opt => '||''''||'FOR ALL COLUMNS SIZE AUTO' ||''''||'); '
from dba_tables
where owner NOT IN
('SYS','SYSMAN','SYSTEM','GGUSER', 'XS$NULL','ORACLE_OCM','APEX_PUBLIC_USER','DIP','DBAJOBS','SYSMAN','DBSNMP','SI_INFORMTN_SCHEMA','APEX_030200','APEX_040000','ORDPLUGINS','APPQOSSYS','XDB','WMSYS','EXFSYS','ANONYMOUS','CTXSYS','ORDSYS','ORDDATA','MDSYS','FLOWS_FILES','MGMT_VIEW','OUTLN','SH','OE','PM','BI','OLAPSYS','IX','SCOTT','HR','PM','OWBSYS','ORAINT','LBACSYS','APPQOSSYS','GSMCATUSER','MDDATA','DBSFWUSER','SYSBACKUP','REMOTE_SCHEDULER_AGENT','GGSYS','ANONYMOUS','GSMUSER','SYSRAC','CTXSYS','ORDS_PUBLIC_USER','OJVMSYS',
'DV','SI_INFORMTN_SCHEMA','DVSYS','AUDSYS','C##DBAAS_BACKUP','GSMADMIN_INTERNAL','ORDPLUGINS','DIP','LBACSYS','MDSYS','OLAPSYS','ORDDATA','SYSKM','OUTLN','SYS$UMF','ORACLE_OCM','XDB','WMSYS','ORDSYS','SYSDG','PYQSYS','C##CLOUD$SERVICE','C##ADP$SERVICE','ORDS_METADATA','C##OMLIDM','OML$MODELS','ORDS_PLSQL_GATEWAY','APEX_200200','GRAPH$METADATA','C##CLOUD_OPS','SSB','C##API','OMLMOD$PROXY','C##DV_ACCT_ADMIN','APEX_INSTANCE_ADMIN_USER','RMAN$CATALOG','C##DV_OWNER','GRAPH$PROXY_USER','OML$PROXY')
;
PRO ---- INDEXES REBUILD
PRO
PRO

select
   'alter index ' ||  dt.owner ||'.'|| di.INDEX_NAME ||' rebuild tablespace '|| di.TABLESPACE_NAME ||' online;' rebuild
  FROM dba_indexes di, dba_tables dt, dba_constraints dc
 WHERE di.table_name = dt.table_name
   AND dt.table_name = dc.table_name
   AND di.index_name = dc.index_name
   AND di.owner = dc.OWNER
   AND dt.OWNER = dc.OWNER
   AND dc.CONSTRAINT_TYPE = 'P'
   AND  dt.blocks >0
   AND di.clustering_factor>0
   AND   trunc((dt.num_rows / di.clustering_factor) / (dt.num_rows / dt.blocks),2) <=0.75
ORDER BY   dt.owner, di.INDEX_NAME
/
PRO </PRE>

PRO     <p>&varhtmlspace</p>
PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
