DEFINE vhtmlpage='index_rman_'
DEFINE vtitlethispage='Backup rman report'
DEFINE viconthispage='backup.svg'

@report/sql/headerhtmlspool.sql
-- @report/sql/page_label "&vtitlethispage"


PRO <body>

PRO <p>&varhtmlspace</p>
PRO <hr style="height:5px;border-width:0;color:gray;background-color:gray">
PRO <h1>  Rman backup report  </h1>
PRO <h3>01 - <a title="Rman backup"  href="list_rmanbkp01_&var_namefile">Rman backup</a></h3>
PRO <h3>02 - <a title="Backup Spfile"  href="list_rman_backupspfile01_&var_namefile">Backup Spfile</a></h3>
PRO <h3>03 - <a title="Backup Size"  href="list_rman_backupsize01_&var_namefile">Backup Size</a></h3>
PRO <h3>04 - <a title="Backup Set"  href="list_rman_backupset01_&var_namefile">Backup Set</a></h3>
PRO <h3>05 - <a title="Backup Piece"  href="list_rman_backuppiece01_&var_namefile">Backup Piece</a></h3>
PRO <h3>06 - <a title="Backup Jobs"  href="list_rman_backupjob01_&var_namefile">Backup Jobs</a></h3>


PRO <p>&varhtmlspace</p>





@report/sql/footerhtml01
