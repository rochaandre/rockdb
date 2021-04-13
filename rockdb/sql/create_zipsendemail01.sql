SET LONG 20000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO &var_outputfolder/sendemail.sh

PRO cd &vdirrockdb
select  DISTINCT 'echo "" | mutt -s &vclientname'||''''||' -- NEED ATTENTION - database with error in last backup '||''''|| '    -a &var_outputfolder/list_rmanbkp01_&var_namefile -a &var_outputfolder/list_rman_backupspfile01_&var_namefile -a &var_outputfolder/list_rman_backupsize01_&var_namefile -a &var_outputfolder/list_rman_backupset01_&var_namefile -a &var_outputfolder/list_rman_backuppiece01_&var_namefile -a &var_outputfolder/list_rman_backupjob01_&var_namefile  --  &vclientemail ' STATUS from V$RMAN_BACKUP_JOB_DETAILS WHERE START_time>=sysdate-1 AND STATUS='FAILED' and rownum<=1
/
PRO cd &vhifen

SPO OFF;
SET HEA ON LIN 80 NEWP 1 PAGES 14 FEED ON ECHO OFF VER ON LONG 80 LONGC 80 WRA ON TRIMS OFF TRIM OFF TI OFF TIMI OFF ARRAY 15 NUM 10 NUMF "" SQLBL OFF BLO ON RECSEP WR;
