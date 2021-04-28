set define off

DEFINE vthispage='index_page'
DEFINE vtitlethispage='Title Page'
DEFINE viconthispage='icon.gif'
DEFINE vhifen='-'

DEFINE vasmdatdest='+DATAC1'
DEFINE vasmfradest='+RECOC1'

ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ".,";
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'DD/MM/YYYY HH24:MI';
DEF varhtmlspace = '&nbsp;';
DEF varhtmlaspasdu = '"';
set define on
DEF varnewline    = '<BR>';
DEF varformatdata = 'DD/MM/YYYY HH24:MI';
DEF varicon       = 'favicon.ico';
DEF varYYYYMMDD   = '20210301';


-- PERFORMANCE USAGE internal views
-- to skip comment the select below.
DEF varskip_pt_column = '-- notused ';
COL varskip_pt_column NEW_V varskip_pt_column;
DEF varskip_pt_script = ' echo notused ';
COL varskip_pt_script NEW_V varskip_pt_script;


SELECT null varskip_pt_column,  null varskip_pt_script
  FROM dba_feature_usage_statistics
  WHERE LAST_USAGE_DATE >= sysdate-365
  AND name IN (  'Awr Report','Automatic SQL Tuning Advisor','Automatic Segment Space Management (user)')
  and rownum <=1;

-- Check if you dont use performance tunning operation disable it:


---- END
/*
'SYS','SYSMAN','SYSTEM','GGUSER', 'XS$NULL','ORACLE_OCM','APEX_PUBLIC_USER','DIP','DBAJOBS','SYSMAN','DBSNMP','SI_INFORMTN_SCHEMA','APEX_030200','APEX_040000','ORDPLUGINS','APPQOSSYS','XDB','WMSYS','EXFSYS','ANONYMOUS','CTXSYS','ORDSYS','ORDDATA','MDSYS','FLOWS_FILES','MGMT_VIEW','OUTLN','SH','OE','PM','BI','OLAPSYS','IX','SCOTT','HR','PM','OWBSYS','ORAINT','LBACSYS','APPQOSSYS','GSMCATUSER','MDDATA','DBSFWUSER','SYSBACKUP','REMOTE_SCHEDULER_AGENT','GGSYS','ANONYMOUS','GSMUSER','SYSRAC','CTXSYS','ORDS_PUBLIC_USER','OJVMSYS',
'DV','SI_INFORMTN_SCHEMA','DVSYS','AUDSYS','C##DBAAS_BACKUP','GSMADMIN_INTERNAL','ORDPLUGINS','DIP','LBACSYS','MDSYS','OLAPSYS','ORDDATA','SYSKM','OUTLN','SYS$UMF','ORACLE_OCM','XDB','WMSYS','ORDSYS','SYSDG','PYQSYS','C##CLOUD$SERVICE','C##ADP$SERVICE','ORDS_METADATA','C##OMLIDM','OML$MODELS','ORDS_PLSQL_GATEWAY','APEX_200200','GRAPH$METADATA','C##CLOUD_OPS','SSB','C##API','OMLMOD$PROXY','C##DV_ACCT_ADMIN','APEX_INSTANCE_ADMIN_USER','RMAN$CATALOG','C##DV_OWNER','GRAPH$PROXY_USER','OML$PROXY'
,'APEX_190200','APEX_LISTENER','APEX_REST_PUBLIC_USER'
*/

DEF varTIMESTAMP = '';
COL varTIMESTAMP NEW_V varTIMESTAMP;

DEF varYYYYMMDD = '';
COL dateYYYYMMDD NEW_VALUE varYYYYMMDD
SELECT  to_char(sysdate,'YYYYMMDD') dateYYYYMMDD, to_char(sysdate,'DD/MM/YYYY HH24:MI') varTIMESTAMP
FROM dual;


DEF sskiplinux= '';
DEF sskipdos= '';
COL csskiplinux NEW_VALUE sskiplinux
COL csskipdos NEW_VALUE sskipdos



