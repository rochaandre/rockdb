DEFINE vhtmlpage='job_ddl_19c_'
DEFINE vtitlethispage='Jobs transformed to 11g/12c/18c/19c/21c scripts '
DEFINE viconthispage='server.svg'
@report/sql/headerhtmlspool.sql


PRO
PRO <PRE>
PRO +------------------------------------------------------------------------------+
PRO |            Jobs converted to 11G and upper                                   |
PRO +------------------------------------------------------------------------------+
PRO


WITH
 queryintervaloriginal AS (
  SELECT job,   TRUNC(MONTHS_BETWEEN(next_DATE, LAST_DATE)) AS FREQ_MONTH
         ,(TRUNC(next_DATE) - TRUNC(LAST_DATE)) AS FREQ_DAY
         , ROUND((next_DATE - LAST_DATE)* 24 * 60) AS FREQ_MINUTE
         , TO_CHAR(next_DATE, 'Dy') AS WEEKDAY_VALUE
         , TO_NUMBER(TO_CHAR(LAST_DATE, 'DD')) as DAY_VALUE
         , TO_NUMBER(TO_CHAR(LAST_DATE, 'HH24')) as HOUR_VALUE
         , TO_NUMBER(TO_CHAR(LAST_DATE, 'MI')) as MINUTE_VALUE
         , INTERVAL
   FROM   dba_JOBS
  ),
 queryinterval  AS (
 SELECT  job,
 nvl(
CASE FREQ_MONTH
    WHEN 1 THEN
         'FREQ=MONTHLY;' || 'BYMONTHDAY='|| day_value || ';' ||
         'BYHOUR='||  hour_value || ';' || 'BYMINUTE=' || minute_value || ';'
    ELSE
      CASE freq_day
       WHEN 7 THEN
          'FREQ=WEEKLY;' || 'BYDAY='||  weekday_value || ';'
          || 'BYHOUR='||  hour_value || ';' || 'BYMINUTE=' ||  minute_value || ';'
      WHEN 1 THEN
           'FREQ=DAILY;' || 'BYHOUR='||  hour_value || ';' || 'BYMINUTE=' ||  minute_value || ';'
      ELSE
       CASE
         WHEN FREQ_MINUTE=60 THEN
            'FREQ=HOURLY;' || 'INTERVAL=1;'
          WHEN FREQ_MINUTE<60 THEN
            'FREQ=MINUTELY;' || 'INTERVAL=' || FREQ_MINUTE || ';'
        END
      END
    END,INTERVAL)  intervalvalue
    FROM queryintervaloriginal
  ),
 queryjobs AS (
select 'dbms_scheduler.create_job( ' || chr(10)
|| ' job_name=>'||''''||'"' || schema_user ||'"."'|| substr(upper(translate(what,'.(),;','_')),1,20) ||'_JOB"' ||''''||', ' || chr(10)
|| ' job_type=> '||''''||'PLSQL_BLOCK'||''''||',' || chr(10)
|| ' job_action=> '||''''||'"begin ' || what || ' end;"'||''''||', ' || chr(10)
|| ' start_date => to_timestamp('||''''|| to_char(next_date,'mm/dd/yyyy hh24:mi:ss')
||''''||','||''''|| 'mm/dd/yyyy hh24:mi:ss' ||''''||'), ' || chr(10)
|| DECODE (interval,'null',NULL, ' repeat_interval => ' ||''''||
 (SELECT a.intervalvalue FROM  queryinterval a WHERE a.job = dba_jobs.job)
|| ''''||', ' || chr(10) )
|| ' enabled => true, auto_drop=> false, ' || chr(10)
|| ' comments => '||''''||'Converted from job ' || job || ''''  || chr(10)
|| ');' || chr(10) jobname
from dba_jobs
where broken = 'N'
-- and rownum <=1
)
 SELECT * FROM queryjobs
/

PRO
PRO
PRO +------------------------------------------------------------------------------+
PRO |           List of Jobs for this database                                     |
PRO +------------------------------------------------------------------------------+
PRO

select to_char(job,'999999') job, substr(schema_user,1,20) schema_user,
substr(log_user,1,20)  log_user,
next_date, next_sec, interval, what
from dba_jobs
order by schema_user
/

-- Se existe algum JOB no SYS e so copiar para outro esquema e pegar o codigo.
-- exec dbms_scheduler.copy_job('SYS.CLEANUP_ONLINE_IND_BUILD','DBACLASS.CLEANUP_ONLINE_IND_BUILD');

@report/sql/footerhtml01
