SET LONG 20000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO &var_outputfolder/report_hcheck_&var_namefile..txt
@report/sql/headertxt.sql "report_hcheck" "&var_outputfolder/report_hcheck_&var_namefile..txt"

COLUMN grantee   FORMAT A20
COLUMN owner     FORMAT A10
COLUMN grantor   FORMAT A20
COLUMN privilege FORMAT A20


PRO
PRO +------------------------------------------------------------------------------+
PRO |            HCHECK REPORT                                                     |
PRO +------------------------------------------------------------------------------+
PRO

select INSTANCE_NAME,to_char(STARTUP_TIME,'dd/mm/yyyy-hh24:mi:ss') Startup,DATABASE_STATUS from gv$instance;
/
PRO
PRO
@report/thirdparty/hcheck/hcheck.sql
PRO


SPO OFF;
SET HEA ON LIN 80 NEWP 1 PAGES 14 FEED ON ECHO OFF VER ON LONG 80 LONGC 80 WRA ON TRIMS OFF TRIM OFF TI OFF TIMI OFF ARRAY 15 NUM 10 NUMF "" SQLBL OFF BLO ON RECSEP WR;
