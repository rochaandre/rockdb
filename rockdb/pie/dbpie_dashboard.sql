
SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO &var_outputfolder/dbpie_dashboard_&var_namefile
@report/sql/headerdoc.sql &var_outputfolder/dbpie_dashboard&var_namefile "dbpie_dashboard" "dbpie_dashboard" "" ""

PRO <html>
PRO   <head>
PRO   </head>
PRO   <body>
--PRO <hr style="height: 12px; border-width: 0; color: black; background-color: black;" />
--PRO <h1 style="text-align: center;">Oracle Database Health Check</h1>
--PRO <hr style="height: 12px; border-width: 0; color: black; background-color: black;" />
PRO <p style="font-size: 1.5em;">
--PRO
--PRO <hr style="height: 5px; border-width: 0; color: gray; background-color: gray;" />
--PRO <h2 style="text-align: center;">General Check</h2>
--PRO <hr style="height: 5px; border-width: 0; color: gray; background-color: gray;" />
--PRO

PRO <table>
PRO     <tbody>




PRO     <tr>
PRO     <td>
PRO       <iframe src="dbpie_disabled_trigger01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_disabled_trigger02_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_rowlockwaits01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     </tr>


PRO     <tr>
PRO     <td>
PRO       <iframe src="dbpie_rowlockwaits02_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_physicalwaits01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_physicalwaits02_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     </tr>




PRO     <tr>
PRO     <td>
PRO       <iframe src="dbpie_shared_pool01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_shared_poolcontents01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_shared_poolcontents02_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     </tr>




PRO     <tr>
PRO     <td>
PRO       <iframe src="dbpie_object_invalid01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_object_invalid02_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_object_types01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     </tr>



PRO     <tr>
PRO     <td>
PRO       <iframe src="dbpie_index_unusable01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_index_unusable02_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_index_unusable02_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     </tr>



PRO     <tr>
PRO     <td>
PRO       <iframe src="dbpie_object_schema01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_object_schema02_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_segment_maxtable01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     </tr>


PRO     <tr>
PRO     <td>
PRO       <iframe src="dbpie_segment_maxsegment01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_segment_maxindex01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_segment_bigobjects01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     </tr>


PRO     <tr>
PRO     <td>
PRO       <iframe src="dbpie_resource_maxused01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_resource_maxlimit01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_resource_current01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     </tr>


PRO     <tr>
PRO     <td>
PRO       <iframe src="dbpie_sga_pool01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_large_pool01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_result_cache01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     </tr>


PRO     <tr>
PRO     <td>
PRO       <iframe src="dbpie_shared_pool01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_shared_poolcontents01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_shared_poolcontents02_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     </tr>


PRO     <tr>
PRO     <td>
PRO       <iframe src="dbpie_bufferbusywaits01_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_bufferbusywaits02_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     <td>
PRO       <iframe src="dbpie_bufferbusywaits03_&var_namefile" height="380" width="430"  onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
PRO     </td>
PRO     </tr>

PRO
PRO     </tbody>
PRO </table>
PRO
PRO   </body>
PRO </html>
SPO OFF;
SET HEA ON LIN 80 NEWP 1 PAGES 14 FEED ON ECHO OFF VER ON LONG 80 LONGC 80 WRA ON TRIMS OFF TRIM OFF TI OFF TIMI OFF ARRAY 15 NUM 10 NUMF "" SQLBL OFF BLO ON RECSEP WR;
