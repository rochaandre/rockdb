DEFINE vhtmlpage='user_ddl_password_'
DEFINE vtitlethispage='Users DDL password'
DEFINE viconthispage='file-person.svg'
@report/sql/headerhtmlspool.sql

PRO <PRE>

col comando for a290
PRO
PRO +------------------------------------------------------------------------------+
PRO |            USER DDL                                                          |
PRO +------------------------------------------------------------------------------+
PRO

select 'alter user "'||d.username||'" identified by values '''||u.password||''' account unlock;' comando
from dba_users d, sys.user$ u
where d.username not in ('SYS','SYSTEM','ANONYMOUS','CTXSYS','HR','MDSYS','ODM','ODM_MTR','OE',
'OLAPSYS','ORDPLUGINS','ORDSYS','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS',
'QS_WS','SCOTT','SH','WKPROXY','WKSYS','WMSYS','XDB','DBSNMP','SYSMAN','MGMT_VIEW','SI_INFORMTN_SCHEMA',
'DMSYS','DIP','OUTLN','EXFSYS','MDDATA','TSMSYS','APEX_PUBLIC_USER','FLOWS_FILES','OWBSYS','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR',
'XS$NULL','APEX_030200','APPQOSSYS','ORDDATA','OWBSYS_AUDIT','ORACLE_OCM','UNICOM')
and u.user# = d.user_id;


@report/sql/footerhtml01
