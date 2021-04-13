
SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO &var_outputfolder/dbgauge_dashboard_&var_namefile

@rockdb/sql/headerdoc.sql &var_outputfolder/dbgauge_dashboard&var_namefile "dbgauge_dashboard" "" "" ""

PRO <html>
PRO   <head>
PRO   </head>
PRO   <body>
--PRO <hr style="height: 12px; border-width: 0; color: black; background-color: black;" />
--PRO <h1 style="text-align: center;">Performance Database Health check</h1>
--PRO <hr style="height: 12px; border-width: 0; color: black; background-color: black;" />
PRO <p style="font-size: 1.5em;">
--PRO
--PRO <hr style="height: 5px; border-width: 0; color: gray; background-color: gray;" />
--PRO <h2 style="text-align: center;">General Performance</h2>
--PRO <hr style="height: 5px; border-width: 0; color: gray; background-color: gray;" />
--PRO


PRO <table>
PRO     <tbody>


PRO <tr>
PRO  <td>
PRO      <iframe src="dbgauge_invalidobj_&var_namefile" height="210" width="210"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO  </td>
PRO  <td>
PRO      <iframe src="dbgauge_opencursors_&var_namefile" height="210" width="210"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO  </td>
PRO  <td>
PRO      <iframe src="dbgauge_outstandingalerts_&var_namefile" height="210" width="210"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO  </td>
PRO  <td>
PRO      <iframe src="dbgauge_pga_&var_namefile" height="210" width="210"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO  </td>
PRO  <td>
PRO      <iframe src="dbgauge_processes_&var_namefile" height="210" width="210"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO  </td>
PRO </tr>
PRO <tr>
PRO  <td>
PRO      <iframe src="dbgauge_sessions_&var_namefile" height="210" width="210"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO  </td>
PRO  <td>
PRO      <iframe src="dbgauge_transaction_&var_namefile" height="210" width="210"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO  </td>
PRO  <td>
PRO      <iframe src="dbgauge_usedspace_&var_namefile" height="210" width="210"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO  </td>
PRO  <td>
PRO      <iframe src="dbgauge_invalidobj_&var_namefile" height="210" width="210"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO  </td>
PRO  <td>

PRO  </td>
PRO </tr>

PRO
PRO     </tbody>
PRO </table>
PRO
PRO   </body>
PRO </html>
SPO OFF;
SET HEA ON LIN 80 NEWP 1 PAGES 14 FEED ON ECHO OFF VER ON LONG 80 LONGC 80 WRA ON TRIMS OFF TRIM OFF TI OFF TIMI OFF ARRAY 15 NUM 10 NUMF "" SQLBL OFF BLO ON RECSEP WR;
