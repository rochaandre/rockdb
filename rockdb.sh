# Please set:
# VDIRROCKDB -> location for new report
#  Replace all variables below to work on your client session
# VCLIENTEMAIL=''
# VCLIENTEEMERGENCY=''
# VCLIENTNAME=''
# EXPDPD - you export directory (to check export backups only)
#
#USERID=userdba
#PASSWO=passwd
#CONNST=ipdatabase:1521/instancename
#
# create user rockscript identified by pass123;
# grant connect,resource, select any dictionary to ROCKSCRIPT;
#
########
# call example:
# rockdb.bat rockscript pass123 192.168.1.10:1521/orcl DIREXDP
######
export NLS_DATE_FORMAT='dd/mm/yyyy hh24:mi:ss'
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
export ORACLE_HOME=/u01/app/oracle/product/12.2.0.1/db_1
export ORACLE_HOME=/Users/andre/instantclient_19_8
export ORACLE_SID=XE
export ORACLE_PDB_SID=
export VDIRROCKDB=`pwd`/output
export VDIRROCKDBCONFIG=`pwd`
export EXPDPD=DIREXPDP
#export TNS_ADMIN=/Users/andre/instantclient_19_8/wallet_ORCL_soudba
export PATH=/Users/andre/instantclient_19_8:$PATH
# remove old configuration
rm -f config.sql
mkdir -p $VDIRROCKDB

# Doc ID 2082355.1
# V$ACTIVE_SESSION_HISTORY
# SYS.X$ASH (a fixed view)
# DBA_STREAMS_TP_PATH_BOTTLENECK
# DBA_STREAMS_TP_COMPONENT_STAT
# DBA_ADDM_% views
# DBA_ADVISOR_% views (if queried for ADVISOR_NAME='ADDM')
# DBA_HIST_% views (with a few exceptions)
# Most MGMT$% views
# Access to these two views requires purchase of a license for the tuning pack, in addition to one for the diagnostics pack:
#
# V$SQL_MONITOR
# V$SQL_PLAN_MONITOR
# Other restrictions apply to certain DBMS_% packages and SQL scripts.  For example, creation of any of the following types of reports requires purchase of a license for the diagnostics pack:
#
# AWR
# ASH
# ADDM

#+-----------------------------------------------------------------+
#| Parameters                                                      |
#+-----------------------------------------------------------------+
export USERID=$1
export PASSWO=$2
export CONNST=$3
export EXPDPD=$4

# 11g
#USERID=dbajobs
#PASSWO=jobsdba1
#CONNST=192.168.1.28:1521/apex
#EXPDPD=DIREXPDP

# for test only in 12c
#USERID=admin
#PASSWO=
#CONNST=orcl_high
#EXPDPD=DIREXPDP

export VCLIENTEMAIL=''
export VCLIENTEEMERGENCY=''
export VCLIENTNAME=''

# to be configured - avoid to use performance tunning
# currently is checking dba_feature_usage_statistics
# in definecfg.sql - line 30
#DEF varskip_pt_column = '-- notused ';
#DEF varskip_pt_script = ' echo notused ';

echo $VDIRROCKDB

echo DEFINE vclientemail=\'$VCLIENTEMAIL\' > $VDIRROCKDBCONFIG/config.sql
echo DEFINE vclientname=\'$VCLIENTNAME\' >> $VDIRROCKDBCONFIG/config.sql
echo DEFINE vdirrockdb=\'$VDIRROCKDB\' >> $VDIRROCKDBCONFIG/config.sql
echo DEFINE vdirrockdbconfig=\'$VDIRROCKDBCONFIG\' >> $VDIRROCKDBCONFIG/config.sql
echo DEFINE vclientemailemergency=\'$VCLIENTEEMERGENCY\'  >> $VDIRROCKDBCONFIG/config.sql
echo DEFINE varUSERDBA   = \'$USERID\' >> $VDIRROCKDBCONFIG/config.sql
echo DEFINE varPASSDBA   = \'$PASSWO\' >> $VDIRROCKDBCONFIG/config.sql
echo DEFINE varCONNSTR   = \'$CONNST\' >> $VDIRROCKDBCONFIG/config.sql
echo DEFINE varDIREXPD   = \'$EXPDPD\' >> $VDIRROCKDBCONFIG/config.sql
echo DEFINE varSLASH=/ >> $VDIRROCKDBCONFIG/config.sql




#+-----------------------------------------------------------------+
#| Define                                                         |
#+-----------------------------------------------------------------+
sqlplus $USERID/$PASSWO@$CONNST @rockdb.sql

#+-----------------------------------------------------------------+
#| Listar o backup                                                 |
#+-----------------------------------------------------------------+
# rman/rman_check.sh
