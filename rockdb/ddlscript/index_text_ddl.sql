DEFINE vhtmlpage='index_text_ddl_'
DEFINE vtitlethispage='Oracle Text index scripts'
DEFINE viconthispage='index.svg'
@rockdb/sql/headerhtmlspool.sql

PRO <PRE>

PRO
PRO +------------------------------------------------------------------------------+
PRO |            Database Oracle Text INDEX                                        |
PRO +------------------------------------------------------------------------------+
PRO
select ctx_report.create_index_script(
idx_owner||'.'|| idx_name)
 from ctxsys.ctx_indexes
where idx_owner not in
(&var_internalschemas1, &var_internalschemas2,&var_internalschemas3, &var_internalschemas4, &var_internalschemas5
, &var_internalschemas6,&var_internalschemas7,&var_internalschemas8,&var_internalschemas9,&var_internalschemas10,&var_internalschemas11,&var_internalschemas12,&var_internalschemas13, &var_internalschemas14)
/

PRO
PRO
PRO
PRO +------------------------------------------------------------------------------+
PRO |            Preferencies Oracle Text                                          |
PRO +------------------------------------------------------------------------------+
PRO
select * from ctx_preferences where pre_owner <> 'CTXSYS';
/
PRO
PRO
PRO </PRE>
-- Se existe algum JOB no SYS e so copiar para outro esquema e pegar o codigo.
-- exec dbms_scheduler.copy_job('SYS.CLEANUP_ONLINE_IND_BUILD','DBACLASS.CLEANUP_ONLINE_IND_BUILD');

@rockdb/sql/footerhtml01