select
decode (trim( '&varSLASH'),'\',' echo ',null) csskiplinux,
decode (trim('&varSLASH'),'/',' echo ',null)  csskipdos, trim( '&varSLASH') sla
from dual;

DEF var_instancename = '';
COL instancename NEW_VALUE var_instancename
DEF var_outputfolder = '';
COL outputfolder NEW_VALUE var_outputfolder
DEF var_datenow = '';
COL newdate NEW_VALUE var_datenow
SELECT  instance_name var_instancename,
  '&vdirrockdb'||'&varSLASH'||instance_name||substr( version,1,2)||replace(host_name,'.','')  outputfolder,
        to_char(sysdate,'&varformatdata') newdate
FROM v$instance;

host echo  &sskipLINUX
host echo  &sskipdos
host echo  &var_outputfolder

host &sskipLINUX mkdir -p &var_outputfolder/charts
host &sskipLINUX cp -r rockdb/thirdparty/charts/*  &var_outputfolder/charts
host &sskipLINUX mkdir -p &var_outputfolder/css
host &sskipLINUX cp -r rockdb/css/* &var_outputfolder/css
host &sskipLINUX mkdir -p &var_outputfolder/icon
host &sskipLINUX cp -r rockdb/icon/* &var_outputfolder/icon

host &sskipdos mkdir &var_outputfolder\charts
host &sskipdos copy /Y rockdb\thirdparty\charts\*  &var_outputfolder\charts
host &sskipdos mkdir &var_outputfolder\css
host &sskipdos copy /Y  rockdb\css\* &var_outputfolder\css
host &sskipdos mkdir &var_outputfolder\icon
host &sskipdos copy /Y  rockdb\icon\* &var_outputfolder\icon


DEF var_namefile = '';
COL completefilename NEW_VALUE var_namefile
SELECT  instance_name||substr( version,1,2) ||'.html' completefilename
FROM v$instance;
DEFINE vmainfile='index_&var_namefile'


-- skip
DEF var_currversion = '';
COL currversion NEW_VALUE var_currversion
SELECT  substr( version,1,2) currversion
FROM v$instance;
-- skip
DEF varskip_10g_column = '';
COL varskip_10g_column NEW_V varskip_10g_column;
DEF varskip_10g_script = '';
COL varskip_10g_script NEW_V varskip_10g_script;
SELECT ' -- skip 10g ' varskip_10g_column, ' echo skip 10g ' varskip_10g_script FROM v$instance WHERE version LIKE '10%';
--
DEF varskip_11g_column = '';
COL varskip_11g_column NEW_V varskip_11g_column;
DEF varskip_11g_script = '';
COL varskip_11g_script NEW_V varskip_11g_script;
SELECT ' -- skip 11g ' varskip_11g_column, ' echo skip 11g ' varskip_11g_script FROM v$instance WHERE version LIKE '11%' or
version LIKE '10%';
--
DEF varskip_11r1_column = '';
COL varskip_11r1_column NEW_V varskip_11r1_column;
DEF varskip_11r1_script = '';
COL varskip_11r1_script NEW_V varskip_11r1_script;
SELECT ' -- skip 11gR1 ' varskip_11r1_column, ' echo skip 11gR1 ' varskip_11r1_script FROM v$instance WHERE version LIKE '11.1%';
--
DEF varskip_12c_column = '';
COL varskip_12c_column NEW_V varskip_12c_column;
DEF varskip_12c_script = '';
COL varskip_12c_script NEW_V varskip_12c_script;
SELECT ' -- skip 12c ' varskip_12c_column, ' echo skip 12c ' varskip_12c_script FROM v$instance WHERE version LIKE '12%';
--
DEF varskip_12r2_column = '';
COL varskip_12r2_column NEW_V varskip_12r2_column;
DEF varskip_12r2_script = '';
COL varskip_12r2_script NEW_V varskip_12r2_script;
SELECT ' -- skip 12cR2 ' varskip_12r2_column, ' echo skip 12cR2 ' varskip_12r2_script FROM v$instance WHERE version LIKE '12.2%';
--
DEF varskip_18c_column = '';
COL varskip_18c_column NEW_V varskip_18c_column;
DEF varskip_18c_script = '';
COL varskip_18c_script NEW_V varskip_18c_script;
SELECT ' -- skip 18c ' varskip_18c_column, ' echo skip 18c ' varskip_18c_script FROM v$instance WHERE version LIKE '18%';
--
DEF varskip_19c_column = '';
COL varskip_19c_column NEW_V varskip_19c_column;
DEF varskip_19c_script = '';
COL varskip_19c_script NEW_V varskip_19c_script;
SELECT ' -- skip 19c ' varskip_19c_column, ' echo skip 19c ' varskip_19c_script FROM v$instance WHERE version LIKE '19%';

DEF varskip_20c_column = '';
COL varskip_20c_column NEW_V varskip_20c_column;
DEF varskip_20c_script = '';
COL varskip_20c_script NEW_V varskip_20c_script;
SELECT ' -- skip 20c ' varskip_19c_column, ' echo skip 20c ' varskip_20c_script FROM v$instance WHERE version LIKE '20%';


BEGIN
   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SQLTERMINATOR', true);
   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'PRETTY', true);
END;
/


DEF var_internalschemas1 = "'SH','OE','PM','BI','OLAPSYS','IX','SCOTT','HR','PM'";
DEF var_internalschemas2 = "'APEX_030200','APEX_040000','GSMCATUSER','XS$NULL','SYS','SYSTEM','ORACLE_OCM'"
DEF var_internalschemas3 = "'APEX_PUBLIC_USER','DIP','SYSMAN','DBSNMP','SI_INFORMTN_SCHEMA','ORDPLUGINS'"
DEF var_internalschemas4 = "'APPQOSSYS','XDB','WMSYS','EXFSYS','CTXSYS','ORDSYS','ORDDATA','ANONYMOUS','APEX_190200','APEX_INSTANCE_ADMIN_USER','APEX_LISTENER' ,'APEX_PUBLIC_USER','APEX_REST_PUBLIC_USER'"
DEF var_internalschemas5 = "'MDSYS','FLOWS_FILES','MGMT_VIEW','SH','OE','PM','BI','OLAPSYS','IX','SCOTT'"
DEF var_internalschemas6 = "'HR','PM','OWBSYS','ORAINT','LBACSYS','APPQOSSYS','MDDATA','OJVMSYS','DVF'"
DEF var_internalschemas7 = "'SI_INFORMTN_SCHEMA','DVSYS','AUDSYS','C##DBAAS_BACKUP','GSMADMIN_INTERNAL'"
DEF var_internalschemas8 = "'ORDPLUGINS','DIP','LBACSYS','MDSYS','OLAPSYS','ORDDATA','SYSKM','OUTLN'"
DEF var_internalschemas9 = "'ORACLE_OCM','XDB','WMSYS','ORDSYS','OUTLN','SYS$UMF','SYSDG','PYQSYS'"
DEF var_internalschemas10 = "'DBSFWUSER','SYSBACKUP','REMOTE_SCHEDULER_AGENT','GGSYS','GSMUSER','SYSRAC'"
DEF var_internalschemas11 = "'CTXSYS','ANONYMOUS','ORDS_PUBLIC_USER','C##CLOUD$SERVICE','C##ADP$SERVICE'"
DEF var_internalschemas12 = "'ORDS_METADATA','C##OMLIDM','OML$MODELS','ORDS_PLSQL_GATEWAY','APEX_200200'"
DEF var_internalschemas13 = "'GRAPH$METADATA','C##CLOUD_OPS','SSB','C##API','OMLMOD$PROXY','C##DV_ACCT_ADMIN'"
DEF var_internalschemas14 = "'APEX_INSTANCE_ADMIN_USER','RMAN$CATALOG','C##DV_OWNER','GRAPH$PROXY_USER','OML$PROXY','APEX_190200','APEX_LISTENER','APEX_REST_PUBLIC_USER'"


/*
 select distinct 'exclude=SCHEMA:"='||''''||owner||''''||'"'  excludetext
from dba_tables
where 1=1 -- tablespace_name is null
and owner not in ('SYS','SYSTEM','ANONYMOUS','CTXSYS','HR','MDSYS','ODM','ODM_MTR','OE',
'OLAPSYS','ORDPLUGINS','ORDSYS','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS',
'QS_WS','SCOTT','SH','WKPROXY','WKSYS','WMSYS','XDB','DBSNMP','SYSMAN','MGMT_VIEW','SI_INFORMTN_SCHEMA',
'DMSYS','DIP','OUTLN','EXFSYS','MDDATA','TSMSYS','APEX_PUBLIC_USER','FLOWS_FILES','OWBSYS','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR',
'XS$NULL','APEX_030200','APPQOSSYS','ORDDATA','OWBSYS_AUDIT','ORACLE_OCM',
'AUDSYS','GSMADMIN_INTERNAL','OJVMSYS','DBSFWUSER','GGSYS')
*/
