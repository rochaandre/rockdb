DEFINE vhtmlpage='user_ddl_password_'
DEFINE vtitlethispage='Users DDL password'
DEFINE viconthispage='file-person.svg'
@rockdb/sql/headerhtmlspool.sql

PRO <PRE>

col comando for a290
PRO
PRO +------------------------------------------------------------------------------+
PRO |            USER DDL                                                          |
PRO +------------------------------------------------------------------------------+
PRO

select 'alter user "'||d.username||'" identified by values '''||u.password||''' account unlock;' comando
from dba_users d, sys.user$ u
where d.username NOT IN
(&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
, &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14  )
order by 1
/

and u.user# = d.user_id;


@rockdb/sql/footerhtml01
