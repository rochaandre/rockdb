DEFINE vhtmlpage='job_ddl_'
DEFINE vtitlethispage='Jobs scripts'
DEFINE viconthispage='server.svg'
@report/sql/headerhtmlspool.sql

PRO <PRE>

PRO
PRO +------------------------------------------------------------------------------+
PRO |            Jobs for this database DBA_SCHEDULER_JOBS   non SYS               |
PRO +------------------------------------------------------------------------------+
PRO
SELECT  DBMS_METADATA.get_ddl ('PROCOBJ', job_name, owner)
FROM   dba_scheduler_jobs
where owner NOT IN ('SYS','C##CLOUD$SERVICE','ORDS_METADATA','APEX_200200')
/

select 'exec dbms_job.isubmit(job=>'||job||',what=>'''||what||''',next_date=>'''||next_date||''',interval=>'''||interval||''',no_parse=>TRUE);' from dba_jobs
/

PRO
PRO +------------------------------------------------------------------------------+
PRO |            Jobs for this database DBA_SCHEDULER_JOBS  in SYS                 |
PRO +------------------------------------------------------------------------------+
PRO

PRO for Jobs in SYS we need create a user and copy the job to the new schema.
PRO
PRO exec dbms_scheduler.copy_job('sys.kill_hung_session','oracle.kill_hung_session_copy');
SELECT 'dbms_scheduler.copy_job('||''''||job_name||''''||','
||''''||'NEWSCHEMA.'||job_name||''''||');'
FROM   dba_scheduler_jobs
where owner IN ('SYS','C##CLOUD$SERVICE','ORDS_METADATA','APEX_200200')
/
select 'exec dbms_job.isubmit(job=>'||job||',what=>'''||what||''',next_date=>'''||next_date||''',interval=>'''||interval||''',no_parse=>TRUE);' from dba_jobs
/
PRO
PRO execute this script again:
PRO
PRO SELECT  DBMS_METADATA.get_ddl ('PROCOBJ', job_name, owner)
PRO FROM   dba_scheduler_jobs
PRO where owner IN ('SYS','C##CLOUD$SERVICE','ORDS_METADATA','APEX_200200')
PRO



PRO +------------------------------------------------------------------------------+
PRO | From this point are examples:       Error - ORA-31603   - EXAMPLES           |
PRO +------------------------------------------------------------------------------+
PRO
PRO
PRO But what if the job owner is SYS? Will the same syntax work?
PRO
PRO SQL> select dbms_metadata.get_ddl('PROCOBJ','CLEANUP_ONLINE_IND_BUILD','SYS') from dual;
PRO ERROR:
PRO ORA-31603: object "CLEANUP_ONLINE_IND_BUILD" of type PROCOBJ not found in schema "SYS"
PRO ORA-06512: at "SYS.DBMS_METADATA", line 6069
PRO ORA-06512: at "SYS.DBMS_METADATA", line 8666
PRO ORA-06512: at line 1
PRO
PRO SQL> select owner,job_name from dba_scheduler_jobs where job_name='CLEANUP_ONLINE_IND_BUILD';
PRO
PRO OWNER JOB_NAME
PRO ------------ ----------------------------------
PRO SYS CLEANUP_ONLINE_IND_BUILD
PRO
PRO SQL> exec dbms_scheduler.copy_job('SYS.CLEANUP_ONLINE_IND_BUILD','DBACLASS.CLEANUP_ONLINE_IND_BUILD');
PRO
PRO PL/SQL procedure successfully completed.
PRO
PRO
PRO SQL> select owner,job_name from dba_scheduler_jobs where job_name='CLEANUP_ONLINE_IND_BUILD';
PRO
PRO OWNER JOB_NAME
PRO ------------ ----------------------------------
PRO SYS CLEANUP_ONLINE_IND_BUILD
PRO DBACLASS CLEANUP_ONLINE_IND_BUILD -- >> another copy of that job
PRO
PRO SQL> select dbms_metadata.get_ddl('PROCOBJ','CLEANUP_ONLINE_IND_BUILD','BSSDBA') from dual;
PRO
PRO DBMS_METADATA.GET_DDL('PROCOBJ','CLEANUP_ONLINE_IND_BUILD','BSSDBA')
PRO --------------------------------------------------------------------------------
PRO
PRO
PRO BEGIN
PRO dbms_scheduler.create_job('"CLEANUP_ONLINE_IND_BUILD"',
PRO job_type=>'PLSQL_BLOCK', job_action=>
PRO 'declare
PRO myinterval number;
PRO begin
PRO myinterval := dbms_pdb.cleanup_task(2);
PRO if myinterval <> 0 then
PRO next_date := systimestamp +
PRO numtodsinterval(myinterval, ''second'');
PRO end if;
PRO end;'
PRO , number_of_arguments=>0,
PRO start_date=>TO_TIMESTAMP_TZ('07-JUL-2014 05.53.58.299360000 AM -07:00','DD-MON-R
PRO RRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=>
PRO 'FREQ = HOURLY; INTERVAL = 1'
PRO , end_date=>NULL,
PRO job_class=>'"SCHED$_LOG_ON_ERRORS_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comme
PRO nts=>
PRO 'Cleanup Online Index Build'
PRO );
PRO COMMIT;
PRO END;
-- Se existe algum JOB no SYS e so copiar para outro esquema e pegar o codigo.
-- exec dbms_scheduler.copy_job('SYS.CLEANUP_ONLINE_IND_BUILD','DBACLASS.CLEANUP_ONLINE_IND_BUILD');

@report/sql/footerhtml01
