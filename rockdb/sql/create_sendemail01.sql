SET LONG 20000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;

SPO &var_outputfolder/sendemail.sh

PRO cd &vdirrockdb
PRO zip &var_outputfolder/rockdb_report.zip &var_outputfolder/* &var_outputfolder/css* &var_outputfolder/index_rman*

select  DISTINCT 'echo "" | mutt -s &vclientname'||''''||' -- Rockdb report of your database '||'&var_instancename'||''''|| '  -a &var_outputfolder/rockdb_report.zip --  &vclientemail ' RSTATUS from dual
/
PRO cd &vhifen

SPO OFF;
SET HEA ON LIN 80 NEWP 1 PAGES 14 FEED ON ECHO OFF VER ON LONG 80 LONGC 80 WRA ON TRIMS OFF TRIM OFF TI OFF TIMI OFF ARRAY 15 NUM 10 NUMF "" SQLBL OFF BLO ON RECSEP WR;
