DEFINE vhtmlpage='index_'
DEFINE vtitlethispage='Main options'
DEFINE viconthispage='server.svg'

@rockdb/sql/headerhtmlspool.sql
-- @rockdb/sql/page_label "&vtitlethispage"

PRO <style type="text/css">
PRO tr:hover         {color:white; background:#0066CC;color:white; background-color: white}
PRO </style>

PRO <body>
PRO <p>&varhtmlspace</p>

PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Dashboard </h1>
PRO     <iframe src="dbpie_dashboard_&var_namefile" height="1175" width="1350"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO <BR>
PRO     <iframe src="dbgauge_dashboard_&var_namefile" height="450" width="1350"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO <BR>

PRO <p>&varhtmlspace</p>
PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  &var_instancename - Check itens </h1>
PRO <h3>01 - <a title="Points of attention "  href="list_checklist_&var_namefile">Points of attention</a></h3>
PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">


PRO <p>&varhtmlspace</p>



PRO <table>
PRO <tbody>
PRO <tr>
PRO <td>
PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Database  </h1>
PRO <h3>01 - <a title="Properties"  href="dbinfo01_&var_namefile">Properties</a></h3>
PRO <h3>02 - <a title="Options"  href="list_options01_&var_namefile">Options</a></h3>
PRO <h3>03 - <a title="Version"  href="list_version01_&var_namefile">Version</a></h3>
PRO <h3>04 - <a title="Encrypt Wallet"  href="list_encrypted_info01_&var_namefile">Encrypt Wallet</a></h3>
PRO <h3>05 - <a title="Size"  href="list_size_db01_&var_namefile">Size</a></h3>
PRO <h3>06 - <a title="NLS Characterset"  href="list_nls_characters01_&var_namefile">NLS Characterset</a></h3>
PRO <h3>07 - <a title="Components"  href="list_dba_registry01_&var_namefile">Components</a></h3>
PRO <h3>08 - <a title="Purge recyclebin"  href="list_purge_recyclebin01_&var_namefile">Purge recyclebin</a></h3>
PRO </td>
PRO <td>
PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>Backup report </h1>
PRO <h3>01 - <a title="Rman backup"  href="list_rmanbkp01_&var_namefile">Rman backup</a></h3>
PRO <h3>02 - <a title="Backup Spfile"  href="list_rman_backupspfile01_&var_namefile">Backup Spfile</a></h3>
PRO <h3>03 - <a title="Backup Size"  href="list_rman_backupsize01_&var_namefile">Backup Size</a></h3>
PRO <h3>04 - <a title="Backup Set"  href="list_rman_backupset01_&var_namefile">Backup Set</a></h3>
PRO <h3>05 - <a title="Backup Piece"  href="list_rman_backuppiece01_&var_namefile">Backup Pieces</a></h3>
PRO <h3>06 - <a title="Rman Jobs"  href="list_rman_backupjob01_&var_namefile">Rman Jobs</a></h3>
PRO <h3>07 - <a title="Corrupted blocks"  href="list_corruptblock_&var_namefile">Corrupted blocks</a></h3>
PRO </td>

PRO <td>
PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Gaphics  </h1>
PRO <h3>01 - <a title="Tablespaces"  href="bar_tablespace_&var_namefile">Tablespaces </a></h3>
PRO <h3>02 - <a title="Archives per day"  href="bar_archiveperday_&var_namefile">Archives per day </a></h3>
PRO <h3>03 - <a title="Dashboard in Gauges - invalid objects,open cursors..  "  href="dbgauge_dashboard_&var_namefile">Dashboard Gauges </a></h3>
PRO <h3>04 - <a title="Dashboard in Pie - invalid objects,open cursors..  "  href="dbpie_dashboard_&var_namefile">Dashboard Pie </a></h3>
PRO </td>

PRO <td>
PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Export Import</h1>
PRO <h3>01 - <a title="Expdp - script to export ddl and data"  href="expdp_script_create01_&var_namefile">Expdp - script to export ddl and data</a></h3>
PRO <h3>02 - <a title="Impdp - script to import ddl and data"  href="impdp_script_create01_&var_namefile">Impdp - script to import ddl and data</a></h3>
PRO <h3>03 - <a title="Statistics - scripts to collect statistics"  href="script_stats_db01_&var_namefile">Statistics - scripts to collect statistics</a></h3>
PRO </td>


PRO </tr>

PRO <tr>
PRO <td>
PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Configuration  </h1>
PRO <h3>01 - <a title="Parameters Hidden"  href="list_param_hidden01_&var_namefile">Parameters Hidden</a></h3>
PRO <h3>02 - <a title="Parameters non default"  href="list_param_nondefault01_&var_namefile">Parameters non default</a></h3>
PRO <h3>03 - <a title="Parameters Modified"  href="list_param_nondefault01_&var_namefile">Parameters Modified</a></h3>
PRO <h3>04 - <a title="Memory Configuration"  href="list_memory01_&var_namefile">Memory Configuration</a></h3>
PRO <h3>05 - <a title="Migration"  href="index_text_ddl_&var_namefile">Migration</a></h3>
PRO <h3>05 - <a title="Oracle Text"  href="index_text_ddl_&var_namefile">Oracle Text</a></h3>



PRO </td>
PRO <td>
PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Tablespace  </h1>
PRO <h3>01 - <a title="Tablespace space used"  href="list_tablespacedb01_&var_namefile">Tablespace space used</a></h3>
PRO <h3>02 - <a title="Tablespace SYSAUX"  href="list_script_sysauxsize01_&var_namefile">Tablespace SYSAUX</a></h3>

PRO </td>
PRO <td>
PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Misc  </h1>


PRO <h3>01 - <a title="Redo log file"  href="list_redolog01_&var_namefile">Redo log file</a></h3>
PRO <h3>02 - <a title="Archive per hour total"  href="list_archivehour01_&var_namefile">Archive per hour total</a></h3>
PRO <h3>03 - <a title="Archive per hour MB"  href="list_archivemb01_&var_namefile">Archive per hour MB</a></h3>
PRO <h3>04 - <a title="List Locked statistics"  href="list_locked_stats01_&var_namefile">List Locked statistics</a></h3>

PRO <h3>05 - <a title="Invalid objects "  href="list_invalidobjects01_&var_namefile">Invalid objects</a></h3>
PRO <h3>06 - <a title="Triggers Disabled "  href="list_disabledtriggers01_&var_namefile">Triggers Disabled </a></h3>
PRO <h3>07 - <a title="Triggers Database "  href="list_databasetriggers01_&var_namefile">Triggers Database </a></h3>
PRO <h3>08 - <a title="Rebuild index candidate"  href="list_rebuildindex01_&var_namefile">Rebuild index candidate</a></h3>

PRO <h3>09 - <a title="Object Directory"  href="list_directory01_&var_namefile">Object Directory</a></h3>
PRO <h3>10 - <a title="List Patch"  href="list_patch01_&var_namefile">List Patch</a></h3>
PRO <h3>11 - <a title="Oracle Text"  href="index_text_ddl_&var_namefile">Oracle Text</a></h3>
PRO <h3>12 - <a title="Rman backup"  href="list_rmanbkp01_&var_namefile">Rman backup</a></h3>


PRO </td>

PRO <td>

PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  DDL - Scripts  </h1>
PRO <h3>01 - <a title="ACL - List Access Control List"  href="acl_ddl_&var_namefile">ACL - List Access Control List</a></h3>
PRO <h3>02 - <a title="Audit - Audit default"  href="audit_ddl_&var_namefile">Audit - Audit default</a></h3>
PRO <h3>03 - <a title="Audit - Audit default - script oracle"  href="getaud_&var_namefile">Audit - Audit default  - script oracle</a></h3>
PRO <h3>04 - <a title="Dblink - recreate ddl dblink "  href="dblink_ddl_&var_namefile">Dblink - recreate ddl dblink </a></h3>
PRO <h3>05 - <a title="Directory - list non default directory "  href="directory_ddl_&var_namefile">Directory - list non default directory </a></h3>
PRO <h3>06 - <a title="Jobs - DBA_SCHEDULER "  href="job_ddl_&var_namefile">Jobs - DBA_SCHEDULER  </a></h3>
PRO <h3>07 - <a title="Jobs - DBMS_JOB to DBA_SCHEDULER "  href="job_ddl_19c_&var_namefile">Jobs - DBMS_JOB to DBA_SCHEDULER </a></h3>
PRO <h3>08 - <a title="Roles - Non default roles"  href="role_ddl_&var_namefile">Roles - Non default roles</a></h3>
PRO <h3>09 - <a title="Tablespaces"  href="tablespace_ddl_&var_namefile">Tablespaces</a></h3>
PRO <h3>10 - <a title="Trigger - database trigger"  href="trigger_ddl_&var_namefile">Trigger - database trigger</a></h3>
PRO <h3>11 - <a title="User - ddl for non default user "  href="user_ddl_create_&var_namefile">User - ddl for non default user </a></h3>
PRO <h3>12 - <a title="User - ddl   "  href="user_ddl_&var_namefile">User - ddl  </a></h3>


PRO </td>


PRO </tr>
PRO </tbody>
PRO </table>

-- Listar as tabela com compressao
-- Descobrir se tem alguma coleta estatistica diferenciada
-- Descobrir se tem alguma coleta estatistica lock para alguma tabela
-- Contar se tem tabela particionada e indice particionado
-- verificar se tem Olap e User defined types
-- Verificar o indice bitmap, tabela CLUSTER
-- Listar parametros requer atencao-  job_que_processes, hidden parameters
-- Listar configuracao do RMAN
-- Listar os jobs - com status broken ou normal



PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <p>&varhtmlspace</p>



PRO
PRO <p>&varhtmlspace</p>
PRO <p>&varhtmlspace</p>
PRO <p>&varhtmlspace</p>
/*
PRO <p>UNDER IMPLEMENTATION FROM THIS POINT</p>
PRO <h1>  Database RMAN report - to be implemented </h1>
PRO <h3>01 - <a title="Rman output  "  href="list_rmanbkp_&var_namefile">Rman report</a></h3>
PRO <h3>02 - <a title="Report rman Backup - external script"  href="report_rman_backup01_&var_namefile">Report rman Backup - external script</a></h3>

PRO <h1>  Dataguard  </h1>
PRO <h3>01 - <a title="Redo, standby ddl"  href="dataguard_config_&var_namefile">Redo, standby ddl</a></h3>

PRO <p>&varhtmlspace</p>
PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  TO be implemented: Duplicate  </h1>
PRO <h3>01 - <a title="Duplicate database"  href="dbduplicate_&var_namefile">Duplicate database</a></h3>
PRO <h3>02 - <a title="Statistics"  href="dbinfo01_&var_namefile">Database properties</a></h3>
PRO <h3>03 - <a title="Exadata PDBClone"  href="https://docs.oracle.com/en/cloud/cloud-at-customer/exadata-cloud-at-customer/exacc/dbaascli-pdb-remote_clone.html">Exadata PDBClone</a></h3>


PRO <p>&varhtmlspace</p>
PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  to be implemented: Wallet usefull  </h1>
PRO <h3>01 - <a title="Manage wallet"  href="dbduplicate_&var_namefile">Manage wallet</a></h3>


PRO <p>&varhtmlspace</p>
PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  to be implemented: More checks - May need activate external tools </h1>
PRO <h3>01 - <a title="HCheck results Doc ID 136697.1"  href="hckeck_&var_namefile">HCheck Doc ID 136697.1</a></h3>
PRO <h3>02 - <a title="KSar linux Graphics Performance Outputs"  href="ksaroutput_&var_namefile">KSar linux Graphics Performance Outputs</a></h3>

*/


@rockdb/sql/footerhtml01
