DEFINE vhtmlpage='user_ddl_create_'
DEFINE vtitlethispage='Users DDL create'
DEFINE viconthispage='file-person.svg'
@rockdb/sql/headerhtmlspool.sql

PRO <PRE>

col comando for a290

col comando for a290
PRO
PRO +------------------------------------------------------------------------------+
PRO |            USER FIX SAME PASSWORD                                            |
PRO +------------------------------------------------------------------------------+
PRO

select 'alter user "'||d.username||'" identified by values '''||u.password||''';' comando
from dba_users d, sys.user$ u
where d.username not in ('SYS','SYSTEM','ANONYMOUS','CTXSYS','HR','MDSYS','ODM','ODM_MTR','OE',
'OLAPSYS','ORDPLUGINS','ORDSYS','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS',
'QS_WS','SCOTT','SH','WKPROXY','WKSYS','WMSYS','XDB','DBSNMP','SYSMAN','MGMT_VIEW','SI_INFORMTN_SCHEMA',
'DMSYS','DIP','OUTLN','EXFSYS','MDDATA','TSMSYS','APEX_PUBLIC_USER','FLOWS_FILES','OWBSYS','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR',
'XS$NULL','APEX_030200','APPQOSSYS','ORDDATA','OWBSYS_AUDIT','ORACLE_OCM','UNICOM')
and u.user# = d.user_id;

PRO
PRO
PRO +------------------------------------------------------------------------------+
PRO |            USER DDL                                                          |
PRO +------------------------------------------------------------------------------+
PRO


 
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
where   username not in('SYS','SYSTEM','ANONYMOUS','CTXSYS','HR','MDSYS','ODM','ODM_MTR','OE',
'OLAPSYS','ORDPLUGINS','ORDSYS','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS',
'QS_WS','SCOTT','SH','WKPROXY','WKSYS','WMSYS','XDB','DBSNMP','SYSMAN','MGMT_VIEW','SI_INFORMTN_SCHEMA',
'DMSYS','DIP','OUTLN','EXFSYS','MDDATA','TSMSYS','APEX_PUBLIC_USER','FLOWS_FILES','OWBSYS','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR',
'XS$NULL','APEX_030200','APPQOSSYS','ORDDATA','OWBSYS_AUDIT','ORACLE_OCM','UNICOM')
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
where   username not in('SYS','SYSTEM','ANONYMOUS','CTXSYS','HR','MDSYS','ODM','ODM_MTR','OE',
'OLAPSYS','ORDPLUGINS','ORDSYS','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS',
'QS_WS','SCOTT','SH','WKPROXY','WKSYS','WMSYS','XDB','DBSNMP','SYSMAN','MGMT_VIEW','SI_INFORMTN_SCHEMA',
'DMSYS','DIP','OUTLN','EXFSYS','MDDATA','TSMSYS','APEX_PUBLIC_USER','FLOWS_FILES','OWBSYS','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR',
'XS$NULL','APEX_030200','APPQOSSYS','ORDDATA','OWBSYS_AUDIT','ORACLE_OCM','UNICOM')
--################################################################
-- Grant das roles
union
select  4 id,'grant '||granted_role||' to "'||grantee||'";' comando
from    dba_role_privs
where   grantee not in('SYS','SYSTEM','ANONYMOUS','CTXSYS','HR','MDSYS','ODM','ODM_MTR','OE',
'OLAPSYS','ORDPLUGINS','ORDSYS','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS',
'QS_WS','SCOTT','SH','WKPROXY','WKSYS','WMSYS','XDB','DBSNMP','SYSMAN','MGMT_VIEW','SI_INFORMTN_SCHEMA',
'DMSYS','DIP','OUTLN','EXFSYS','MDDATA','TSMSYS','APEX_PUBLIC_USER','FLOWS_FILES','OWBSYS','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR',
'XS$NULL','APEX_030200','APPQOSSYS','ORDDATA','OWBSYS_AUDIT','ORACLE_OCM','UNICOM')
and     admin_option = 'NO'
union
select  4 id,'grant '||granted_role||' to "'||grantee||'" WITH ADMIN OPTION;' comando
from    dba_role_privs
where   grantee not in('SYS','SYSTEM','ANONYMOUS','CTXSYS','HR','MDSYS','ODM','ODM_MTR','OE',
'OLAPSYS','ORDPLUGINS','ORDSYS','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS',
'QS_WS','SCOTT','SH','WKPROXY','WKSYS','WMSYS','XDB','DBSNMP','SYSMAN','MGMT_VIEW','SI_INFORMTN_SCHEMA',
'DMSYS','DIP','OUTLN','EXFSYS','MDDATA','TSMSYS','APEX_PUBLIC_USER','FLOWS_FILES','OWBSYS','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR',
'XS$NULL','APEX_030200','APPQOSSYS','ORDDATA','OWBSYS_AUDIT','ORACLE_OCM','UNICOM')
and     admin_option = 'YES'
--################################################################
-- Grant de systema
union
select  5 id,'grant '||PRIVILEGE||' to "'||grantee||'";' comando
from    dba_sys_privs
where   grantee not in('SYS','SYSTEM','ANONYMOUS','CTXSYS','HR','MDSYS','ODM','ODM_MTR','OE',
'OLAPSYS','ORDPLUGINS','ORDSYS','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS',
'QS_WS','SCOTT','SH','WKPROXY','WKSYS','WMSYS','XDB','DBSNMP','SYSMAN','MGMT_VIEW','SI_INFORMTN_SCHEMA',
'DMSYS','DIP','OUTLN','EXFSYS','MDDATA','TSMSYS','APEX_PUBLIC_USER','FLOWS_FILES','OWBSYS','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR',
'XS$NULL','APEX_030200','APPQOSSYS','ORDDATA','OWBSYS_AUDIT','ORACLE_OCM','UNICOM')
and     admin_option = 'NO'
union
select  5 id,'grant '||PRIVILEGE||' to "'||grantee||'" WITH ADMIN OPTION;' comando
from    dba_sys_privs
where   grantee not in('SYS','SYSTEM','ANONYMOUS','CTXSYS','HR','MDSYS','ODM','ODM_MTR','OE',
'OLAPSYS','ORDPLUGINS','ORDSYS','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS',
'QS_WS','SCOTT','SH','WKPROXY','WKSYS','WMSYS','XDB','DBSNMP','SYSMAN','MGMT_VIEW','SI_INFORMTN_SCHEMA',
'DMSYS','DIP','OUTLN','EXFSYS','MDDATA','TSMSYS','APEX_PUBLIC_USER','FLOWS_FILES','OWBSYS','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR',
'XS$NULL','APEX_030200','APPQOSSYS','ORDDATA','OWBSYS_AUDIT','ORACLE_OCM','UNICOM')
and     admin_option = 'YES'
--################################################################
-- Grant de tabelas
union
select  6 id,'grant '||PRIVILEGE||' on "'||owner||'"."'||table_name||'" to '||grantee||';' comando
from    dba_tab_privs
where   owner not in('SYS','SYSTEM','ANONYMOUS','CTXSYS','HR','MDSYS','ODM','ODM_MTR','OE',
'OLAPSYS','ORDPLUGINS','ORDSYS','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS',
'QS_WS','SCOTT','SH','WKPROXY','WKSYS','WMSYS','XDB','DBSNMP','SYSMAN','MGMT_VIEW','SI_INFORMTN_SCHEMA',
'DMSYS','DIP','OUTLN','EXFSYS','MDDATA','TSMSYS','APEX_PUBLIC_USER','FLOWS_FILES','OWBSYS','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR',
'XS$NULL','APEX_030200','APPQOSSYS','ORDDATA','OWBSYS_AUDIT','ORACLE_OCM','UNICOM')
and     GRANTABLE = 'NO'
union
select  6 id,'grant '||PRIVILEGE||' on "'||owner||'"."'||table_name||'" to '||grantee||' WITH GRANT OPTION;' comando
from    dba_tab_privs
where   owner not in('SYS','SYSTEM','ANONYMOUS','CTXSYS','HR','MDSYS','ODM','ODM_MTR','OE',
'OLAPSYS','ORDPLUGINS','ORDSYS','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS',
'QS_WS','SCOTT','SH','WKPROXY','WKSYS','WMSYS','XDB','DBSNMP','SYSMAN','MGMT_VIEW','SI_INFORMTN_SCHEMA',
'DMSYS','DIP','OUTLN','EXFSYS','MDDATA','TSMSYS','APEX_PUBLIC_USER','FLOWS_FILES','OWBSYS','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR',
'XS$NULL','APEX_030200','APPQOSSYS','ORDDATA','OWBSYS_AUDIT','ORACLE_OCM','UNICOM')
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
and     tp.grantee not in('SYS','SYSTEM','ANONYMOUS','CTXSYS','HR','MDSYS','ODM','ODM_MTR','OE',
'OLAPSYS','ORDPLUGINS','ORDSYS','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS',
'QS_WS','SCOTT','SH','WKPROXY','WKSYS','WMSYS','XDB','DBSNMP','SYSMAN','MGMT_VIEW','SI_INFORMTN_SCHEMA',
'DMSYS','DIP','OUTLN','EXFSYS','MDDATA','TSMSYS','APEX_PUBLIC_USER','FLOWS_FILES','OWBSYS','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR',
'XS$NULL','APEX_030200','APPQOSSYS','ORDDATA','OWBSYS_AUDIT','ORACLE_OCM','UNICOM')
)
ORDER BY id;

@rockdb/sql/footerhtml01
