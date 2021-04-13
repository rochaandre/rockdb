REM Please set:
REM VDIRROCKDB -> location for new report
REM  Replace all variables below to work on your client session
REM VCLIENTEMAIL=''
REM VCLIENTEEMERGENCY=''
REM VCLIENTNAME=''
REM EXPDPD - you SET  directory (to check SET  backups only)
REM #
REM create user userrockscript identified by pass123;
REM grant connect,resource, select any dictionary to ROCKSCRIPT;
REM #
REM #######
REM create and copy the content to:
REM mkdir c:\rockdb
REM copy * c:\rockdb
REM call example:
REM rockdb.bat userrockscript pass123 192.168.1.10:1521/orcl DIREXDP
REM #####
REM Configure the variables below
REM
SET  NLS_DATE_FORMAT=dd/mm/yyyy hh24:mi:ss
SET  NLS_LANG=AMERICAN_AMERICA.AL32UTF8

REM TEST oracle 19
SET  ORACLE_HOME=/Users/andre/instantclient_19_8
SET  PATH=C:\instantclient_19_6;%PATH%

REM Official:
SET ORACLE_HOME=C:\app\client\Administrador\product\19.0.0\client_1
SET  PATH=C:\app\client\Administrador\product\19.0.0\client_1\bin;%PATH%



REM SET  TNS_ADMIN=C:\instantclient_19_6\tns_admin
REM SET  ORACLE_HOME=/u01/app/oracle/product/12.2.0.1/db_1
REM SET  ORACLE_SID=XE
REM SET  ORACLE_PDB_SID=
REM directory where is running script:
SET  VDIRROCKDB=%cd%\output
SET  VDIRROCKDBCONFIG=%cd%
REM SET  EXPDPD=DIREXPDP

mkdir %VDIRROCKDB%


REM Doc ID 2082355.1
REM V$ACTIVE_SESSION_HISTORY
REM SYS.X$ASH (a fixed view)
REM DBA_STREAMS_TP_PATH_BOTTLENECK
REM DBA_STREAMS_TP_COMPONENT_STAT
REM DBA_ADDM_% views
REM DBA_ADVISOR_% views (if queried for ADVISOR_NAME='ADDM')
REM DBA_HIST_% views (with a few exceptions)
REM Most MGMT$% views
REM Access to these two views requires purchase of a license for the tuning pack, in addition to one for the diagnostics pack:
REM
REM V$SQL_MONITOR
REM V$SQL_PLAN_MONITOR
REM Other restrictions apply to certain DBMS_% packages and SQL scripts.  For example, creation of any of the following types of reports requires purchase of a license for the diagnostics pack:
REM
REM AWR
REM ASH
REM ADDM

REM +-----------------------------------------------------------------+
REM | Parameters                                                      |
REM +-----------------------------------------------------------------+
set USERID=%1
set PASSWO=%2
set CONNST=%3
set EXPDPD=%4

REM 11g
REM set USERID=dbareport
REM set PASSWO=oracle1
REM set CONNST=10.2.0.222:1521/XE
REM set EXPDPD=DIREXPDP

REM for test only in 12c
REM USERID=admin
REM PASSWO=
REM CONNST=orcl_high
REM EXPDPD=DIREXPDP

SET  VCLIENTEMAIL=''
SET  VCLIENTEEMERGENCY=''
SET  VCLIENTNAME=''

REM to be configured - avoid to use performance tunning
REM currently is checking dba_feature_usage_statistics
REM in definecfg.sql - line 30
REM DEF varskip_pt_column = '-- notused ';
REM DEF varskip_pt_script = ' echo notused ';

echo DEFINE vclientemail=%VCLIENTEMAIL%  > %VDIRROCKDBCONFIG%\config.sql
echo DEFINE vclientname=%VCLIENTNAME% >> %VDIRROCKDBCONFIG%\config.sql
echo DEFINE VDIRROCKDB=%VDIRROCKDB% >> %VDIRROCKDBCONFIG%\config.sql
echo DEFINE VDIRROCKDBCONFIG=%VDIRROCKDBCONFIG% >> %VDIRROCKDBCONFIG%\config.sql
echo DEFINE vclientemailemergency=%VCLIENTEEMERGENCY%  >> %VDIRROCKDBCONFIG%\config.sql
echo DEFINE varUSERDBA=%USERID% >> %VDIRROCKDBCONFIG%\config.sql
echo DEFINE varPASSDBA=%PASSWO% >> %VDIRROCKDBCONFIG%\config.sql
echo DEFINE varCONNSTR=%CONNST% >> %VDIRROCKDBCONFIG%\config.sql
echo DEFINE varDIREXPD=%EXPDPD% >> %VDIRROCKDBCONFIG%\config.sql
echo DEFINE varSLASH=\ >> %VDIRROCKDBCONFIG%\config.sql

REM +-----------------------------------------------------------------+
REM | Define                                                         |
REM +-----------------------------------------------------------------+
sqlplus.exe %USERID%/%PASSWO%@%CONNST% @rockdb.sql


REM +-----------------------------------------------------------------+
REM | Listar o backup                                                 |
REM +-----------------------------------------------------------------+
REM rman/rman_check.sh
