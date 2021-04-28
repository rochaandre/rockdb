DEFINE vhtmlpage='impdp_script_create01_'
DEFINE vtitlethispage='script for impdp '
DEFINE viconthispage='server.svg'
@rockdb/sql/headerhtmlspool.sql

PRO <PRE>
PRO +------------------------------------------------------------------------------+
PRO |    Create tablespace BEFORE import data                                      |
PRO +------------------------------------------------------------------------------+
PRO
PRO create view sys.v_x$ktfbue as select * from sys.x$ktfbue;
PRO grant select on sys.v_x$ktfbue  to public;
PRO
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
  where  name not in  ('SYSTEM','SYSAUX','UNDOTBS1')
 ),
 hwmdf as (
  -- join with datafiles, put 5M minimum for datafiles with no extents
  select tablespace_name, file_name,nvl(hwm_blocks*(bytes/blocks),5*1024*1024) hwm_bytes,bytes,
   case
  when ceil(bytes/1024/1024) < 1000 then round( ceil(bytes/1024/1024)*.05,-1)
  when (ceil(bytes/1024/1024) between 1000  and 20000) then round( ceil(bytes/1024/1024)*.02,-1)
  when ceil(bytes/1024/1024) >  20000 then  round( ceil(bytes/1024/1024)*.01,-2)
 end tamadd ,
  autoextensible,maxbytes
  from hwmts right join dba_data_files using(tablespace_name,relative_fno)
  where  tablespace_name not in  ('SYSTEM','SYSAUX','UNDOTBS1')
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
union all
select
 'create tablespace '||tablespace_name||' datafile '||''''||'+DATAC1'||''''||' size '|| to_char(ceil(hwm_bytes/1024/1024)+tamadd,999999)||'M autoextend on next '|| tamadd  ||'M;' createtbs
from hwmdf
/




PRO
PRO +------------------------------------------------------------------------------+
PRO |     Evaluate the use of NETWORK_LINK parameter                               |
PRO +------------------------------------------------------------------------------+
PRO
PRO This will not produce file and I/O in filesystem and will be more faster
PRO
PRO +------------------------------------------------------------------------------+
PRO |     Increase UNDO tablespace size  -                                         |
PRO |     recreate it - after finish the import to reduce the size                 |
PRO +------------------------------------------------------------------------------+
PRO
PRO alter tablespace UNDOTBS1 add datafile size 10G autoextend on;
PRO alter tablespace UNDOTBS1 add datafile size 10G autoextend on;
PRO alter tablespace UNDOTBS1 add datafile size 10G autoextend on;
PRO
PRO +------------------------------------------------------------------------------+
PRO |     Increase TEMP                                                            |
PRO +------------------------------------------------------------------------------+
PRO
PRO alter tablespace TEMP add datafile size 10G autoextend on;
PRO alter tablespace TEMP add datafile size 10G autoextend on;
PRO alter tablespace TEMP add datafile size 10G autoextend on;
PRO
PRO +------------------------------------------------------------------------------+
PRO |     Check parallel                                                           |
PRO +------------------------------------------------------------------------------+
PRO
PRO alter system set parallel_servers_target=48;
PRO alter system set parallel_max_servers=128;
PRO

PRO +------------------------------------------------------------------------------+
PRO |     Disable logging - add this import parameter                              |
PRO +------------------------------------------------------------------------------+
PRO
PRO If you database dont have force loggin you can use :  transform=disable_archive_logging:y:index
PRO transform=disable_archive_logging:y
PRO Disable logging - You can also use the hidden parameter _disable_logging = true (if this is not production)
PRO



PRO +------------------------------------------------------------------------------+
PRO |     Increase PGA  to a big value                                             |
PRO +------------------------------------------------------------------------------+
PRO
PRO alter system set pga_aggregate_target=50G scope=both;
PRO
PRO +------------------------------------------------------------------------------+
PRO |     General commands to be executed before impdp                             |
PRO +------------------------------------------------------------------------------+
PRO
PRO alter database noarchivelog;
PRO alter tablespace temp add tempfile;
PRO alter tablespace temp add tempfile;
PRO alter tablespace UNDO add datafile;
PRO
PRO -- Parameters based in max values used
PRO
SELECT 'alter system set '||RESOURCE_NAME ||'='||MAX_UTILIZATION||' scope=spfile;'
FROM "V$RESOURCE_LIMIT"
WHERE resource_name IN ( 'processes','sessions')
/
PRO
PRO -- Parameters based in  values set
PRO
SELECT 'alter system set '||name ||'='||DISPLAY_VALUE||' scope=spfile;'
FROM  v$parameter
WHERE name IN ( 'processes','sessions','sga_target','undo_retention','recycle_bin','audit_trail')
/

PRO Active datapump job sessions status :
PRO
PRO set lines 150 pages 100
PRO numwidth 7
PRO col program for a38
PRO col username for a10
PRO col spid for a7
PRO select to_char(sysdate,’YYYY-MM-DD HH24:MI:SS’) "DATE", s.program, s.sid,
PRO s.status, s.username,d.job_name, p.spid, s.serial#, p.pid,s.eventfrom v$session s,
PRO v$process p, dba_datapump_sessions d
PRO where p.addr=s.paddr and s.saddr=d.saddr;
PRO
PRO Run the following query to monitor the progress of datapump jobs :-
PRO
PRO select
PRO round(sofar/totalwork*100,2) percent_completed,
PRO v$session_longops.*
PRO from
PRO v$session_longops
PRO where
PRO sofar <> totalwork
PRO order by
PRO target,
PRO sid;
PRO
PRO Check current job details and query :
PRO
PRO select x.job_name,b.state,b.job_mode,b.degree, x.owner_name,z.sql_text, p.message, p.totalwork,
PRO p.sofar, round((p.sofar/p.totalwork)*100,2) done, p.time_remaining
PRO from dba_datapump_jobs b left join dba_datapump_sessions x on (x.job_name = b.job_name) left join
PRO v$session y on (y.saddr = x.saddr) left join v$sql z on (y.sql_id = z.sql_id) left join
PRO v$session_longops p ON (p.sql_id = y.sql_id)
PRO WHERE y.module='Data Pump Worker'
PRO AND p.time_remaining > 0;



--SET LONG 20000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
--SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
--SPO &var_instancename/impdp_par01.par
PRO <PRE>
PRO
PRO
PRO +--------------------------------------------+
PRO | Parameter file example: impdp_par01.par    |
PRO +--------------------------------------------+
PRO | Import only APP SCHEMAS                    |
PRO | Exclude all internal schemas               |
PRO +--------------------------------------------+
PRO
PRO impdp parfile=impdp_par01.par
PRO
PRO impdp USERID=&varUSERDBA/&varPASSDBA@&varCONNSTR JOB_NAME=exp_02NOROWSC&var_instancename DUMPFILE=&varDIREXPD/exp_02NOROWSC$varYYYYMMDD%U.dmp LOG=&varDIREXPD:exp_02NOROWSC&varYYYYMMDD.log DIRECTORY=&varDIREXPD FULL=Y rows=n consistent=y
PRO
PRO impdp USERID=&varUSERDBA/&varPASSDBA@&varCONNSTR JOB_NAME=exp_03NOROWSC&var_instancename DUMPFILE=&varDIREXPD/exp_03NOROWSC$varYYYYMMDD%U.dmp LOG=&varDIREXPD:exp_03ROWSC&varYYYYMMDD.log DIRECTORY=&varDIREXPD FULL=Y rows=y consistent=y
PRO
PRO USERID=&varUSERDBA/&varPASSDBA@&varCONNSTR
PRO JOB_NAME=exp_01NOROWSF&var_instancename
PRO DUMPFILE=&var_instancename/exp_01NOROWSF$varYYYYMMDD%U.dmp
PRO LOG=&varDIREXPD:&var_instancename/exp_01NOROWSF&varYYYYMMDD.log
PRO DIRECTORY=&varDIREXPD
PRO FULL=Y
PRO rows=n
PRO consistent=y
PRO CLUSTER=N
PRO PARALLEL=8
PRO transform=disable_archive_logging:y
PRO EXCLUDE=STATISTICS
PRO exclude=SCHEMA:" IN (&var_internalschemas1)"
PRO exclude=SCHEMA:" IN (&var_internalschemas2)"
PRO exclude=SCHEMA:" IN (&var_internalschemas3)"
PRO exclude=SCHEMA:" IN (&var_internalschemas4)"
PRO exclude=SCHEMA:" IN (&var_internalschemas5)"
PRO exclude=SCHEMA:" IN (&var_internalschemas6)"
PRO exclude=SCHEMA:" IN (&var_internalschemas7)"
PRO exclude=SCHEMA:" IN (&var_internalschemas8)"
PRO exclude=SCHEMA:" IN (&var_internalschemas9)"
PRO exclude=SCHEMA:" IN (&var_internalschemas10)"
PRO exclude=SCHEMA:" IN (&var_internalschemas11)"
PRO exclude=SCHEMA:" IN (&var_internalschemas12)"
PRO exclude=SCHEMA:" IN (&var_internalschemas13)"
PRO exclude=SCHEMA:" IN (&var_internalschemas14)"

PRO
PRO
PRO +--------------------------------------------+
PRO | Parameter file example: impdp_par02.par    |
PRO +--------------------------------------------+
PRO | Import only APP SCHEMAS                    |
PRO | Exclude all internal schemas               |
PRO +--------------------------------------------+
PRO
PRO impdp parfile=impdp_par02.par
PRO
PRO
--SET LONG 20000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
--SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
--SPO &var_instancename/impdp_par04.par

PRO USERID=&varUSERDBA/&varPASSDBA@&varCONNSTR
PRO JOB_NAME=exp_02NOROWSF&var_instancename
PRO DUMPFILE=&var_instancename/exp_02NOROWSF$varYYYYMMDD%U.dmp
PRO LOG=&varDIREXPD:&var_instancename/exp_02NOROWSF&varYYYYMMDD.log
PRO DIRECTORY=&varDIREXPD
PRO FULL=Y
PRO rows=Y
PRO transform=disable_archive_logging:y
PRO consistent=y
PRO PARALLEL=8
PRO CLUSTER=N
PRO EXCLUDE=STATISTICS
PRO exclude=SCHEMA:" IN (&var_internalschemas1)"
PRO exclude=SCHEMA:" IN (&var_internalschemas2)"
PRO exclude=SCHEMA:" IN (&var_internalschemas3)"
PRO exclude=SCHEMA:" IN (&var_internalschemas4)"
PRO exclude=SCHEMA:" IN (&var_internalschemas5)"
PRO exclude=SCHEMA:" IN (&var_internalschemas6)"
PRO exclude=SCHEMA:" IN (&var_internalschemas7)"
PRO exclude=SCHEMA:" IN (&var_internalschemas8)"
PRO exclude=SCHEMA:" IN (&var_internalschemas9)"
PRO exclude=SCHEMA:" IN (&var_internalschemas10)"
PRO exclude=SCHEMA:" IN (&var_internalschemas11)"
PRO exclude=SCHEMA:" IN (&var_internalschemas12)"
PRO exclude=SCHEMA:" IN (&var_internalschemas13)"
PRO exclude=SCHEMA:" IN (&var_internalschemas14)"
/*
PRO EXCLUDE=SCHEMA:"IN ('SYS','SYSMAN')"
PRO exclude=SCHEMA:"='XS$NULL'"
PRO exclude=SCHEMA:"='ORACLE_OCM'"
PRO exclude=SCHEMA:"='APEX_PUBLIC_USER'"
PRO exclude=SCHEMA:"='DIP'"
PRO exclude=SCHEMA:"='SYSMAN'"
PRO exclude=SCHEMA:"='DBSNMP'"
PRO exclude=SCHEMA:"='SI_INFORMTN_SCHEMA'"
PRO exclude=SCHEMA:"='APEX_030200'"
PRO exclude=SCHEMA:"='APEX_040000'"
PRO exclude=SCHEMA:"='ORDPLUGINS'"
PRO exclude=SCHEMA:"='APPQOSSYS'"
PRO exclude=SCHEMA:"='XDB'"
PRO exclude=SCHEMA:"='WMSYS'"
PRO exclude=SCHEMA:"='EXFSYS'"
PRO exclude=SCHEMA:"='ANONYMOUS'"
PRO exclude=SCHEMA:"='CTXSYS'"
PRO exclude=SCHEMA:"='ORDSYS'"
PRO exclude=SCHEMA:"='ORDDATA'"
PRO exclude=SCHEMA:"='MDSYS'"
PRO exclude=SCHEMA:"='FLOWS_FILES'"
PRO exclude=SCHEMA:"='MGMT_VIEW'"
PRO exclude=SCHEMA:"='OUTLN'"
PRO exclude=SCHEMA:"='SH'"
PRO exclude=SCHEMA:"='OE'"
PRO exclude=SCHEMA:"='PM'"
PRO exclude=SCHEMA:"='BI'"
PRO exclude=SCHEMA:"='OLAPSYS'"
PRO exclude=SCHEMA:"='IX'"
PRO exclude=SCHEMA:"='SCOTT'"
PRO exclude=SCHEMA:"='HR'"
PRO exclude=SCHEMA:"='PM'"
PRO exclude=SCHEMA:"='OWBSYS'"
PRO exclude=SCHEMA:"='ORAINT'"
PRO exclude=SCHEMA:"='LBACSYS'"
PRO exclude=SCHEMA:"='APPQOSSYS'"
PRO exclude=SCHEMA:"='GSMCATUSER'"
PRO exclude=SCHEMA:"='MDDATA'"
PRO exclude=SCHEMA:"='DBSFWUSER'"
PRO exclude=SCHEMA:"='SYSBACKUP'"
PRO exclude=SCHEMA:"='REMOTE_SCHEDULER_AGENT'"
PRO exclude=SCHEMA:"='GGSYS'"
PRO exclude=SCHEMA:"='ANONYMOUS'"
PRO exclude=SCHEMA:"='GSMUSER'"
PRO exclude=SCHEMA:"='SYSRAC'"
PRO exclude=SCHEMA:"='CTXSYS'"
PRO exclude=SCHEMA:"='ORDS_PUBLIC_USER'"
PRO exclude=SCHEMA:"='OJVMSYS'"
PRO exclude=SCHEMA:"='DVF'"
PRO exclude=SCHEMA:"='SI_INFORMTN_SCHEMA'"
PRO exclude=SCHEMA:"='DVSYS'"
PRO exclude=SCHEMA:"='AUDSYS'"
PRO exclude=SCHEMA:"='C##DBAAS_BACKUP'"
PRO exclude=SCHEMA:"='GSMADMIN_INTERNAL'"
PRO exclude=SCHEMA:"='ORDPLUGINS'"
PRO exclude=SCHEMA:"='DIP'"
PRO exclude=SCHEMA:"='LBACSYS'"
PRO exclude=SCHEMA:"='MDSYS'"
PRO exclude=SCHEMA:"='OLAPSYS'"
PRO exclude=SCHEMA:"='ORDDATA'"
PRO exclude=SCHEMA:"='SYSKM'"
PRO exclude=SCHEMA:"='OUTLN'"
PRO exclude=SCHEMA:"='SYS$UMF'"
PRO exclude=SCHEMA:"='ORACLE_OCM'"
PRO exclude=SCHEMA:"='XDB'"
PRO exclude=SCHEMA:"='WMSYS'"
PRO exclude=SCHEMA:"='ORDSYS'"
PRO exclude=SCHEMA:"='SYSDG'"
PRO exclude=SCHEMA:"='PYQSYS'"
PRO exclude=SCHEMA:"='C##CLOUD$SERVICE'"
PRO exclude=SCHEMA:"='C##ADP$SERVICE'"
PRO exclude=SCHEMA:"='ORDS_METADATA'"
PRO exclude=SCHEMA:"='C##OMLIDM'"
PRO exclude=SCHEMA:"='OML$MODELS'"
PRO exclude=SCHEMA:"='ORDS_PLSQL_GATEWAY'"
PRO exclude=SCHEMA:"='APEX_200200'"
PRO exclude=SCHEMA:"='GRAPH$METADATA'"
PRO exclude=SCHEMA:"='C##CLOUD_OPS'"
PRO exclude=SCHEMA:"='SSB'"
PRO exclude=SCHEMA:"='C##API'"
PRO exclude=SCHEMA:"='OMLMOD$PROXY'"
PRO exclude=SCHEMA:"='C##DV_ACCT_ADMIN'"
PRO exclude=SCHEMA:"='APEX_INSTANCE_ADMIN_USER'"
PRO exclude=SCHEMA:"='RMAN$CATALOG'"
PRO exclude=SCHEMA:"='C##DV_OWNER'"
PRO exclude=SCHEMA:"='GRAPH$PROXY_USER'"
PRO exclude=SCHEMA:"='OML$PROXY'"
*/


PRO
PRO
PRO +--------------------------------------------+
PRO | Parameter file example: impdp_par03.par    |
PRO +--------------------------------------------+
PRO | Parameter file example: only app schemas   |
PRO +--------------------------------------------+
PRO
PRO impdp parfile=impdp_par03.par
PRO
PRO USERID=&varUSERDBA/&varPASSDBA@&varCONNSTR
PRO JOB_NAME=exp_03NOROWSF&var_instancename
PRO DUMPFILE=&var_instancename/exp_03NOROWSF$varYYYYMMDD%U.dmp
PRO LOG=&varDIREXPD:&var_instancename/exp_03NOROWSF&varYYYYMMDD.log
PRO DIRECTORY=&varDIREXPD
PRO transform=disable_archive_logging:y
PRO FULL=Y
PRO rows=Y
PRO consistent=y
PRO PARALLEL=8
PRO CLUSTER=N
PRO EXCLUDE=STATISTICS
select
'include=SCHEMA:"='||''''||username||''''||'"'
from dba_users
where username NOT IN
(&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5, &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14  )
order by 1
/

PRO
PRO </PRE>

@rockdb/sql/footerhtml01
