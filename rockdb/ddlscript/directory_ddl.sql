DEFINE vhtmlpage='directory_ddl_'
DEFINE vtitlethispage='Directory DDL'
DEFINE viconthispage='mailbox.svg'
@report/sql/headerhtmlspool.sql



PRO <PRE>

COLUMN grantee   FORMAT A20
COLUMN owner     FORMAT A10
COLUMN grantor   FORMAT A20
COLUMN privilege FORMAT A20


PRO
PRO +------------------------------------------------------------------------------+
PRO |            DIRECTORY  NON DEFAULT                                            |
PRO +------------------------------------------------------------------------------+
PRO

SELECT DBMS_METADATA.get_ddl ('DIRECTORY',   directory_name) ddl
FROM   dba_directories
WHERE DIRECTORY_NAME not in ('SDO_DIR_WORK','SDO_DIR_ADMIN','OPATCH_INST_DIR','ORACLE_OCM_CONFIG_DIR2','ORACLE_BASE',
'ORACLE_HOME','ORACLE_OCM_CONFIG_DIR','DBMS_OPTIM_LOGDIR','DBMS_OPTIM_ADMINDIR','OPATCH_SCRIPT_DIR',
'OPATCH_LOG_DIR','JAVA$JOX$CUJS$DIRECTORY$','DATA_PUMP_DIR','SQL_TCB_DIR','SCHEDULER$_LOG_DIR' )
/

PRO
PRO +------------------------------------------------------------------------------+
PRO |            DIRECTORY      DEFAULT                                            |
PRO +------------------------------------------------------------------------------+
PRO

SELECT DBMS_METADATA.get_ddl ('DIRECTORY',   directory_name) ddl
FROM   dba_directories
WHERE DIRECTORY_NAME  in ('SDO_DIR_WORK','SDO_DIR_ADMIN','OPATCH_INST_DIR','ORACLE_OCM_CONFIG_DIR2','ORACLE_BASE',
'ORACLE_HOME','ORACLE_OCM_CONFIG_DIR','DBMS_OPTIM_LOGDIR','DBMS_OPTIM_ADMINDIR','OPATCH_SCRIPT_DIR',
'OPATCH_LOG_DIR','JAVA$JOX$CUJS$DIRECTORY$','DATA_PUMP_DIR','SQL_TCB_DIR','SCHEDULER$_LOG_DIR' )
/

@report/sql/footerhtml01
