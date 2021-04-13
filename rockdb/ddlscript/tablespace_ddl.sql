DEFINE vhtmlpage='tablespace_ddl_'
DEFINE vtitlethispage='Tablespace DDL'
DEFINE viconthispage='server.svg'
@rockdb/sql/headerhtmlspool.sql
PRO <PRE>

PRO
PRO +------------------------------------------------------------------------------+
PRO |            TABLESPACES                                                       |
PRO +------------------------------------------------------------------------------+
PRO

select  dbms_metadata.get_ddl('TABLESPACE',tablespace_name) from DBA_TABLESPACES
where tablespace_name not in ('SYSTEM','SYSAUX','UNDOTBS1','UNDOTBS2','UNDOTBS3')
/

@rockdb/sql/footerhtml01
