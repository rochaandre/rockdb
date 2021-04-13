DEFINE vhtmlpage='audit_ddl_'
DEFINE vtitlethispage='Audit ACL'
DEFINE viconthispage='shield-check.svg'
@rockdb/sql/headerhtmlspool.sql


PRO <PRE>
PRO
PRO +------------------------------------------------------------------------------+
PRO |            AUDIT                                                             |
PRO +------------------------------------------------------------------------------+
PRO
select 'AUDIT '||m.name||decode(u.name,'PUBLIC',' ',' BY "'||u.name||'"')||
       decode(nvl(a.success,0)  + (10 * nvl(a.failure,0)),
       1, ' BY SESSION WHENEVER SUCCESSFUL ',
       2, ' BY ACCESS WHENEVER SUCCESSFUL ',
       10,' BY SESSION WHENEVER NOT SUCCESSFUL ',
       11,' BY SESSION ',   -- default
       20,' BY ACCESS WHENEVER NOT SUCCESSFUL ',
       22,' BY ACCESS',' /* not possible */ ')||' ;'
 "AUDIT STATEMENT"
        FROM sys.audit$ a, sys.user$ u, sys.stmt_audit_option_map m
        WHERE a.user# = u.user# AND a.option# = m.option#
              and bitand(m.property, 1) != 1  and a.proxy# is null
              and a.user# <> 0
        UNION
select 'AUDIT '||m.name||decode(u1.name,'PUBLIC',' ',' BY "'||u1.name||'"')||
       ' ON BEHALF OF '|| decode(u2.name,'SYS','ANY',u2.name)||
       decode(nvl(a.success,0)  + (10 * nvl(a.failure,0)),
       1,' WHENEVER SUCCESSFUL ',
       2,' WHENEVER SUCCESSFUL ',
       10,' WHENEVER NOT SUCCESSFUL ',
       11,' ',   -- default
       20, ' WHENEVER NOT SUCCESSFUL ',
       22, ' ',' /* not possible */ ')||';'
 "AUDIT STATEMENT"
     FROM sys.audit$ a, sys.user$ u1, sys.user$ u2, sys.stmt_audit_option_map m
     WHERE a.user# = u2.user# AND a.option# = m.option# and a.proxy# = u1.user#
              and bitand(m.property, 1) != 1  and a.proxy# is not null
UNION
select 'AUDIT '||p.name||decode(u.name,'PUBLIC',' ',' BY "'||u.name||'"')||
       decode(nvl(a.success,0)  + (10 * nvl(a.failure,0)),
       1,' BY SESSION WHENEVER SUCCESSFUL ',
       2,' BY ACCESS WHENEVER SUCCESSFUL ',
       10,' BY SESSION WHENEVER NOT SUCCESSFUL ',
       11,' BY SESSION ',   -- default
       20, ' BY ACCESS WHENEVER NOT SUCCESSFUL ',
       22, ' BY ACCESS',' /* not possible */ ')||' ;'
 "AUDIT STATEMENT"
        FROM sys.audit$ a, sys.user$ u, sys.system_privilege_map p
        WHERE a.user# = u.user# AND a.option# = -p.privilege
              and bitand(p.property, 1) != 1 and a.proxy# is null
         and a.user# <> 0
UNION
select 'AUDIT '||p.name||decode(u1.name,'PUBLIC',' ',' BY "'||u1.name||'"')||
       ' ON BEHALF OF '|| decode(u2.name,'SYS','ANY',u2.name)||
       decode(nvl(a.success,0)  + (10 * nvl(a.failure,0)),
       1,' WHENEVER SUCCESSFUL ',
       2,' WHENEVER SUCCESSFUL ',
       10,' WHENEVER NOT SUCCESSFUL ',
       11,' ',   -- default
       20, ' WHENEVER NOT SUCCESSFUL ',
       22, ' ',' /* not possible */ ')||';'
 "AUDIT STATEMENT"
   FROM sys.audit$ a, sys.user$ u1, sys.user$ u2, sys.system_privilege_map p
   WHERE a.user# = u2.user# AND a.option# = -p.privilege and a.proxy# = u1.user#
              and bitand(p.property, 1) != 1 and a.proxy# is not null
;

