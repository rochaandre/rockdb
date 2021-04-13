

SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO report/script/dbinfo_expdp_list01.sh;

SELECT ' find '||a.DIRECTORY_PATH||'/ -name "*'
||instance_name||'*" -mmin -2880 -type f -exec  ls -ltrh {} > html/dbinfo_expdp_list01.html \;' output
FROM DBA_DIRECTORIES a, v$instance x
WHERE a.DIRECTORY_NAME ='$1'
/
@report/sql/footerhtml01
