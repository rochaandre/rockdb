DEFINE vbarlabel='&1'


PRO <PRE>
PRO <table>
PRO <tbody>
PRO <tr>
PRO <td>+</td>
PRO <td>----------------------------------------------------------------------------------------------------------------------------</td>
PRO <td>+</td>
PRO </tr>
PRO <tr>
PRO bordercolor="white"
select '<td>|</td>'
from dual
where '&vbarlabel' is not null;
select '<td style='||''''||'text-align:center; vertical-align:middle'||''''||'>&vbarlabel</td>'
from dual
where '&vbarlabel' is not null;

select '<td>|</td>'
from dual
where '&vbarlabel' is not null;

PRO </tr>
PRO <tr>
PRO bordercolor="white"

PRO <td>+</td>


select '<td>----------------------------------------------------------------------------------------------------------------------------</td>'
from dual
where '&vbarlabel' is not null;

select '<td>+</td>'
from dual
where '&vbarlabel' is not null;

PRO </tr>
PRO </tbody>
PRO </table>
PRO </PRE>