select 'NOAUDIT '||m.name||decode(u.name,'PUBLIC',' ',' BY "'||u.name||'"')||
              decode(nvl(a.success,0)  + (10 * nvl(a.failure,0)),
       1,' WHENEVER SUCCESSFUL ',
       2,' WHENEVER SUCCESSFUL ',
       10,' WHENEVER NOT SUCCESSFUL ',
       11,' ',
       20, ' WHENEVER NOT SUCCESSFUL ',
       22, ' ',' /* not possible */ ')||' ;'
 "NOAUDIT STATEMENT"
        FROM sys.audit$ a, sys.user$ u, sys.stmt_audit_option_map m
        WHERE a.user# = u.user# AND a.option# = m.option#
              and bitand(m.property, 1) != 1 and a.proxy# is null
              and a.user# <> 0
UNION
select 'NOAUDIT '||m.name||decode(u1.name,'PUBLIC',' ',' BY "'||u1.name||'"')||
       ' ON BEHALF OF '|| decode(u2.name,'SYS','ANY',u2.name)||
       decode(nvl(a.success,0)  + (10 * nvl(a.failure,0)),
       1,' WHENEVER SUCCESSFUL ',
       2,' WHENEVER SUCCESSFUL ',
       10,' WHENEVER NOT SUCCESSFUL ',
       11,' ',   -- default
       20, ' WHENEVER NOT SUCCESSFUL ',
       22, ' ',' /* not possible */ ')||';'
 "AUDIT STATEMENT"
     FROM sys.audit$ a, sys.user$ u1, sys.user$ u2, sys.stmt_audit_option_map m
     WHERE a.user# = u2.user# AND a.option# = m.option# and a.proxy# = u1.user#
              and bitand(m.property, 1) != 1  and a.proxy# is not null
        UNION
select 'NOAUDIT '||p.name||decode(u.name,'PUBLIC',' ',' BY "'||u.name||'"')||
       decode(nvl(a.success,0)  + (10 * nvl(a.failure,0)),
       1,' WHENEVER SUCCESSFUL ',
       2,' WHENEVER SUCCESSFUL ',
       10,' WHENEVER NOT SUCCESSFUL ',
       11,' ',   -- default
       20, ' WHENEVER NOT SUCCESSFUL ',
       22, ' ',' /* not possible */ ')||' ;'
 "NOAUDIT STATEMENT"
        FROM sys.audit$ a, sys.user$ u, sys.system_privilege_map p
        WHERE a.user# = u.user# AND a.option# = -p.privilege
              and bitand(p.property, 1) != 1  and a.proxy# is null
              and a.user# <> 0
UNION
select 'NOAUDIT '||p.name||decode(u1.name,'PUBLIC',' ',' BY "'||u1.name||'"')||
       ' ON BEHALF OF '|| decode(u2.name,'SYS','ANY',u2.name)||
       decode(nvl(a.success,0)  + (10 * nvl(a.failure,0)),
       1,' WHENEVER SUCCESSFUL ',
       2,' WHENEVER SUCCESSFUL ',
       10,' WHENEVER NOT SUCCESSFUL ',
       11,' ',   -- default
       20, ' WHENEVER NOT SUCCESSFUL ',
       22, ' ',' /* not possible */ ')||';'
 "AUDIT STATEMENT"
   FROM sys.audit$ a, sys.user$ u1, sys.user$ u2, sys.system_privilege_map p
   WHERE a.user# = u2.user# AND a.option# = -p.privilege and a.proxy# = u1.user#
              and bitand(p.property, 1) != 1 and a.proxy# is not null;

              PRO
              PRO
              PRO
              PRO

select unique
 '-- Please correct the problem described in note 455565.1:'
 ||chr(13)||chr(10)||
 'delete from sys.audit$ where user#=0 and proxy# is null;'
 ||chr(13)||chr(10)||'commit;'
 from sys.audit$  where user#=0 and proxy# is null;

select '-- Please correct the problem described in bug 6636804:'
  ||chr(13)||chr(10)||
  'update sys.STMT_AUDIT_OPTION_MAP set option#=234'
  ||chr(13)||chr(10)||' where name =''ON COMMIT REFRESH'';'
  ||chr(13)||chr(10)||'commit;'
  from  sys.STMT_AUDIT_OPTION_MAP where option#=229 and name ='ON COMMIT REFRESH';

select
 '-- Please correct the problem described in bug 6124447:'
 ||chr(13)||chr(10)||
 'noaudit truncate;'
 from sys.audit$ where option#=155;

