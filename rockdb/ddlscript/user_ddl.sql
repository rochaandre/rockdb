DEFINE vhtmlpage='user_ddl_'
DEFINE vtitlethispage='User DDL'
DEFINE viconthispage='file-person.svg'
@report/sql/headerhtmlspool.sql

PRO <PRE>
PRO
PRO +------------------------------------------------------------------------------+
PRO |            USER                                                              |
PRO +------------------------------------------------------------------------------+
PRO
SELECT DBMS_METADATA.GET_DDL('USER',username) as script from DBA_USERS
where username NOT IN (SELECT OWNER FROM DBA_LOGSTDBY_SKIP WHERE STATEMENT_OPT ='INTERNAL SCHEMA'  )
UNION ALL
SELECT DBMS_METADATA.GET_GRANTED_DDL('SYSTEM_GRANT',grantee) as script from DBA_SYS_PRIVS where grantee NOT IN (SELECT OWNER FROM DBA_LOGSTDBY_SKIP WHERE STATEMENT_OPT ='INTERNAL SCHEMA'  )
UNION ALL
SELECT DBMS_METADATA.GET_GRANTED_DDL('ROLE_GRANT',grantee) as script from DBA_ROLE_PRIVS where grantee  NOT IN (SELECT OWNER FROM DBA_LOGSTDBY_SKIP WHERE STATEMENT_OPT ='INTERNAL SCHEMA'  )
UNION ALL
SELECT DBMS_METADATA.GET_GRANTED_DDL('OBJECT_GRANT',grantee) as script from DBA_TAB_PRIVS where grantee  NOT IN (SELECT OWNER FROM DBA_LOGSTDBY_SKIP WHERE STATEMENT_OPT ='INTERNAL SCHEMA' )
/
select dbms_metadata.get_granted_ddl('TABLESPACE_QUOTA', tq.username) AS ddl
from   dba_ts_quotas tq
where  tq.username  NOT IN (SELECT OWNER FROM DBA_LOGSTDBY_SKIP WHERE STATEMENT_OPT ='INTERNAL SCHEMA'  )
/

@report/sql/footerhtml01
