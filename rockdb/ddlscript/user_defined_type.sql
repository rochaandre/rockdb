DEFINE vhtmlpage='user_defined_type_'
DEFINE vtitlethispage='User defined DDL'
DEFINE viconthispage='file-person.svg'
@rockdb/sql/headerhtmlspool.sql

PRO <PRE>

PRO
PRO +------------------------------------------------------------------------------+
PRO |            USER DEFINED TYPES                                                |
PRO +------------------------------------------------------------------------------+
PRO TO CREATE

col comando for a300

set serveroutput on size unlimited
begin
        for reg1 in(    select  distinct
                                profile
                        from    dba_profiles)loop
                dbms_output.put_line('--Criando profile '||reg1.profile);
                for reg2 in(    select  texto
                                from    (
                                        select  '1' id,'create profile '||reg1.profile||' limit' texto
                                        from    dual
                                        union all
                                        select  '2' id,RESOURCE_NAME||' '||LIMIT texto
                                        from    dba_profiles
                                        where   profile=reg1.profile
                                        union all
                                        select  '3' id,';' texto
                                        from    dual)
                                order by id) loop
                        dbms_output.put_line(reg2.texto);
                end loop;
        end loop;
end;
/
SELECT  comando
FROM    (
--################################################################
-- Cria o usuário
select  1 id,'create user "'
        ||username
        ||'" identified by values '''
        ||password
        ||''' default tablespace '
        ||default_tablespace
        ||' temporary tablespace '
        ||temporary_tablespace
        ||' profile '
        ||profile
        ||';' comando
from    dba_users
where username NOT IN
(&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
, &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14)
--############################################################################
-- Cria Roles
union
select  2 id,'create role "'||role||'";' comando
from    dba_roles
where   role not in
('CONNECT',
'RESOURCE',
'DBA',
'SELECT_CATALOG_ROLE',
'EXECUTE_CATALOG_ROLE',
'DELETE_CATALOG_ROLE',
'EXP_FULL_DATABASE',
'IMP_FULL_DATABASE',
'GATHER_SYSTEM_STATISTICS',
'LOGSTDBY_ADMINISTRATOR',
'AQ_ADMINISTRATOR_ROLE',
'AQ_USER_ROLE',
'OEM_MONITOR',
'HS_ADMIN_ROLE',
'RECOVERY_CATALOG_OWNER',
'GLOBAL_AQ_USER_ROLE')
--################################################################
-- Atribui quota dos Tablespaces
union
select  3 id,'alter user "'
        ||username
        ||'" quota '
        ||decode(bytes,0,'unlimited',bytes)
        ||' on '
        ||tablespace_name
        ||';' comando
from    dba_ts_quotas
where username NOT IN
(&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
, &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14)
--################################################################
-- Grant das roles
union
select  4 id,'grant '||granted_role||' to "'||grantee||'";' comando
from    dba_role_privs
where username NOT IN
(&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
, &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14)
and     admin_option = 'NO'
union
select  4 id,'grant '||granted_role||' to "'||grantee||'" WITH ADMIN OPTION;' comando
from    dba_role_privs
where   grantee not in
  (&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
  , &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14)
and     admin_option = 'YES'
--################################################################
-- Grant de systema
union
select  5 id,'grant '||PRIVILEGE||' to "'||grantee||'";' comando
from    dba_sys_privs
where   grantee not in
    (&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
    , &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14)
and     admin_option = 'NO'
union
select  5 id,'grant '||PRIVILEGE||' to "'||grantee||'" WITH ADMIN OPTION;' comando
from    dba_sys_privs
where   grantee not in
  (&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
  , &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14)
and     admin_option = 'YES'
--################################################################
-- Grant de tabelas
union
select  6 id,'grant '||PRIVILEGE||' on "'||owner||'"."'||table_name||'" to '||grantee||';' comando
from    dba_tab_privs
where   owner not in
  (&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
  , &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14)
and     GRANTABLE = 'NO'
union
select  6 id,'grant '||PRIVILEGE||' on "'||owner||'"."'||table_name||'" to '||grantee||' WITH GRANT OPTION;' comando
from    dba_tab_privs
where   owner not in
  (&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
  , &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14)
and     GRANTABLE = 'YES'
--################################################################
-- Create Directory
union
select  7 id,'create directory "'||DIRECTORY_NAME||'" as '''||DIRECTORY_PATH||''';' comando
from    dba_directories
--################################################################
-- Grant Directory
union
select  8 id,'grant '||tp.PRIVILEGE||' on directory "'||tp.owner||'"."'||tp.table_name||'" to "'||tp.grantee||'";' comando
from    dba_tab_privs tp,
        dba_directories d
where   tp.table_name = d.DIRECTORY_NAME
and     tp.owner = d.owner
and     tp.grantee not in
(&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
, &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14)
)
ORDER BY id;

@rockdb/sql/footerhtml01