select unique '-- Please correct the problem described in note 1529792.1:'
 ||chr(13)||chr(10)||
 'insert into javaobj$ select object_id,'
 ||chr(13)||chr(10)||'(select AUDIT$ from sys.javaobj$ where rownum=1)'
 ||chr(13)||chr(10)||' from dba_objects where object_type=''JAVA CLASS'''
 ||chr(13)||chr(10)||
 ' and status=''VALID'' and object_id not in (select obj# from sys.javaobj$);'
 ||chr(13)||chr(10)||'commit;'
 from dba_objects
 where object_type='JAVA CLASS'
 and status='VALID'
 and object_id not in (select obj# from sys.javaobj$);

select unique '-- Please correct the issue described in Note 2397585.1:'
 ||chr(13)||chr(10)||
 'delete from SYS.AUDIT$ where OPTION# in (83,84);'
  ||chr(13)||chr(10)||'commit;'
 from sys.audit$ where OPTION# in (83,84);


-- Remove auditing
/*
NOAUDIT;
NOAUDIT session;
NOAUDIT session BY scott, hr;
NOAUDIT DELETE ON emp;
NOAUDIT SELECT TABLE, INSERT TABLE, DELETE TABLE, EXECUTE PROCEDURE;
NOAUDIT ALL;
NOAUDIT ALL PRIVILEGES;
NOAUDIT ALL ON DEFAULT;
noaudit session by appowner;
noaudit create session by appowner;
noaudit SELECT TABLE by appowner;
noaudit INSERT TABLE by appowner;
noaudit EXECUTE PROCEDURE by appowner;
noaudit DELETE TABLE by appowner;
noaudit DELETE ANY TABLE by appowner;
*/

-- Script for check all the enabled auditing on Database

--Check the parameter is enabled or disable for Audit
select name || '=' || value PARAMETER from sys.v_$parameter where name like '%audit%';
--Statement Audits Enabled on this Database
column user_name format a10
column audit_option format a40
select USER_NAME , PROXY_NAME , AUDIT_OPTION , SUCCESS , FAILURE  from sys.dba_stmt_audit_opts;

--Privilege Audits Enabled on this Database


select USER_NAME , PROXY_NAME , PRIVILEGE, SUCCESS , FAILURE
from dba_priv_audit_opts;

-- Object Audits Enabled on this Database
select (owner ||'.'|| object_name) object_name,
alt, aud, com, del, gra, ind, ins, loc, ren, sel, upd, ref, exe
from dba_obj_audit_opts
where alt != '-/-' or aud != '-/-'
or com != '-/-' or del != '-/-'
or gra != '-/-' or ind != '-/-'
or ins != '-/-' or loc != '-/-'
or ren != '-/-' or sel != '-/-'
or upd != '-/-' or ref != '-/-'
or exe != '-/-';
PRO
PRO
PRO --Default Audits Enabled on this Database
PRO -- select * from all_def_audit_opts;
PRO
PRO

set serveroutput on
Declare
Begin
for policy_rec in (
select distinct POLICY_OWNER, policy_name from
&varskip_10g_column &varskip_11g_column AUDIT_UNIFIED_POLICIES
&varskip_12c_column &varskip_18c_column &varskip_19c_column DBA_AUDIT_POLICIES
where policy_name not in ('ORA_ACCOUNT_MGMT','ORA_DATABASE_PARAMETER','ORA_SECURECONFIG',
'ORA_DV_AUDPOL','ORA_DV_AUDPOL2','ORA_RAS_POLICY_MGMT','ORA_RAS_SESSION_MGMT','ORA_LOGON_FAILURES',
'ORA_STIG_RECOMMENDATIONS','ORA_LOGON_LOGOFF','ORA_ALL_TOPLEVEL_ACTIONS','ORA_CIS_RECOMMENDATIONS')
order by policy_name
)
loop

dbms_output.put_line('<BR> ' );
dbms_output.put_line('POLICY_NAME '|| policy_rec.policy_name);
dbms_output.put_line('----------------------------------------');
&varskip_10g_column &varskip_11g_column DBMS_METADATA.GET_DDL('AUDIT_POLICY',policy_rec.policy_name,policy_rec.POLICY_OWNER);

end loop;
end;
/

@rockdb/sql/footerhtml01
