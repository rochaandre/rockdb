#+-----------------------------------------------------------------+
#| Parameters                                                      |
#+-----------------------------------------------------------------+
USERID=$1
PASSWO=$2
CONNST=$3
EXPDPD=$4

# 11g
USERID=dbajobs
PASSWO=dbajobs
CONNST=192.168.1.180:1521/preprom
EXPDPD=DIREXPDP

# 12c
USERID=admin
PASSWO=MinhaSenha123
CONNST=orcl_high
EXPDPD=DIREXPDP

#+-----------------------------------------------------------------+
#| Define                                                         |
#+-----------------------------------------------------------------+
sqlplus $USERID/$PASSWO@$CONNST <<EOF
@report/sql/definecfg.sql
@report/list/dbinfo01.sql
@report/sql/generate_menu01.sql
@report/list/list_checklist01.sql
@report/list/list_version01.sql
@report/list/list_options01.sql
@report/list/list_encrypted_info01.sql
@report/list/list_param_modif01.sql
@report/list/list_param_nondefault01.sql
@report/list/list_param_hidden01.sql
@report/list/list_memory01.sql
@report/list/list_disabledtriggers01.sql
@report/list/list_invalidobjects01.sql
@report/list/list_size_db01.sql
@report/list/list_script_preexportdb01.sql
@report/list/list_rmanbkp01.sql
@report/list/list_archivehour01.sql
@report/list/list_dba_registry01.sql
@report/list/list_dba_usage01.sql
@report/list/list_options01.sql
@report/list/list_locked_stats01.sql
@report/list/list_nls_characters01.sql
@report/list/list_rebuildindex01.sql
@report/ddlscript/acl_ddl.sql
@report/ddlscript/audit_ddl.sql
@report/ddlscript/directory_ddl.sql
@report/ddlscript/dblink_ddl.sql
@report/ddlscript/getaud.sql
@report/ddlscript/job_ddl.sql
@report/ddlscript/job_ddl_19c.sql
--@report/ddlscript/role_ddl.sql
@report/ddlscript/tablespace_ddl.sql
@report/ddlscript/trigger_ddl.sql
@report/ddlscript/user_ddl.sql
@report/ddlscript/user_ddl_create.sql
@report/ddlscript/user_defined_type.sql
@report/bar/bar_archiveperday.sql
@report/bar/bar_tablespace.sql
@report/gauge/dbgauge_dashboard.sql
@report/gauge/dbgauge_opencursors.sql
@report/gauge/dbgauge_sessions.sql
@report/gauge/dbgauge_processes.sql
@report/gauge/dbgauge_opencursors.sql
@report/gauge/dbgauge_pga.sql
@report/gauge/dbgauge_transaction.sql
@report/gauge/dbgauge_usedspace.sql
@report/gauge/dbgauge_outstandingalerts.sql
@report/gauge/dbgauge_invalidobj.sql
@report/pie/dbpie_dashboard.sql
@report/pie/dbpie_bufferbusywaits01.sql
@report/pie/dbpie_index_invalid01.sql
@report/pie/dbpie_large_pool01.sql
@report/pie/dbpie_object_invalid01.sql
@report/pie/dbpie_object_schema01.sql
@report/pie/dbpie_object_types01.sql
@report/pie/dbpie_resource_current01.sql
@report/pie/dbpie_resource_maxlimit01.sql
@report/pie/dbpie_resource_maxused01.sql
@report/pie/dbpie_segment_bigobjects01.sql
@report/pie/dbpie_segment_maxindex01.sql
@report/pie/dbpie_segment_maxsegment01.sql
@report/pie/dbpie_segment_maxtable01.sql
@report/pie/dbpie_sga_pool01.sql
@report/pie/dbpie_shared_pool01.sql
@report/pie/dbpie_disabled_trigger01
@report/bar/bar_archiveperday.sql
@report/bar/bar_tablespace.sql
@report/script/script_stats_db01.sql
@report/expdp/expdp_script_create01.sql
@report/expdp/impdp_script_create01.sql
@report/expdp/dbinfo_expdp_list01.sql
@report/rman/report_rman_backup01.sql
@report/thirdparty/hcheck/report_hcheck.sql
@report/list/list_script_sysauxsize01.sql
@report/list/list_purge_recyclebin01.sql
EOF


#+-----------------------------------------------------------------+
#| Listar o backup                                                 |
#+-----------------------------------------------------------------+
rman/rman_check.sh
