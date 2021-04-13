PRO /* Permanent Tablespace */

SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO report/sql/calltablespace.sql;
select '@report/sql/tbs12c.sql '||instance_name || ' '||replace(instance_name,'$') par2
from v$instance
/
SPO OFF;
@report/sql/calltablespace.sql
SET HEA ON LIN 80 NEWP 1 PAGES 14 FEED ON ECHO OFF VER ON LONG 80 LONGC 80 WRA ON TRIMS OFF TRIM OFF TI OFF TIMI OFF ARRAY 15 NUM 10 NUMF "" SQLBL OFF BLO ON RECSEP WR;

SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO html/calltablespace.html;
select '<iframe src="'||'html/listtablespace'||replace(name,'$')||'.html" height="70%" width="1200"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>' name
from v$containers
where con_id<>2
order by con_id
/
SPO OFF;
@report/sql/calltablespace.sql
SET HEA ON LIN 80 NEWP 1 PAGES 14 FEED ON ECHO OFF VER ON LONG 80 LONGC 80 WRA ON TRIMS OFF TRIM OFF TI OFF TIMI OFF ARRAY 15 NUM 10 NUMF "" SQLBL OFF BLO ON RECSEP WR;

PRO /* Temp Tablespace */

SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO html/calltablespace.html;
select '<iframe src="'||'listtablespacetmp'||replace(name,'$')||'.html" height="70%" width="1200"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>' name
from v$containers
where con_id<>2
order by con_id
/
SPO OFF;
@report/sql/calltablespace.sql
@report/sql/footerhtml01
