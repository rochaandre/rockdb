DEFINE vhtmlpage='list_script_preexportdb01_'
DEFINE vtitlethispage='Pre export'
DEFINE viconthispage='card-list.svg'
@rockdb/sql/headerhtmlspool.sql


PRO   <body>
PRO <p>&varhtmlspace</p>
PRO <p>&varhtmlspace</p>
PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Parameters non default </h1>

select * from (
SELECT  '<br>'||'alter system set '|| name ||'='||
decode(TYPE, 1, '"'||DISPLAY_VALUE  ||'"',
2,'"'||DISPLAY_VALUE  ||'"',
3,DISPLAY_VALUE,DISPLAY_VALUE) || ' scope='||
decode(ISSES_MODIFIABLE,'FALSE','SPFILE','BOTH')
||' sid=' ||''''|| '*'||'''' ||';', ' ' value
from v$parameter
where isdefault = 'FALSE'
AND (  value is not NULL
or trim(value) <>'')
order by name
)
/

PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Object directory </h1>
@rockdb/sql/directory.ddl &varnewline

PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Role </h1>
@rockdb/sql/directory.ddl &varnewline

PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Public synonym </h1>

PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Database trigger </h1>

PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Database Jobs </h1>

PRO <p>&varhtmlspace</p>
PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  ACL list </h1>

PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Java Class </h1>

PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Tablespaces </h1>

PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Users </h1>

PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Grants objects </h1>

PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Grants roles </h1>

PRO     <p>&varhtmlspace</p>
PRO   </body>
PRO </html>
@rockdb/sql/footerhtml01
