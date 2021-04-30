DEFINE vhtmlpage='user_ddl_'
DEFINE vtitlethispage='User DDL'
DEFINE viconthispage='file-person.svg'
@rockdb/sql/headerhtmlspool.sql

PRO <PRE>
PRO
PRO +------------------------------------------------------------------------------+
PRO |            USER                                                              |
PRO +------------------------------------------------------------------------------+
PRO
SELECT DBMS_METADATA.GET_DDL('USER',username) as script
from DBA_USERS
where username NOT IN
(&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
, &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14  )
UNION ALL
SELECT DBMS_METADATA.GET_GRANTED_DDL('SYSTEM_GRANT',grantee) as script from DBA_SYS_PRIVS where grantee NOT IN
  (&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
  , &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14  )
UNION ALL
SELECT DBMS_METADATA.GET_GRANTED_DDL('ROLE_GRANT',grantee) as script from DBA_ROLE_PRIVS where grantee  NOT IN
(&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
, &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14  )
UNION ALL
SELECT DBMS_METADATA.GET_GRANTED_DDL('OBJECT_GRANT',grantee) as script from DBA_TAB_PRIVS where grantee  NOT IN
(&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
, &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14  )
/
select dbms_metadata.get_granted_ddl('TABLESPACE_QUOTA', tq.username) AS ddl
from   dba_ts_quotas tq
where  tq.username  NOT IN
(&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
, &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14  )
/

@rockdb/sql/footerhtml01
