DEFINE vhtmlpage='trigger_ddl_'
DEFINE vtitlethispage='Trigger DDL'
DEFINE viconthispage='server.svg'
@report/sql/headerhtmlspool.sql

PRO <PRE>

PRO
PRO +------------------------------------------------------------------------------+
PRO |            TRIGGER DB                                                        |
PRO +------------------------------------------------------------------------------+
PRO
SELECT  decode(upper(substr(text,1,7)),'TRIGGER','CREATE OR REPLACE  ' ) ||text
FROM dba_source t
WHERE type = 'TRIGGER'
and  (owner, NAME ) IN
(SELECT  owner, TRIGGER_NAME
FROM DBA_TRIGGERS
WHERE table_name IS NULL
AND owner NOT IN ('EXFSYS','WMSYS','SYSMAN')
)
ORDER BY owner, name, line
/

@report/sql/footerhtml01
