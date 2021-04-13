DEFINE vhtmlpage='dblink_ddl_'
DEFINE vtitlethispage='Dblink DDL'
DEFINE viconthispage='link.svg'
@report/sql/headerhtmlspool.sql


PRO <PRE>
PRO +------------------------------------------------------------------------------+
PRO |            DB LINK                                                           |
PRO +------------------------------------------------------------------------------+
PRO
SELECT DBMS_METADATA.get_ddl ('DB_LINK', db_link, owner)
FROM   dba_db_links
/
PRO </PRE>

@report/sql/footerhtml01
