DEFINE vhtmlpage='expdp_script_create01_'
DEFINE vtitlethispage='script for expdp '
DEFINE viconthispage='server.svg'
@rockdb/sql/headerhtmlspool.sql

PRO <PRE>

PRO
PRO +------------------------------------------------------------------------------+
PRO |     Best pratices to avoid issues and get better performance                 |
PRO +------------------------------------------------------------------------------+
PRO
PRO dba_recycle bin objects
PRO
select count(*) total
from dba_recyclebin
/
PRO
PRO purge dba_recycle bin
PRO
select object_name, original_name, type, can_undrop as "UND", can_purge as "PUR", droptime from dba_recyclebin
where rownum <=10
/

PRO
PRO remove stats from sysaux
PRO
PRO @?/rdbms/admin/awrinfo.sql
PRO begin
PRO for i in reverse 31..100
PRO loop
PRO dbms_stats.purge_stats(sysdate-i);
PRO end loop;
PRO end;


PRO +------------------------------------------------------------------------------+
PRO |     Configure job_queue_processes                                            |
PRO +------------------------------------------------------------------------------+
PRO
PRO alter system set job_queue_processes=0;
PRO
PRO +------------------------------------------------------------------------------+
PRO |     Increase SGA and PGA                                                     |
PRO +------------------------------------------------------------------------------+
PRO
PRO alter system set pga_aggregate_target=50G scope=both;
PRO
PRO +------------------------------------------------------------------------------+
PRO |     Stop JOBs                                                                |
PRO +------------------------------------------------------------------------------+
PRO alter system set job_queue_processes=0 scope=both;
PRO
PRO
PRO +------------------------------------------------------------------------------+
PRO |     Check LOB - parallel not work for LOB                                    |
PRO +------------------------------------------------------------------------------+
PRO Try to separate non blob from blob data - identify the LOB tables
PRO
PRO select segment_name, bytes, owner,
PRO (select table_name from dba_lobs a where d.segment_name = a.segment_name) as tablename, d.tablespace_name
PRO from dba_segments d
PRO where segment_type = 'LOBSEGMENT'
PRO order by bytes desc;
PRO
PRO SELECT  s.tablespace_name ,l.owner,l.table_name,l.column_name,l.segment_name,s.segment_type, round(s.bytes/1024/1024/1024,2) "Size(GB)"
PRO FROM DBA_SEGMENTS s,dba_lobs l
PRO where l.owner = s.owner and l.segment_name = s.segment_name
PRO and l.owner not in ('SYS','SYSTEM','APPS','APPLSYS')
PRO --and round(s.bytes/1024/1024/1024,2)>1
PRO order by s.bytes desc;



PRO +------------------------------------------------------------------------------+
PRO |     Purge logs                                                               |
PRO +------------------------------------------------------------------------------+
PRO
PRO select *
PRO from   (select substr (owner, 1, 10) owner,
PRO                substr (segment_name, 1, 30) seg_name,
PRO                substr (segment_type, 1, 10) type,
PRO                bytes,
PRO                extents,
PRO                rank() over (order by bytes desc) position
PRO         from   dba_segments
PRO         where  tablespace_name = 'SYSAUX'
PRO         order  by bytes, extents desc)
PRO where   position < 10
PRO order   by position
PRO /
PRO EXECUTE DBMS_SCHEDULER.auto_purge;
PRO alter table SCHEDULER$_EVENT_LOG shrink space CASCADE;
PRO execute DBMS_SCHEDULER.PURGE_LOG();


PRO
PRO +------------------------------------------------------------------------------+
PRO |     Increase PGA                                                             |
PRO +------------------------------------------------------------------------------+
PRO alter system set pga_aggregate_target=50G scope=both;
PRO
PRO +------------------------------------------------------------------------------+
PRO |     expdp slow                                                               |
PRO +------------------------------------------------------------------------------+
PRO DataPump Export Is Slow And Appears To Hang (Doc ID 790168.1)
PRO

PRO TRANSFORM=DISABLE_ARCHIVE_LOGGING:Y
PRO sort_write_buffers=6,sort_write_buffer_size=64000,sort_direct_write=true, andsort_area_size
PRO parallel_execution_message_size=32768
PRO dbms_scheduler.disable('BSLN_MAINTAIN_STATS_JOB');
PRO EXEC DBMS_WORKLOAD_REPOSITORY.MODIFY_SNAPSHOT_SETTINGS(INTERVAL=>0);
PRO EXEC DBMS_AUTO_TASK_ADMIN.DISABLE;
PRO After importing re-enable:EXEC DBMS_WORKLOAD_REPOSITORY.MODIFY_SNAPSHOT_SETTINGS(INTERVAL=>15);
PRO EXEC DBMS_AUTO_TASK_ADMIN.ENABLE;
PRO
PRO
PRO After further tests I concluded that the following changes helped with export data pump:
PRO parallel=32, compared to 8, reduced unload times from approximately 40 minutes to 12 minutes
PRO parallel_execution_message_size (data pump workers are fed by PX slaves) was the default of 2152 bytes and increasing it to 16384 reduced the unload by another approximately 5% percent

