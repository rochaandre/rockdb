DEFINE vhtmlpage='dataguard_config_'
DEFINE vtitlethispage='Usefull config files, commands to be used in dataguard '
DEFINE viconthispage='building.svg'
@rockdb/sql/headerhtmlspool.sql


PRO <html>
PRO   <head>
PRO   </head>
PRO   <body>
PRO
PRO <PRE>
PRO
PRO +------------------------------------------------------------------------------+
PRO |              Redo information                                                |
PRO +------------------------------------------------------------------------------+
PRO <PRE>
set head on


column group# format 99999;
column status format a10;
column mb format 99999;
select group#, status, bytes/1024/1024 mb, thread# from gv$log order by thread#, group#;

column group# format 99999;
column status format a10;
column mb format 99999;
select group#, thread#, bytes/1024/1024  from v$standby_log   order by thread#,  group#;
select member from v$logfile;


column REDOLOG_FILE_NAME format a50
SELECT
 a.GROUP#,
 a.THREAD#,
 a.SEQUENCE#,
 a.ARCHIVED,
 a.STATUS,
 b.MEMBER AS REDOLOG_FILE_NAME,
 (a.BYTES/1024/1024) AS SIZE_MB
FROM gv$log a
JOIN gv$logfile b ON a.Group#=b.Group#  AND a.INST_ID = b.INST_ID
ORDER BY a.GROUP#

PRO
PRO +------------------------------------------------------------------------------+
PRO |              Redo drop and recreation                                        |
PRO +------------------------------------------------------------------------------+
PRO

SELECT 'ALTER DATABASE DROP LOGFILE group '||a.group# || ' ;  '  ddl -- ||  ' thread  ' || a.thread# || ' ;  '  ddl
FROM gv$log a
JOIN gv$logfile b ON a.Group#=b.Group#  AND a.INST_ID = b.INST_ID
ORDER BY a.GROUP#
PRO
SELECT 'alter database add logfile thread '|| a.thread# || ' group '||a.group#|| '''' || MEMBER || '''' ||  ' size  ' ||(a.BYTES/1024/1024)||'MB;' ddl
FROM gv$log a
JOIN gv$logfile b ON a.Group#=b.Group#  AND a.INST_ID = b.INST_ID
ORDER BY a.GROUP#
/

PRO
PRO +------------------------------------------------------------------------------+
PRO |              Standby Redo creation                                           |
PRO +------------------------------------------------------------------------------+
PRO

PRO
PRO
SELECT 'alter database add STANDBY logfile thread ('|| a.thread# ||' '|| '''' || MEMBER || '''' ||  ') size  ' ||(a.BYTES/1024/1024)||'MB;' ddl
FROM gv$log a
JOIN gv$logfile b ON a.Group#=b.Group# AND a.INST_ID = b.INST_ID
UNION ALL
SELECT 'alter database add STANDBY logfile thread ('|| a.thread# ||' '|| '''' || MEMBER || '''' ||  ') size  ' ||(a.BYTES/1024/1024)||'MB;' ddl
FROM gv$log a
JOIN gv$logfile b ON a.Group#=b.Group# AND a.INST_ID = b.INST_ID
WHERE rownum<=1
/

PRO
PRO orapwd file=/u02/app/oracle/product/18.0.0.0/dbhome_2/dbs/orapwlondon password="TechMaster1_" force=y entries=10
PRO
PRO http://www.soudba.com.br/?p=1119
PRO </PRE>
PRO </body>


@rockdb/sql/footerhtml01
