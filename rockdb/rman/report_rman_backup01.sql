SET LONG 20000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO &var_outputfolder/report_rman_backup01_&var_namefile..txt
@rockdb/sql/headertxt.sql "report_rman_backup01" "&var_outputfolder/report_rman_backup01_&var_namefile..txt"

COLUMN grantee   FORMAT A20
COLUMN owner     FORMAT A10
COLUMN grantor   FORMAT A20
COLUMN privilege FORMAT A20


PRO
PRO +------------------------------------------------------------------------------+
PRO |            DAILY BACKUP RMAN                                                 |
PRO +------------------------------------------------------------------------------+
PRO

select INSTANCE_NAME,to_char(STARTUP_TIME,'dd/mm/yyyy-hh24:mi:ss') Startup,DATABASE_STATUS from gv$instance;
select
  session_key, input_type, status, input_bytes/1024/1024/1024 "INPUT GB", output_bytes/1024/1024/1024 "OUTPUT GB",
to_char(start_time, 'dd.mm.yyyy hh24:mi:ss') start_time,
to_char(end_time, 'dd.mm.yyyy hh24:mi:ss') end_time,
output_device_type, elapsed_seconds
from
  v$rman_backup_job_details
where start_time>=sysdate-2
and input_type='DB INCR'
/
PRO
PRO +------------------------------------------------------------------------------+
PRO |            ARCHIVELOG RMAN                                                   |
PRO +------------------------------------------------------------------------------+
PRO

select
  session_key, input_type, status, input_bytes/1024/1024/1024 "INPUT GB", output_bytes/1024/1024/1024 "OUTPUT GB",
to_char(start_time, 'dd.mm.yyyy hh24:mi:ss') start_time,
to_char(end_time, 'dd.mm.yyyy hh24:mi:ss') end_time,
output_device_type, elapsed_seconds
from
  v$rman_backup_job_details
where start_time>=sysdate-1/12
and input_type='ARCHIVELOG'
/

column Device  format a10
col start_time format a20
col END_TIME format a20
COL STATUS FORMAT A10


PRO
PRO +------------------------------------------------------------------------------+
PRO |            INCREMENTAL BACKUP RMAN                                           |
PRO +------------------------------------------------------------------------------+
PRO

select INSTANCE_NAME,to_char(STARTUP_TIME,'dd/mm/yyyy-hh24:mi:ss') Startup,DATABASE_STATUS from gv$instance;
select
  session_key, input_type, status, trunc(input_bytes/1024/1024/1024,3) "INPUT GB", trunc(output_bytes/1024/1024/1024,3) "OUTPUT GB",
to_char(start_time, 'dd.mm.yyyy hh24:mi:ss') "END_TIME",
to_char(end_time, 'dd.mm.yyyy hh24:mi:ss') "END_TIME",
Substr(output_device_type,1,8) "Device", elapsed_seconds "TIME_ELAPSED_SEC",trunc(COMPRESSION_RATIO,2) "%Comp Ratio",substr(TIME_TAKEN_DISPLAY,1,10) Time
from
  v$rman_backup_job_details
where start_time>=sysdate-10
and input_type='DB INCR'
/
@rockdb/sql/footerhtml01
