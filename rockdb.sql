PRO Config
@config.sql
@rockdb/sql/definecfg.sql
PRO ------Menu
@rockdb/sql/generate_menu01.sql
@rockdb/sql/generate_rman_menu01.sql
PRO ---------List
@rockdb/list/dbinfo01.sql
@rockdb/list/list_tablespacedb01.sql
@rockdb/list/list_redolog01.sql
@rockdb/list/list_checklist01.sql
@rockdb/list/list_version01.sql
@rockdb/list/list_corruptblock01.sql
@rockdb/list/list_options01.sql
@rockdb/list/list_encrypted_info01.sql
@rockdb/list/list_param_modif01.sql
@rockdb/list/list_param_nondefault01.sql
@rockdb/list/list_param_hidden01.sql
@rockdb/list/list_memory01.sql
@rockdb/list/list_disabledtriggers01.sql
@rockdb/list/list_invalidobjects01.sql
@rockdb/list/list_size_db01.sql
@rockdb/list/list_script_preexportdb01.sql
PRO -------------List
@rockdb/list/list_rmanbkp01.sql
@rockdb/list/list_patch01.sql
@rockdb/list/list_rman_backupspfile01.sql
@rockdb/list/list_rman_backupsize01.sql
@rockdb/list/list_rman_backupset01.sql
@rockdb/list/list_rman_backuppiece01.sql
@rockdb/list/list_rman_backupjob01.sql
PRO ------------------List
@rockdb/list/list_archivehour01.sql
@rockdb/list/list_archivemb01.sql
@rockdb/list/list_dba_registry01.sql
@rockdb/list/list_dba_usage01.sql
@rockdb/list/list_options01.sql
@rockdb/list/list_locked_stats01.sql
@rockdb/list/list_nls_characters01.sql
@rockdb/list/list_rebuildindex01.sql
@rockdb/list/list_databasetriggers01.sql
@rockdb/list/list_directory01.sql
@rockdb/list/list_script_sysauxsize01.sql
@rockdb/list/list_purge_recyclebin01.sql
PRO -----------------------ddl
@rockdb/ddlscript/acl_ddl.sql
@rockdb/ddlscript/audit_ddl.sql
@rockdb/ddlscript/directory_ddl.sql
@rockdb/ddlscript/dblink_ddl.sql
@rockdb/ddlscript/getaud.sql
@rockdb/ddlscript/index_text_ddl.sql
@rockdb/ddlscript/job_ddl.sql
@rockdb/ddlscript/job_ddl_19c.sql
-- @rockdb/ddlscript/role_ddl.sql  -- can spend a lot of time
PRO --------------------------ddl
@rockdb/ddlscript/tablespace_ddl.sql
@rockdb/ddlscript/trigger_ddl.sql
@rockdb/ddlscript/user_ddl.sql
@rockdb/ddlscript/user_ddl_create.sql
@rockdb/ddlscript/user_defined_type.sql
PRO ------------------------------bar
@rockdb/bar/bar_archiveperday.sql
@rockdb/bar/bar_tablespace.sql
PRO ------------------------------------Gauge
@rockdb/gauge/dbgauge_dashboard.sql
@rockdb/gauge/dbgauge_opencursors.sql
@rockdb/gauge/dbgauge_sessions.sql
@rockdb/gauge/dbgauge_processes.sql
@rockdb/gauge/dbgauge_opencursors.sql
@rockdb/gauge/dbgauge_pga.sql
@rockdb/gauge/dbgauge_transaction.sql
@rockdb/gauge/dbgauge_usedspace.sql -- can spend a lot of time
@rockdb/gauge/dbgauge_outstandingalerts.sql
@rockdb/gauge/dbgauge_invalidobj.sql
PRO ----------------------------------------Pie
@rockdb/pie/dbpie_dashboard.sql
@rockdb/pie/dbpie_shared_pool01.sql
@rockdb/pie/dbpie_sga_pool01.sql
@rockdb/pie/dbpie_segment_maxtable01.sql
@rockdb/pie/dbpie_segment_maxsegment01.sql
@rockdb/pie/dbpie_segment_maxindex01.sql
@rockdb/pie/dbpie_segment_bigobjects01.sql
@rockdb/pie/dbpie_resource_maxused01.sql
@rockdb/pie/dbpie_resource_maxlimit01.sql
@rockdb/pie/dbpie_resource_current01.sql
@rockdb/pie/dbpie_object_types01.sql
@rockdb/pie/dbpie_object_schema01.sql
@rockdb/pie/dbpie_object_schema02.sql
@rockdb/pie/dbpie_shared_poolcontents01.sql
@rockdb/pie/dbpie_shared_poolcontents02.sql
@rockdb/pie/dbpie_disabled_trigger01.sql
@rockdb/pie/dbpie_rowlockwaits01.sql
@rockdb/pie/dbpie_rowlockwaits02.sql
@rockdb/pie/dbpie_physicalwaits02.sql
@rockdb/pie/dbpie_physicalwaits01.sql
@rockdb/pie/dbpie_bufferbusywaits03.sql
@rockdb/pie/dbpie_bufferbusywaits02.sql
@rockdb/pie/dbpie_result_cache01.sql
@rockdb/pie/dbpie_bufferbusywaits01.sql
@rockdb/pie/dbpie_disabled_trigger02.sql
@rockdb/pie/dbpie_index_unusable01.sql
@rockdb/pie/dbpie_index_unusable02.sql
@rockdb/pie/dbpie_large_pool01.sql
@rockdb/pie/dbpie_object_invalid01.sql
@rockdb/pie/dbpie_object_invalid02.sql
PRO -------------------------------------------Scripts
@rockdb/script/script_stats_db01.sql
PRO ----------------------------------------------expdp
@rockdb/expdp/expdp_script_create01.sql
@rockdb/expdp/impdp_script_create01.sql
@rockdb/expdp/dbinfo_expdp_list01.sql
@rockdb/rman/rockdb_rman_backup01.sql
@rockdb/thirdparty/hcheck/rockdb_hcheck.sql
PRO -------------------------------------------------Dataguard
@rockdb/dataguard/dataguard_config.sql
--@rockdb/sql/create_sendemail.sql
--@rockdb/sql/creatermansendemail01.sql
PRO ----------------------------------------------------- zip!
@rockdb/sql/zipoutputrockdb.sql
--host chmod +x &var_outputfolder/*.sh
--host &var_outputfolder/sendemail.sh
--host &var_outputfolder/sendrmanemail.sh
--host &var_outputfolder/zipoutputrockdb.sh
--host &var_outputfolder/zipoutputrockdb.sh
exit