PRO
PRO
PRO +------------------------------------------------------------------------------+
PRO |   Export with rows and ALL schemas/users.
PRO +------------------------------------------------------------------------------+
PRO
PRO expdp parfile=expdp_par01.par
PRO
PRO expdp USERID=&varUSERDBA/&varPASSDBA@&varCONNSTR JOB_NAME=exp_02NOROWSC&var_instancename DUMPFILE=exp_02NOROWSC$varYYYYMMDD%U.dmp LOG=&varDIREXPD:exp_02NOROWSC&varYYYYMMDD.log DIRECTORY=&varDIREXPD FULL=Y rows=n consistent=y
PRO
PRO expdp USERID=&varUSERDBA/&varPASSDBA@&varCONNSTR JOB_NAME=exp_03FULLROWS&var_instancename DUMPFILE=exp_03FULLROWS$varYYYYMMDD%U.dmp LOG=&varDIREXPD:exp_03FULLROWS&varYYYYMMDD.log DIRECTORY=&varDIREXPD FULL=Y rows=y consistent=y
PRO
PRO
PRO
PRO +------------------------------------------------------------------------------+
PRO |   Parameter expdp_par01.par file
PRO +------------------------------------------------------------------------------+
PRO
PRO
PRO USERID=&varUSERDBA/&varPASSDBA@&varCONNSTR
PRO JOB_NAME=exp_01NOROWSF&var_instancename
PRO DUMPFILE=&var_instancename/&var_instancename$varYYYYMMDD%U.dmp
PRO LOG=&varDIREXPD:&var_instancename/&var_instancename&varYYYYMMDD.log
PRO DIRECTORY=&varDIREXPD
PRO FULL=Y
PRO rows=y
PRO consistent=y
PRO CLUSTER=N
PRO EXCLUDE=STATISTICS
PRO PARALELL=8
PRO
PRO
PRO +------------------------------------------------------------------------------+
PRO |   Parameter expdp_par02.par file
PRO +------------------------------------------------------------------------------+
PRO |    Export with norows and no default schemas/users.
PRO +------------------------------------------------------------------------------+
PRO
PRO USERID=&varUSERDBA/&varPASSDBA@&varCONNSTR
PRO JOB_NAME=exp_01NOROWSF&var_instancename
PRO DUMPFILE=&var_instancename/&var_instancename$varYYYYMMDD%U.dmp
PRO LOG=&varDIREXPD:&var_instancename/&var_instancename&varYYYYMMDD.log
PRO DIRECTORY=&varDIREXPD
PRO FULL=Y
PRO rows=n
PRO consistent=y
PRO CLUSTER=N
PRO EXCLUDE=STATISTICS
PRO exclude=SCHEMA:" IN (&var_internalschemas1)"
PRO exclude=SCHEMA:" IN (&var_internalschemas2)"
PRO exclude=SCHEMA:" IN (&var_internalschemas3)"
PRO exclude=SCHEMA:" IN (&var_internalschemas4)"
PRO exclude=SCHEMA:" IN (&var_internalschemas5)"
PRO exclude=SCHEMA:" IN (&var_internalschemas6)"
PRO exclude=SCHEMA:" IN (&var_internalschemas7)"
PRO exclude=SCHEMA:" IN (&var_internalschemas8)"
PRO exclude=SCHEMA:" IN (&var_internalschemas9)"
PRO exclude=SCHEMA:" IN (&var_internalschemas10)"
PRO exclude=SCHEMA:" IN (&var_internalschemas11)"
PRO exclude=SCHEMA:" IN (&var_internalschemas12)"
PRO exclude=SCHEMA:" IN (&var_internalschemas13)"
PRO exclude=SCHEMA:" IN (&var_internalschemas14)"
PRO
PRO +------------------------------------------------------------------------------+
PRO |   Parameter expdp_par03.par file
PRO +------------------------------------------------------------------------------+
PRO |    Export with norows and all default schemas/users.
PRO +------------------------------------------------------------------------------+
PRO
PRO USERID=&varUSERDBA/&varPASSDBA@&varCONNSTR
PRO JOB_NAME=exp_01NOROWSF&var_instancename
PRO DUMPFILE=&var_instancename/&var_instancename$varYYYYMMDD%U.dmp
PRO LOG=&varDIREXPD:&var_instancename/&var_instancename&varYYYYMMDD.log
PRO DIRECTORY=&varDIREXPD
PRO FULL=Y
PRO rows=n
PRO consistent=y
PRO CLUSTER=N
PRO EXCLUDE=STATISTICS


PRO
PRO </PRE>

@rockdb/sql/footerhtml01
